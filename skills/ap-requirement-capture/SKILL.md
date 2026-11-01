---
name: ap-requirement-capture
description: Stufe 1 des Agent-Prozesses (`_agent-process`) – hält eine neue Idee oder einen Bug kurz als Issue beim Hoster fest, ohne sie zu lösen. Nutzen, wenn der Nutzer einen Fehler oder Wunsch meldet oder im Gespräch etwas Neues aufkommt. Nicht für Fehler einer Anforderung, die noch in Arbeit ist (zurück in deren Umsetzung), und nicht zum Ausarbeiten eines Issues (Skill ap-requirement-refine).
---

# Stufe 1: Idee oder Bug

Festhalten, nicht lösen. Ein Issue ist bewusst kurz — es dient dem **Festhalten**, nicht dem Refinement.

| Art | Label | Text nach | Inhalt |
|---|---|---|---|
| **Idee** — etwas Neues oder anders | `idee` | `_agent-process/anweisungen/vorlagen/idee.md` | was stört oder fehlt · was danach anders sein soll |
| **Bug** — etwas funktioniert nicht wie festgelegt | `bug` | `_agent-process/anweisungen/vorlagen/bug.md` | was passiert · was erwartet war · wie es auftritt · Stand |

-   **Vorher suchen:** offene und geschlossene Issues nach dem Thema durchsuchen (`gh issue list --state all --search …` bzw. `glab issue list --all --search …`). Dasselbe Anliegen, Issue offen: dem Nutzer die Nummer nennen, Neues als Kommentar dazu (ist es schon aufgegriffen, auch den Branch nennen — der Kommentar erreicht das Dokument nicht von selbst); Issue geschlossen: neues Issue mit Verweis `#<alt>`; unklar, ob es dasselbe ist: fragen.
-   **Anlegen:** ein Issue beim Hoster des Projekts (`gh issue create` bzw. `glab issue create`) — Titel kurz und sprechend, Label laut Tabelle, Text nach der Vorlage mit ersetzten Platzhaltern. Kein Branch, kein Commit. Dem Nutzer die Nummer nennen (`#<Nummer>`).
-   **Geht das nicht** (Befehl fehlt, keine Rechte, Hoster nicht erreichbar): Titel, Label und Text zum Kopieren ausgeben; der Nutzer legt das Issue an, der Agent arbeitet weiter. Fehlt nur das Label: ohne Label anlegen und es dem Nutzer sagen.
-   Festhalten darf **jeder** — der Nutzer auch direkt beim Hoster, der Agent auch mitten im Gespräch; laufende Arbeit bleibt dabei, wie sie ist.
-   Der Agent schärft ein Issue **nicht von sich aus** aus; das passiert erst, wenn der Nutzer es aufgreift (→ Stufe 2).
-   **Meldet der Nutzer einen Fehler oder Wunsch** oder kommt im Gespräch etwas Neues auf: **zuerst** festhalten — nicht sofort beheben, planen oder Code schreiben. Auch nicht „schnell nebenbei".
-   Gehört ein Fehler zu einer Anforderung, die noch in Arbeit ist (vor der Abnahme): kein eigener Bug — zurück in deren Stufe 5. Gehört er zu etwas Abgenommenem oder Ausgeliefertem: eigener Bug.

## Weg eines Bugs

Wie jede Anforderung ab der Klärung; die Besonderheiten stehen in `_agent-process/skills/ap-requirement-refine/klaeren.md`, Abschnitt „Bugs".
