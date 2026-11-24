# Stufe 5b–5e: Umsetzung

-   **Voraussetzung:** Plan freigegeben und committet (`planen.md`) bzw. Notiz aus dem kurzen Weg (`kurzer-weg.md`); Status `refined` (vor 5b) bzw. `in progress`; beim Rücksprung aus QA oder Abnahme auch `qa` bzw. `review`, dann ab 5c.
-   **Befehle:** `_context/projekt.md`.

## 5b: Start

-   Direkt nach der Plan-Freigabe, ohne weitere Freigabe; außer nach „später" (`_agent-process/AGENTS.md`, „Halten").
-   Vorher kein Code.
-   Status `in progress`, Commit `chore(<kurzer-name>): Start`, dann 5c.

## 5c: Test zuerst (rot)

Wo sinnvoll, zuerst ein Test, der das gewünschte Verhalten (bei Bugs: die Regression) absichert; Art laut Teststrategie der Anforderung.

-   Agent führt die Tests selbst aus; der neue Test muss **ohne die Änderung rot** sein.
-   Committet wird erst bei Grün.
-   Ergebnis unter `# Testnachweis → Rot`: Befehl, Anzahl bestanden/fehlgeschlagen, Namen der roten Tests.

## 5d: Umsetzen

Nach freigegebenem **Plan**, **Entscheidungen** der Anforderung und **UI-Richtlinie** (`_agent-process/skills/ap-guideline-ui/SKILL.md`).

-   **Abweichung vom Plan:**
    -   technisch und innerhalb der Entscheidungen → Plan aktualisieren, dem Nutzer sagen;
    -   berührt Umfang, Verhalten oder Entscheidungen → Grundsatzfrage, zurück ins Refinement.
-   **Neue Pakete:**
    -   nur, wenn im freigegebenen Plan (im kurzen Weg: Abbruchgrund);
    -   Lock-Datei (z. B. `package-lock.json`) ändert sich nur durch genau diese Installation; sonst aus ihr installieren (z. B. `npm ci`).
-   **Design:** Werte, Texte, Logik aus der abgelegten Quelle übernehmen, nicht nachempfinden.
-   **Neue Grundsatzfrage** (Architektur, Verhalten, Umfang): nicht selbst entscheiden; zurück ins Refinement, Nutzer fragen, Entscheidung festhalten.

## 5e: Grün

-   Alle Tests grün, vom Agenten ausgeführt; Ergebnis unter `# Testnachweis → Grün`.
-   **Sauberer Lauf** (Befehl in `_context/projekt.md`) grün; Ergebnis im Testnachweis.
-   Jedes Akzeptanzkriterium prüfen und abhaken; nur manuell Prüfbares für die Abnahme (Stufe 7) markieren.
-   **Prüflauf der UI-Richtlinie** (Befehl in `_context/projekt.md`); Ergebnis unter `# Testnachweis → UI-Richtlinie`.
-   **Prüflauf kann nicht laufen** (z. B. ohne Container und ohne CI): selbst nach festen Werten und Inline-Styles im geänderten Code suchen; im Testnachweis vermerken, dass der Prüflauf nicht lief.
-   Status `qa`; weiter mit `_agent-process/skills/ap-requirement-build/qa.md`.

## Commits

-   Umsetzung in einem oder mehreren Commits auf dem Feature-Branch; jeder grün, mit zugehörigem Stand des Testnachweises; nach jedem Commit pushen. Größere Pläne besser in mehreren Commits; Gepushtes übersteht einen Abbruch der Sitzung.
-   **Korrekturen aus QA (6c), Abnahme (7b), nach roter CI (6d):**
    -   je umgesetztem Befund ein eigener Commit `<typ>(<kurzer-name>): <Befund>` (meist `fix`, bei reinem Testzusatz `test`), mit eigenem Test oder Begründung im Testnachweis;
    -   mehrere Befunde nicht in einem Commit; außer dieselbe Änderung behebt sie: dann ein Befund, alle im Titel genannt;
    -   was mehrere Rollen zur selben Sache melden, ist ohnehin ein Befund (`_agent-process/anweisungen/einstufung.md`).
-   Fix-Branch aus 8b ist eine eigene Anforderung; für ihn gilt der Punkt davor.
-   Format und Regeln: `_agent-process/AGENTS.md`, „Git".
