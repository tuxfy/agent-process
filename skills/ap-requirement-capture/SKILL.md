---
name: ap-requirement-capture
description: Stufe 1 des Agent-Prozesses (`_agent-process`) – hält eine neue Idee oder einen Bug kurz als Issue beim Hoster fest, ohne sie zu lösen. Nutzen, wenn der Nutzer einen Fehler oder Wunsch meldet oder im Gespräch etwas Neues aufkommt. Nicht für Fehler einer Anforderung, die noch in Arbeit ist (zurück in deren Umsetzung), und nicht zum Ausarbeiten eines Issues (Skill ap-requirement-refine).
---

# Stufe 1: Idee oder Bug

Festhalten, nicht lösen. Issue bewusst kurz: zum **Festhalten,** nicht Refinement.

| Art | Label | Text nach | Inhalt |
|---|---|---|---|
| **Idee** — etwas Neues oder anders | `idee` | `_agent-process/anweisungen/vorlagen/idee.md` | was stört oder fehlt · Ziel · ggf. Idee zur Lösung |
| **Bug** — etwas funktioniert nicht wie festgelegt | `bug` | `_agent-process/anweisungen/vorlagen/bug.md` | was passiert · was erwartet war · wie es auftritt · Stand · Schwere |

-   **Zuerst festhalten:** meldet der Nutzer einen Fehler oder Wunsch oder kommt im Gespräch Neues auf: nicht sofort beheben, planen oder Code schreiben; auch nicht „schnell nebenbei".
-   **Fehler einer Anforderung in Arbeit** (vor der Abnahme): kein eigener Bug, zurück in deren Stufe 5. Fehler an Abgenommenem oder Ausgeliefertem: eigener Bug.
-   **Vorher suchen:** offene und geschlossene Issues zum Thema (`gh issue list --state all --search …` bzw. `glab issue list --all --search …`):
    -   dasselbe Anliegen, Issue offen → Nummer nennen, Neues als Kommentar dazu; ist es schon aufgegriffen, auch den Branch nennen (der Kommentar erreicht das Dokument nicht von selbst);
    -   Issue geschlossen → neues Issue mit Verweis `#<alt>`;
    -   unklar, ob dasselbe → fragen.
-   **Ziel statt Lösung** (nur Idee):
    -   Ziel bestimmt der Nutzer; genannte Lösung (z. B. Technik, Format) kommt unter „Idee zur Lösung"; sonst wird sie gebaut, ohne dass jemand die übliche Lösung prüft.
    -   Ziel fehlt → beim Festhalten einmal fragen, was danach anders sein soll; weiß der Nutzer es nicht: `offen` (Klärung holt es nach).
-   **Anlegen:** Issue beim Hoster des Projekts (`gh issue create` bzw. `glab issue create`): Titel kurz und sprechend, Label laut Tabelle, Text nach Vorlage mit ersetzten Platzhaltern. Kein Branch, kein Commit. Nummer nennen (`#<Nummer>`).
-   **Anlegen geht nicht** (Befehl fehlt, keine Rechte, Hoster nicht erreichbar): Titel, Label, Text zum Kopieren ausgeben; Nutzer legt an, Agent arbeitet weiter. Fehlt nur das Label: ohne Label anlegen, dem Nutzer sagen.
-   **Festhalten darf jeder:** Nutzer auch direkt beim Hoster, Agent auch mitten im Gespräch; laufende Arbeit bleibt, wie sie ist.
-   **Nicht von sich aus ausschärfen;** erst, wenn der Nutzer das Issue aufgreift (→ Stufe 2).

## Weg eines Bugs

Wie jede Anforderung ab der Klärung; Besonderheiten: `_agent-process/skills/ap-requirement-refine/klaeren.md`, „Bugs".
