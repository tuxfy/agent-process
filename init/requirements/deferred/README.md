# Zurückgestellt

Was bei der Arbeit gesehen und **bewusst verschoben** wurde — ein Befund, der nicht blockiert, oder ein Ziel, das aus einer Anforderung herausgetrennt wurde. Will es jemand umsetzen, ist es ein Issue (Stufe 1, `ap-requirement-capture`), kein Eintrag hier.

## Eintragen

-   **Eine Datei je Eintrag**, nur auf dem eigenen Branch: `<kurzer-name>-<n>.md`, Befunde aus der Gesamtprüfung `release-<version>-<n>.md`; `<n>` ist die nächste freie Nummer im Ordner. Bestehende Dateien anderer Anforderungen nicht ändern.
-   Committet wird mit dem Commit der Stufe, in der der Eintrag entsteht; in der Anforderung (z. B. unter `# QA → Befunde`) steht „zurückgestellt“ mit dem Dateinamen.
-   Inhalt:

    ```
    ---
    titel: <ein Satz>
    quelle: <kurzer-name bzw. release-<version>>, <Stufe>
    stelle: <optional; bei Sicherheitsthemen nur abstrakt>
    ---
    Begründung: <warum verschoben>
    ```

## Durchsehen

-   **Bei der Klärung neuer Arbeit:** nur lesen — den Ordner auf dem eigenen Branch und, nach `git fetch`, auf `origin/release-candidate` (`git ls-tree`, `git show`; gibt es ihn nicht, entfällt das). Passende Einträge dem Nutzer nennen; übernimmt die Anforderung einen, steht das mit dem Dateinamen in ihr. Gelöscht wird hier nichts.
-   **In der Gesamtprüfung (8b), auf `release-candidate`:** Übernommenes löschen — ein Eintrag ist übernommen, wenn eine Anforderung in diesem Release ihn mit Dateinamen nennt (`grep -r <datei> _requirements/`); Erledigtes löschen; was jetzt jemand will, als Issue festhalten (Stufe 1, `ap-requirement-capture`) und erst dann löschen, wenn es eine Issue-Nummer gibt — unter `# Gesamtprüfung` notieren (`<datei>` → `#<Nummer>`); ohne Nummer bleibt der Eintrag; der Rest bleibt. Nur hier wird gelöscht.

## Ohne `release-candidate` (Abkürzung)

Die Klärung liest nur den eigenen Branch. Aufgeräumt wird in 8b auf dem Feature-Branch, mit eigenem Commit `chore(<kurzer-name>): Zurückgestelltes aufgeräumt` — die Zuordnungen `<datei>` → `#<Nummer>` stehen dort in der Commit-Nachricht statt unter `# Gesamtprüfung`; Befunde aus 8b heißen dort `<kurzer-name>-<n>.md`.
