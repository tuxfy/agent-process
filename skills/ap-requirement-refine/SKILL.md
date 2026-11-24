---
name: ap-requirement-refine
description: Stufen 2–4 des Agent-Prozesses (`_agent-process`) – macht aus einem aufgegriffenen Issue eine umsetzbare Anforderung (Klärung, Design, Refinement). Nutzen, wenn der Nutzer ein Issue (Idee oder Bug) aufgreift oder eine Anforderung mit Status new weiterführt. Nicht für Issues, die niemand aufgegriffen hat, und nicht zum Festhalten neuer Ideen oder Bugs (Stufe 1, `_agent-process/skills/ap-requirement-capture/SKILL.md`).
---

# Anforderung (Stufen 2–4)

Aus einem aufgegriffenen Issue wird eine umsetzbare Anforderung, auf ihrem Feature-Branch.

## Branch finden (wenn der Nutzer ein Issue aufgreift)

-   **Issue finden:** Keine Nummer genannt → suchen (`issue list --search`):
    -   ein Treffer → Nummer und Titel nennen, bestätigen lassen;
    -   mehrere → fragen;
    -   keiner → zuerst Stufe 1 (`_agent-process/skills/ap-requirement-capture/SKILL.md`).
-   **Schon aufgegriffen?** Issue mit Kommentaren lesen (`gh issue view --comments` bzw. `glab issue view --comments`).
    -   Kommentar „Aufgegriffen auf `<Branch>`" (bei mehreren: der jüngste), Branch beim Hoster vorhanden (nach `git fetch`) und Dokument nicht in `_requirements/done/` → auf den Branch wechseln, weiter nach der Tabelle unten. Passt keine Zeile: Skill-Tabelle in `_agent-process/AGENTS.md`; passt auch dort nichts: anhalten und fragen.
    -   Kommentar da, aber Bedingungen oben nicht erfüllt → anhalten und fragen (je Issue eine Anforderung; Folgearbeit an Abgenommenem = neues Issue mit Verweis `#<alt>`).
    -   Kein solcher Kommentar → neu aufgreifen (`klaeren.md`).
    -   Kein Zugriff auf Issues → Nutzer fragen, ob es schon einen Branch gibt; wenn ja, weiter wie beim Kommentar.

## Welche Datei

Laut Anforderungsdokument und Git-Verlauf des Branches; erste passende Zeile gilt. Nur diese Datei laden, ganz:

| Stand | Datei |
|---|---|
| Erste Anforderung aus Stufe 0 (`grundgeruest`, Status `new`) — Klärung und Design entfallen | `verfeinern.md` (Stufe 4) |
| Issue ohne Branch, oder auf seinem Branch noch kein Commit `chore(<kurzer-name>): Klärung` | `klaeren.md` (Stufe 2) |
| `new`, Klärung committet, im committeten Dokument „Design nötig? ja", Entwurf noch nicht committet (`_requirements/mockups/<kurzer-name>/`) | `entwerfen.md` (Stufe 3) |
| `new`, Klärung committet, im committeten Dokument „Design nötig? nein" oder Entwurf committet | `verfeinern.md` (Stufe 4) |

Danach: `_agent-process/skills/ap-requirement-build/SKILL.md`.
