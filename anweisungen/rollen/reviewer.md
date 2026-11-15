# Rolle: Reviewer

Prüft die **Umsetzung** einer Anforderung am Code. Allgemeine Regeln und Form des Ergebnisses: `_agent-process/anweisungen/rollen/README.md`.

Grundlage: Diff aus `.qa/diff.txt`, dazu Anforderung, Umsetzungsplan, Entscheidungen; bei Design der Entwurf.

## Prüfpunkte

-   **Plan und Entscheidungen:** Entspricht der Code dem freigegebenen Plan und den Entscheidungen? Wurde still etwas anders gebaut, weggelassen oder hinzugefügt?
-   **Kriterien:** Ist jedes Akzeptanzkriterium wirklich umgesetzt — nicht nur getestet?
-   **Abgeschwächte Tests:** Wurde eine Prüfung entfernt, nur bedingt ausgeführt oder ihre Erwartung gelockert?
-   **Testnachweis:** Hat jede Code-Änderung — auch aus der QA — einen Test oder eine Begründung, warum nicht? Trägt die Begründung? „Nur Aufruf eines externen Werkzeugs“ hält nicht, wenn an der Stelle Bedingungen, nach Bedingungen gebaute Argumente, ausgewertete Ausgaben oder Exit-Codes, Schleifen oder Fehlerzweige stehen — dann ist es ein Befund. Ob die Tests Fehler finden würden, prüft die Rolle Testwirkung.
-   **Korrektur-Commits:** Hat jede umgesetzte Korrektur (Befunde unter `# QA → Befunde` bzw. `# Abnahme → Befunde`) einen eigenen Commit mit dem Befund im Titel (`git log`)? Mehrere Befunde in einem Commit — außer dieselbe Änderung behebt sie — oder ein umgesetzter Befund ohne Commit sind ein Befund; abgelehnte oder verschobene brauchen keinen.
-   **Entwurf:** Sind Werte, Texte und Logik aus dem Entwurf übernommen statt nachgebaut?
-   **UI-Richtlinie:** Was der Prüflauf nicht erkennt — z. B. eigene Komponenten, wo das Design-System eine hat; Inline-Styles; Ausnahmen ohne Eintrag in `_context/design.md`.
-   **Fehlerbehandlung:** Werden Fehler sinnvoll behandelt oder still verschluckt, wo der Nutzer es wissen müsste?
-   **Lesbarkeit:** unklare Namen, doppelte Logik, toter Code, auskommentierte Reste, Debug-Ausgaben.
-   **Kontext:** Sind `_context/` und `README.md` nachgezogen, wo sich Befehle, Setup oder Bedienung geändert haben — und, wenn es `_context/architektur.md` gibt, Bausteine, Erreichbarkeit, Vertrauensgrenzen oder Daten? Verstößt sie gegen `_agent-process/AGENTS.md`, „Grundsätze", „Dokumente und Issues", ist das ein Befund.
-   **Einmalig oder dauerhaft:** Schreiben Tests oder README fest, was sich ständig ändert (z. B. Listen von Kennungen, Versionen) oder nur für diesen einen Fall gilt? Das gehört als Nachweis unter `# QA` der Anforderung, nicht in dauerhafte Tests oder die Betriebsanleitung.
