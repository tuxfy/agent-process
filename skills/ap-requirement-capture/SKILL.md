---
name: ap-requirement-capture
description: Stufe 1 des Agent-Prozesses (`_agent-process`) – hält eine neue Idee oder einen Bug kurz im Backlog fest, ohne sie zu lösen. Nutzen, wenn der Nutzer einen Fehler oder Wunsch meldet oder im Gespräch etwas Neues aufkommt. Nicht für Fehler einer Anforderung, die noch in Arbeit ist (zurück in deren Umsetzung), und nicht zum Ausarbeiten eines Eintrags (Skill ap-requirement-refine).
---

# Stufe 1: Idee oder Bug

Festhalten, nicht lösen. Ein Eintrag ist bewusst kurz — er dient dem **Festhalten**, nicht dem Refinement.

| Art | Vorlage | Status | Inhalt |
|---|---|---|---|
| **Idee** — etwas Neues oder anders | `_agent-process/anweisungen/vorlagen/idee.md` | `idea` | was stört oder fehlt · was danach anders sein soll |
| **Bug** — etwas funktioniert nicht wie festgelegt | `_agent-process/anweisungen/vorlagen/bug.md` | `bug` | was passiert · was erwartet war · wie es auftritt · Stand |

-   Ablage: `_requirements/backlog/<kurzer-name>.md` auf dem Branch `backlog` (von `main`) — der kurze Name ist die Kennung der Anforderung; der Agent committet, pusht und eröffnet einen Pull Request bzw. ergänzt den offenen. Zusammengeführt wird er von der CI, wenn eingerichtet (Stufe 0), sonst vom Nutzer, wann es passt.
-   Festhalten darf **jeder** — auch der Agent mitten im Gespräch. Aus laufender Arbeit auf einem anderen Branch: nicht Committetes mit `git stash -u` sichern (auch neue Dateien), auf `backlog` wechseln, festhalten, zurückwechseln, `git stash pop`.
-   Der Agent schärft einen Eintrag **nicht von sich aus** aus; das passiert erst, wenn der Nutzer ihn aufgreift (→ Stufe 2).
-   **Meldet der Nutzer einen Fehler oder Wunsch** oder kommt im Gespräch etwas Neues auf: **zuerst** festhalten — nicht sofort beheben, planen oder Code schreiben. Auch nicht „schnell nebenbei".
-   Gehört ein Fehler zu einer Anforderung, die noch in Arbeit ist (vor der Abnahme): kein eigener Bug — zurück in deren Stufe 5. Gehört er zu etwas Abgenommenem oder Ausgeliefertem: eigener Bug.

## Weg eines Bugs

Wie jede Anforderung ab der Klärung; die Besonderheiten stehen in `_agent-process/skills/ap-requirement-refine/klaeren.md`, Abschnitt „Bugs".
