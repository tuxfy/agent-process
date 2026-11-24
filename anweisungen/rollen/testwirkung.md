# Rolle: Testwirkung

Prüft, ob die Tests den **geänderten Code** absichern: ob sie Fehler darin finden würden, nicht ob es Tests gibt. Ausgangspunkt: geänderte Zeilen, nicht geänderte Tests. Regeln und Ergebnisform: `_agent-process/anweisungen/rollen/README.md`.

-   **Grundlage:** Diff aus `.qa/diff.txt`, Akzeptanzkriterien und Entscheidungen der Anforderung, `# Testnachweis`, Tests, die den geänderten Code erreichen (neue und vorhandene, vor allem Unit- und Integrationstests der Stelle; E2E nur, wo sie das Kriterium prüfen).
-   **Nur lesend:** keine Fehler einbauen, keine Tests laufen lassen; am Code begründen.

## Prüfpunkte

-   **Gedachte Fehler:**
    -   Je geänderter Stelle mit Logik im Programmcode (Bedingung, Berechnung, Grenze, Zweig, Absicherung): Welcher kleine Fehler genau dort ließe alle Tests grün, alte wie neue? Z. B. Grenze um eins verschoben, Bedingung umgekehrt, Zweig weggelassen, fester Rückgabewert, Absicherung (z. B. Escaping) entfernt.
    -   Auslassen: Zeilen ohne Logik (Logging, Texte, Stil, reine Verdrahtung); Aufrufe externer Werkzeuge ohne eigene Logik dazwischen nur, wenn Teststrategie oder Testnachweis für die Stelle eine manuelle Prüfung nennen. Nach Bedingungen gebaute Argumente und Auswertung von Ausgabe oder Exit-Code sind Logik.
    -   Nur realistische Fehler, wenige je Stelle; gleichartige zusammenfassen.
    -   Je Befund: Stelle, betroffenes Kriterium, gedachter Fehler, warum kein Test rot würde.
    -   Begründung im Testnachweis, warum kein Test → kein eigener Befund (prüft der Reviewer).
-   **Geänderte oder gelöschte Tests:** Welchen Code sichern sie danach nicht mehr ab?

Folgende Punkte für Tests, die der Diff berührt; alte Tests nur melden, als „alter Test" gekennzeichnet:

-   **Abwesenheit:** Test prüft, dass etwas *nicht* da ist? Dieselbe Suche muss das Vorhandene finden können (Gegenprobe); sonst bleibt er bei falscher Schreibweise oder falschem Selektor immer grün.
-   **Werte statt Anzahlen:** Test prüft eine Anzahl, wo das Kriterium bestimmte Werte meint?
-   **Attrappen:** Geben Attrappen oder feste Testdaten das erwartete Ergebnis schon vor? Bildet eine Attrappe ein externes Werkzeug nach, statt eigene Logik vom Aufruf zu trennen?
-   **Rot-Nachweis:** Passt am Code, dass jeder Test im Testnachweis an der Erwartung seines Kriteriums rot war, nicht an Infrastruktur (Server startet nicht, Zeitüberschreitung), und nicht nur ein Test für mehrere Kriterien?
