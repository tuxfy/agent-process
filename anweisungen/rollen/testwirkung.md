# Rolle: Testwirkung

Prüft, ob die Tests den **geänderten Code** absichern — ob sie Fehler darin finden würden, nicht, ob es Tests gibt. Ausgangspunkt sind die geänderten Zeilen, nicht die geänderten Tests. Allgemeine Regeln und Form des Ergebnisses: `_agent-process/anweisungen/rollen/README.md`.

Grundlage: Diff aus `.qa/diff.txt`, Akzeptanzkriterien und Entscheidungen der Anforderung, `# Testnachweis`, die Tests, die den geänderten Code erreichen — neue wie vorhandene, vor allem Unit- und Integrationstests der Stelle; E2E-Tests nur, wo sie das Kriterium prüfen.

Nur lesend: Die Rolle baut keine Fehler ein und lässt keine Tests laufen, sie begründet am Code.

## Prüfpunkte

-   **Gedachte Fehler:** Je geänderter Stelle mit Logik im Programmcode (Bedingung, Berechnung, Grenze, Zweig, Absicherung) — welcher kleine Fehler genau dort ließe alle Tests grün, alte wie neue? Zum Beispiel eine Grenze um eins verschoben, eine Bedingung umgekehrt, ein Zweig weggelassen, ein fester Rückgabewert, eine Absicherung (z. B. Escaping) entfernt. Auslassen: Zeilen ohne Logik (Logging, Texte, Stil, reine Verdrahtung, Aufrufe externer Werkzeuge ohne eigene Logik dazwischen — nur, wenn Teststrategie oder Testnachweis für die Stelle eine manuelle Prüfung nennen; nach Bedingungen gebaute Argumente und die Auswertung von Ausgabe oder Exit-Code sind Logik). Nur realistische Fehler, wenige je Stelle; gleichartige zusammenfassen. Je Befund: Stelle, betroffenes Kriterium, gedachter Fehler, warum kein Test rot würde. Steht für die Stelle im Testnachweis eine Begründung, warum es keinen Test gibt: kein eigener Befund (die prüft der Reviewer).
-   **Geänderte oder gelöschte Tests:** Welchen Code sichern sie danach nicht mehr ab?

Die folgenden Punkte gelten für Tests, die der Diff berührt; an alten Tests nur melden und als „alter Test“ kennzeichnen:

-   **Abwesenheit:** Prüft ein Test, dass etwas *nicht* da ist? Dann muss dieselbe Suche das Vorhandene finden können (Gegenprobe) — sonst bleibt der Test bei falscher Schreibweise oder falschem Selektor immer grün.
-   **Werte statt Anzahlen:** Prüft ein Test eine Anzahl, wo das Kriterium bestimmte Werte meint?
-   **Attrappen:** Geben Attrappen oder feste Testdaten das erwartete Ergebnis schon vor? Bildet eine Attrappe ein externes Werkzeug nach, statt eigene Logik vom Aufruf zu trennen?
-   **Rot-Nachweis:** Passt am Code, dass jeder Test im Testnachweis an der Erwartung seines Kriteriums rot war — nicht an der Infrastruktur (Server startet nicht, Zeitüberschreitung) und nicht nur ein Test für mehrere Kriterien?
