# AGENTS.md — Master-Havard (Store2Hydro RDT–GV–RPT)

## Prosjekt
NTNU Waterpower Laboratory masteroppgave om kompakt RDT–GV–RPT-konfigurasjon (Store2Hydro).
Skrives i LaTeX (ntnuthesis.cls). Akademisk språk på engelsk.

## Task-Observer aktivering
At the start of any task-oriented session — any interaction where you will
use tools and produce deliverables — invoke the task-observer skill before
beginning work. This ensures skill improvement opportunities are captured
throughout the session.

When loading any skill, check the observation log for OPEN observations
tagged to that skill. Apply their insights to the current work, even if
the skill file hasn't been updated yet. This enables immediate application
of observations before they're permanently integrated during the weekly
review.

Observation log: `.Codex/observations.md`

## Skills i bruk
- **akademisk-humanizer** — fjern AI-skrivemønstre fra thesis-tekst. VKL-modul er alltid på.
- **llm-council** — konsulter ChatGPT og Gemini via `scripts/query_llms.py` (leser `.env`).
- **task-observer** — observer arbeidsøkter og logg forbedringskandidater til `.Codex/observations.md`.

## Skill-forbedringer
Task-observer skal særlig følge med på:
- Mønstre i thesis-tekst som akademisk-humanizer ikke fanger
- Nye VKL-spesifikke fraser eller konvensjoner som dukker opp
- Terminologi fra RDT/GV/RPT-domenet som bør legges til humanizer-reglene
