---
name: ap-requirement-refine
description: Stufen 2–4 des Agent-Prozesses (`_agent-process`) – macht aus einem aufgegriffenen Eintrag eine umsetzbare Anforderung (Klärung, Design, Refinement). Nutzen, wenn der Nutzer eine Idee oder einen Bug aufgreift oder eine Anforderung mit Status idea, bug oder new weiterführt. Nicht für Einträge, die niemand aufgegriffen hat, und nicht zum Festhalten neuer Ideen oder Bugs (Stufe 1, `_agent-process/skills/ap-requirement-capture/SKILL.md`).
---

# Anforderung (Stufen 2–4)

Aus einem aufgegriffenen Eintrag wird eine umsetzbare Anforderung, auf ihrem Feature-Branch. Welche Datei dran ist, zeigen das Anforderungsdokument und der Git-Verlauf des Branches. Es gilt die erste passende Zeile. Nur diese Datei laden — ganz:

| Stand | Datei |
|---|---|
| Erste Anforderung aus Stufe 0 (`grundgeruest`, Status `new`) — Klärung und Design entfallen | `verfeinern.md` (Stufe 4) |
| Status `idea` bzw. `bug`, oder `new` ohne Commit `chore(<kurzer-name>): Klärung` | `klaeren.md` (Stufe 2) |
| `new`, Klärung committet, im committeten Dokument „Design nötig? ja", Entwurf noch nicht committet (`_requirements/mockups/<kurzer-name>/`) | `entwerfen.md` (Stufe 3) |
| `new`, Klärung committet, im committeten Dokument „Design nötig? nein" oder Entwurf committet | `verfeinern.md` (Stufe 4) |

Danach: `_agent-process/skills/ap-requirement-build/SKILL.md`.
