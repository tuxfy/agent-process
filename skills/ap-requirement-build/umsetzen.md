# Stufe 5b–5e: Umsetzung

Voraussetzung: Plan freigegeben und committet (`planen.md`) bzw. Notiz aus dem kurzen Weg (`kurzer-weg.md`), Status `refined` (vor 5b) bzw. `in progress` — beim Rücksprung aus QA oder Abnahme auch `qa` bzw. `review`, dann ab 5c; Befehle in `_context/projekt.md`.

## 5b: Start

-   Direkt nach der Freigabe des Plans, ohne weitere Freigabe — außer nach „später" (`_agent-process/AGENTS.md`, Abschnitt „Halten"). Vorher kein Code.
-   **Nummer vergeben:** höchste vergebene Nummer in `_requirements/` und `_requirements/done/` + 1. Datei umbenennen in `<Nr>-<kurzer-name>.md`, Nummer **dreistellig mit führenden Nullen** (z. B. `007-boulder-log.md`), damit die Dateien richtig sortiert werden; Nummern werden nie wiederverwendet. Die Nummer steht nur im Dateinamen: Branch und Ordner eines Entwurfs (`mockups/<kurzer-name>/`) behalten den kurzen Namen.
-   Status `in progress`; der Agent committet Umbenennung und Status (`chore(<kurzer-name>): Start, Nummer <Nr>`), dann folgt 5c.

## 5c: Test zuerst (rot)

-   Wo sinnvoll, zuerst einen Test schreiben, der das gewünschte Verhalten (bei Bugs: die Regression) absichert — Art laut Teststrategie der Anforderung.
-   Der Agent führt die Tests selbst aus; der neue Test muss **ohne die Änderung rot** sein. Ein Commit mit rotem Test gibt es nicht — committet wird erst der grüne Schritt.
-   Ergebnis unter `# Testnachweis → Rot`: Befehl, Anzahl bestanden/fehlgeschlagen, Namen der roten Tests.
-   Lässt sich ein Kriterium nicht sinnvoll automatisch testen: begründen, Prüfung erfolgt manuell in der Abnahme (Stufe 7).

## 5d: Umsetzen

-   Nach dem freigegebenen **Plan**, den **Entscheidungen** der Anforderung und der **UI-Richtlinie** (`_agent-process/skills/ap-guideline-ui/SKILL.md`).
-   **Abweichung vom Plan:** technisch und innerhalb der Entscheidungen → Plan aktualisieren und dem Nutzer sagen; berührt sie Umfang, Verhalten oder Entscheidungen → Grundsatzfrage, zurück ins Refinement.
-   **Neue Pakete** nur, wenn sie im freigegebenen Plan stehen (im kurzen Weg: Abbruchgrund). Die Lock-Datei (z. B. `package-lock.json`) ändert sich nur durch genau diese Installation; sonst wird aus ihr installiert (z. B. `npm ci`).
-   **Bei Design:** Werte, Texte und Logik aus der abgelegten Quelle übernehmen, nicht nachempfinden.
-   **Neue Grundsatzfrage** (Architektur, Verhalten, Umfang) → nicht selbst entscheiden: zurück ins Refinement, Nutzer fragen, Entscheidung festhalten.

## 5e: Grün

-   Alle Tests grün — vom Agenten ausgeführt. Ergebnis unter `# Testnachweis → Grün`.
-   **Sauberer Lauf** (Befehl in `_context/projekt.md`) grün — Ergebnis im Testnachweis.
-   Jedes Akzeptanzkriterium prüfen und abhaken; was nur manuell prüfbar ist, für die Abnahme (Stufe 7) markieren.
-   **Prüflauf der UI-Richtlinie** ausführen (Befehl in `_context/projekt.md`) — Ergebnis unter `# Testnachweis → UI-Richtlinie`.
-   **Kann der Prüflauf nicht laufen** (z. B. ohne Container und ohne CI): Der Agent sucht selbst nach festen Werten und Inline-Styles im geänderten Code und vermerkt im Testnachweis, dass der Prüflauf nicht lief.
-   Status `qa`; weiter mit `_agent-process/skills/ap-requirement-build/qa.md`.

## Commits

-   Der Agent committet nach dem freigegebenen Plan und nach **jedem grünen Schritt** des Plans auf dem Feature-Branch — mit dem zugehörigen Stand des Testnachweises. Format und Regeln: `_agent-process/AGENTS.md`, Abschnitt „Git".
