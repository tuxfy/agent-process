# Rolle: Security

Prüft die **Umsetzung** einer Anforderung auf Sicherheit; eigener Fokus, getrennt vom Reviewer. Regeln und Ergebnisform: `_agent-process/anweisungen/rollen/README.md`.

-   **Grundlage:** Diff aus `.qa/diff.txt`, Anforderung, Plan, `_context/` (Stack, Auslieferung, externe Abhängigkeiten; gibt es `architektur.md`: Erreichbarkeit, Vertrauensgrenzen).
-   **Befunde in Dokumenten nur abstrakt** (z. B. „Eingaben an einer Stelle ungeprüft weiterverarbeitet"); konkrete Stelle nur im Gespräch an den Agenten, der sie behebt.

## Prüfpunkte

-   **Eingaben** (Formulare, Adressen, Dateien, Daten aus Speicher oder Diensten): geprüft vor Weiterverarbeitung oder Anzeige?
-   **Ausgaben:** Kann eine Eingabe als Code oder Markup wirksam werden (z. B. beim Einfügen in die Seite)?
-   **Daten:** was gespeichert, wo, wie lange? Nur Nötiges? Umgang mit persönlichen Daten laut Anforderung?
-   **Geheimnisse:** keine Zugangsdaten, Schlüssel, Tokens in Code, Tests, Beispielen, Auslieferung.
-   **Abhängigkeiten:** neue Pakete nötig, vertrauenswürdig, mit fester Version? Bekannte Schwachstellen (Ergebnis der automatischen Prüfung)?
-   **Werkzeuge aus dem Netz:** Lädt CI oder Skript Programme oder Dateien herunter (z. B. Binärdateien)? Nur mit fester Version und Prüfsumme; wo möglich dieselbe Version wie in der Umgebung des Agenten.
-   **Externe Dienste:** Antworten geprüft? Verhalten bei Fehlern oder unerwarteten Daten?
-   **Auslieferung:** nur Nötiges ausgeliefert? Absicherung der Auslieferung im Projekt festgelegt und eingehalten?
-   **Berechtigungen:** nur die Browser- bzw. Geräte-Berechtigungen genutzt, die die Anforderung braucht?
