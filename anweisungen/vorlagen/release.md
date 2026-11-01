-   **Version** <version>

*Fertig mit dem Release-Pull-Request (8b); bei erneutem 8b wird `# Gesamtprüfung` ersetzt; ab dem Zusammenführen nach `main` unverändert. Ob das Release live ist, zeigt der Tag `v<version>`.*

# Version

*Vom Agenten in 8a nach den Regeln in `_agent-process/skills/ap-release/inhalt-version.md` festgelegt.*

-   **Vorher:** `v<letzte version>` · **Neu:** `v<version>` · **Stufe:** Major | Minor | Patch
-   **Ausschlaggebend:** Commits bzw. Pull Requests (`#<Nummer>`), die die Stufe bestimmen
-   **Ersetzt:** *(nur nach einem fehlgeschlagenen Release)* `v<version>` (fehlgeschlagen)

# Inhalt

| Anforderung | Kurz |
|---|---|
| [`<Nr>-<kurzer-name>`](../_requirements/done/<Nr>-<kurzer-name>.md) | |

# Gesamtprüfung

*Vom Agenten in 8b ausgefüllt, bei erneutem 8b ersetzt.*

-   **Tests und Prüflauf:** `<Befehl>` — <Ergebnis>
-   **Automatische Prüfungen:** <Ergebnis>
-   **Klicktest (Hauptwege):** <Ergebnis>

# Zurückrollen

Wie der vorherige Stand wieder live geht (z. B. Revert in `main` und erneut ausliefern; Tag `v<vorherige version>`).

# Notizen

Was Nutzer der App wissen sollten (neu, geändert, behoben).
