# Rolle: Reviewer

Prüft die **Umsetzung** einer Anforderung am Code. Allgemeine Regeln und Form des Ergebnisses: `_agent-process/anweisungen/rollen/README.md`.

Grundlage: Diff aus `.qa/diff.txt`, dazu Anforderung, Umsetzungsplan, Entscheidungen; bei Design der Entwurf.

## Prüfpunkte

-   **Plan und Entscheidungen:** Entspricht der Code dem freigegebenen Plan und den Entscheidungen? Wurde still etwas anders gebaut, weggelassen oder hinzugefügt?
-   **Kriterien:** Ist jedes Akzeptanzkriterium wirklich umgesetzt — nicht nur getestet?
-   **Abgeschwächte Tests:** Wurde eine Prüfung entfernt, nur bedingt ausgeführt oder ihre Erwartung gelockert?
-   **Testnachweis:** Hat jede Code-Änderung — auch aus der QA — einen Test oder eine Begründung, warum nicht? Ob die Tests Fehler finden würden, prüft die Rolle Testwirkung.
-   **Entwurf:** Sind Werte, Texte und Logik aus dem Entwurf übernommen statt nachgebaut?
-   **UI-Richtlinie:** Was der Prüflauf nicht erkennt — z. B. eigene Komponenten, wo das Design-System eine hat; Inline-Styles; Ausnahmen ohne Eintrag in `_context/design.md`.
-   **Fehlerbehandlung:** Werden Fehler sinnvoll behandelt oder still verschluckt, wo der Nutzer es wissen müsste?
-   **Lesbarkeit:** unklare Namen, doppelte Logik, toter Code, auskommentierte Reste, Debug-Ausgaben.
-   **Kontext:** Sind `_context/` und `README.md` nachgezogen, wo sich Befehle, Setup oder Bedienung geändert haben?
