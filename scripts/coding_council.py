#!/usr/bin/env python3
"""
Coding Council — redesigned multi-LLM review workflow.

Usage:
  python scripts/coding_council.py --task "<task>" --claude-solution "<solution>"

Flow:
  1. Send Claude's proposed solution to Codex for feedback/alternatives
  2. Write a comparison file to council/<timestamp>.md
  3. Run query_llms.py (ChatGPT + Gemini + Claude) with full project context
  4. Output structured JSON for Claude to synthesize into a final recommendation
"""

import os
import sys
import json
import subprocess
import argparse
from datetime import datetime
from typing import Tuple

CODEX_PATH  = r"C:\Users\haavahle\AppData\Roaming\npm\codex.cmd"
NODE_DIR    = r"C:\Program Files\nodejs"
COUNCIL_DIR = "council"
CLAUDE_MD   = "CLAUDE.md"
QUERY_LLMS  = os.path.join("scripts", "query_llms.py")


def get_env_with_node() -> dict:
    env = os.environ.copy()
    if NODE_DIR not in env.get("PATH", ""):
        env["PATH"] = NODE_DIR + os.pathsep + env.get("PATH", "")
    return env


def query_codex(prompt: str, timeout: int = 120) -> Tuple[bool, str]:
    try:
        result = subprocess.run(
            [CODEX_PATH, "exec", prompt],
            capture_output=True,
            text=True,
            encoding="utf-8",
            errors="replace",
            timeout=timeout,
            env={**get_env_with_node(), "PYTHONIOENCODING": "utf-8"},
            input="",
        )
        output = result.stdout.strip()
        if result.returncode == 0 and output:
            return True, output
        err = result.stderr.strip() or output
        return False, f"Codex error: {err}"
    except subprocess.TimeoutExpired:
        return False, "Codex timed out (120s)"
    except Exception as e:
        return False, f"Codex exception: {str(e)}"


def read_project_context() -> str:
    try:
        with open(CLAUDE_MD, "r", encoding="utf-8") as f:
            return f.read()
    except Exception:
        return "(CLAUDE.md not available)"


def write_council_file(task: str, claude_solution: str, codex_response: str, timestamp: str) -> str:
    os.makedirs(COUNCIL_DIR, exist_ok=True)
    path = os.path.join(COUNCIL_DIR, f"council_{timestamp}.md")
    with open(path, "w", encoding="utf-8") as f:
        f.write(f"# Coding Council — {timestamp}\n\n")
        f.write(f"## Task\n{task}\n\n")
        f.write(f"## Solution A: Claude's Proposal\n{claude_solution}\n\n")
        f.write(f"## Solution B: Codex Feedback / Alternative\n{codex_response}\n")
    return path


def run_verdict_query(task: str, claude_solution: str, codex_response: str) -> dict:
    context = read_project_context()
    verdict_prompt = (
        "You are a coding reviewer for the Store2Hydro NTNU master's thesis project "
        "(Python/LaTeX/MATLAB, RDT-GV-RPT hydraulic turbine research).\n\n"
        f"PROJECT CONTEXT:\n{context}\n\n"
        f"TASK: {task}\n\n"
        f"SOLUTION A (Claude's proposal):\n{claude_solution}\n\n"
        f"SOLUTION B (Codex feedback/alternative):\n{codex_response}\n\n"
        "Evaluate both solutions. Which is better for this project? "
        "Reply with: VERDICT: A / B / MERGE, then 2-3 sentences of reasoning."
    )

    try:
        result = subprocess.run(
            [sys.executable, QUERY_LLMS, verdict_prompt],
            capture_output=True,
            text=True,
            encoding="utf-8",
            errors="replace",
            timeout=180,
        )
        if result.returncode == 0 and result.stdout.strip():
            return json.loads(result.stdout.strip())
        return {"error": result.stderr.strip() or "query_llms returned no output"}
    except subprocess.TimeoutExpired:
        return {"error": "query_llms timed out"}
    except json.JSONDecodeError:
        return {"error": "Failed to parse query_llms output", "raw": result.stdout[:500]}
    except Exception as e:
        return {"error": str(e)}


def main():
    parser = argparse.ArgumentParser(description="Coding Council — multi-LLM solution review")
    parser.add_argument("--task", required=True, help="Task description")
    parser.add_argument("--claude-solution", required=True, help="Claude's proposed solution")
    args = parser.parse_args()

    task             = args.task
    claude_solution  = args.claude_solution
    timestamp        = datetime.now().strftime("%Y%m%d_%H%M%S")

    print("=== CODING COUNCIL ===", file=sys.stderr)
    print(f"Task: {task}\n", file=sys.stderr)

    # Step 1: Ask Codex to review Claude's proposal
    codex_prompt = (
        "You are a coding expert reviewing a proposed solution for an NTNU master's thesis project "
        "(Store2Hydro, Python/LaTeX/MATLAB, RDT-GV-RPT hydraulic turbines).\n\n"
        f"TASK: {task}\n\n"
        f"CLAUDE'S PROPOSED SOLUTION:\n{claude_solution}\n\n"
        "Provide: (1) what is good about this approach, (2) any risks or missing pieces, "
        "(3) any modifications or alternative you would recommend. Be specific and concise."
    )

    print("Querying Codex for feedback...", file=sys.stderr)
    codex_ok, codex_response = query_codex(codex_prompt)
    if not codex_ok:
        codex_response = f"[Codex unavailable: {codex_response}]"

    # Step 2: Write comparison file
    council_file = write_council_file(task, claude_solution, codex_response, timestamp)
    print(f"Council file written: {council_file}", file=sys.stderr)

    # Step 3: Run verdict through ChatGPT + Gemini + Claude
    print("Running verdict query via query_llms...", file=sys.stderr)
    verdict = run_verdict_query(task, claude_solution, codex_response)

    # Step 4: Output structured result for Claude to synthesize
    result = {
        "task": task,
        "timestamp": timestamp,
        "council_file": council_file,
        "codex": {
            "available": codex_ok,
            "response": codex_response,
        },
        "verdict": verdict,
    }

    print(json.dumps(result, indent=2, ensure_ascii=False))


if __name__ == "__main__":
    main()
