# Rolle: Reviewer

Prüft die **Umsetzung** einer Anforderung am Code. Regeln und Ergebnisform: `_agent-process/anweisungen/rollen/README.md`.

**Grundlage:** Diff aus `.qa/diff.txt`, Anforderung, Umsetzungsplan, Entscheidungen; bei Design der Entwurf.

## Prüfpunkte

-   **Plan und Entscheidungen:** Code entspricht freigegebenem Plan und Entscheidungen? Still etwas anders gebaut, weggelassen oder hinzugefügt?
-   **Kriterien:** jedes Akzeptanzkriterium wirklich umgesetzt, nicht nur getestet?
-   **Abgeschwächte Tests:** Prüfung entfernt, nur bedingt ausgeführt, Erwartung gelockert?
-   **Testnachweis:**
    -   jede Code-Änderung (auch aus der QA) mit Test oder Begründung, warum nicht? Trägt die Begründung?
    -   „Nur Aufruf eines externen Werkzeugs" hält nicht bei Bedingungen, nach Bedingungen gebauten Argumenten, ausgewerteter Ausgabe oder Exit-Code, Schleifen, Fehlerzweigen → Befund.
    -   Ob Tests Fehler finden würden: Rolle Testwirkung.
-   **Korrektur-Commits** (`git log`): jede umgesetzte Korrektur (Befunde unter `# QA → Befunde` bzw. `# Abnahme → Befunde`) mit eigenem Commit, Befund im Titel? Befund ist: mehrere Befunde in einem Commit (außer dieselbe Änderung behebt sie) oder umgesetzter Befund ohne Commit. Abgelehnte oder verschobene brauchen keinen.
-   **Entwurf:** Werte, Texte, Logik aus dem Entwurf übernommen statt nachgebaut?
-   **UI-Richtlinie:** was der Prüflauf nicht erkennt, z. B. eigene Komponenten statt vorhandener des Design-Systems, Inline-Styles, Ausnahmen ohne Eintrag in `_context/design.md`.
-   **Fehlerbehandlung:** sinnvoll behandelt oder still verschluckt, wo der Nutzer es wissen müsste?
-   **Lesbarkeit:** unklare Namen, doppelte Logik, toter Code, auskommentierte Reste, Debug-Ausgaben.
-   **Kontext:**
    -   `_context/` und `README.md` nachgezogen, wo sich Befehle, Setup oder Bedienung geändert haben?
    -   gibt es `_context/architektur.md`: Bausteine, Erreichbarkeit, Vertrauensgrenzen, Daten nachgezogen?
    -   Verstößt der nachgezogene Kontext gegen `_agent-process/AGENTS.md`, „Grundsätze", „Dokumente und Issues" → Befund.
-   **Einmalig oder dauerhaft:** Schreiben Tests oder README fest, was sich ständig ändert (z. B. Listen von Kennungen, Versionen) oder nur für diesen Fall gilt? Gehört als Nachweis unter `# QA` der Anforderung, nicht in dauerhafte Tests oder Betriebsanleitung.
