# CLAUDE.md — Master-Havard (Store2Hydro RDT–GV–RPT)

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

Observation log: `.claude/observations.md`

## Skills i bruk
- **akademisk-humanizer** — fjern AI-skrivemønstre fra thesis-tekst. VKL-modul er alltid på.
- **llm-council** — konsulter ChatGPT og Gemini via `scripts/query_llms.py` (leser `.env`).
- **task-observer** — observer arbeidsøkter og logg forbedringskandidater til `.claude/observations.md`.

## Coding Council — spør alltid først

Hver gang brukeren ber om en kodeoppgave skal Claude alltid stille dette spørsmålet først:

> "Vil du bruke coding council (Codex + ChatGPT + Gemini) eller skal jeg løse dette alene?"

**Hvis Ja — følg denne flyten nøyaktig:**

1. **Claude formulerer sin egen løsning** på oppgaven (komplett forslag, ikke bare skisse)
2. **Kjør council-scriptet** med Claudes forslag som input:
   ```
   python scripts/coding_council.py --task "<oppgaven>" --claude-solution "<løsningen>"
   ```
3. **Scriptet gjør automatisk:**
   - Sender Claudes forslag til Codex for feedback/alternativ (Solution B)
   - Skriver sammenligningsfil til `council/<timestamp>.md`
   - Kjører `query_llms.py` med ChatGPT + Gemini + Claude som votere
4. **Les JSON-output** — noter VERDICT fra hver voter (A / B / MERGE)
5. **Syntetiser vedtaket** og presenter anbefalt løsning til brukeren
6. **Implementer etter brukerens godkjenning**

**Hvis Nei** → Claude Code løser oppgaven selvstendig uten council

## Skill-forbedringer
Task-observer skal særlig følge med på:
- Mønstre i thesis-tekst som akademisk-humanizer ikke fanger
- Nye VKL-spesifikke fraser eller konvensjoner som dukker opp
- Terminologi fra RDT/GV/RPT-domenet som bør legges til humanizer-reglene
