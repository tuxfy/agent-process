# Stufe 8a: Inhalt und Version

-   **Start:** Nutzer sagt „release" (wann, entscheidet er). Zuerst `release-candidate` auf aktuellen Stand bringen (`_agent-process/AGENTS.md`, „Git", „Aktueller Stand"; holt auch die Tags; die setzen Nutzer bzw. CI, Version zählt ab dem letzten).
-   **Inhalt:** alle Anforderungen, seit dem letzten Tag nach `release-candidate` zusammengeführt (laut Git-Verlauf; Dokumente in `_requirements/done/`).
-   **Ausnahme, eine soll doch nicht mit:** nach Rückfrage per Revert-Commit auf `release-candidate` herausnehmen; kommt mit einem späteren Release. Regelfall: gar nicht erst zusammenführen.
-   **Version bestimmen;** Grundlage: Commits auf `release-candidate` seit dem letzten Tag `v<x.y.z>` (bei Zusammenführen per „Squash": Titel der Pull Requests):

    | Enthalten | ab Version 1.0.0 | vor 1.0.0 |
    |---|---|---|
    | mindestens eine Änderung mit `!` (bricht Bestehendes) | Major: `x+1.0.0` | Minor: `0.y+1.0` |
    | mindestens ein `feat` | Minor: `x.y+1.0` | Minor: `0.y+1.0` |
    | sonst (`fix`, `refactor`, `test`, `chore`, `design`) | Patch: `x.y.z+1` | Patch: `0.y.z+1` |

    -   **Höchste** Stufe gilt. Erstes Release ohne vorherigen Tag: `0.1.0`.
    -   **Gegenprobe** mit den Anforderungen: Feature ohne `feat`-Commit (oder Bug mit `feat`)? Dann stimmen die Commit-Typen nicht: dem Nutzer melden, nicht still korrigieren.
    -   Sprung auf **1.0.0** entscheidet nur der Nutzer.
    -   Seit dem letzten Tag nur `chore`, `test` oder `refactor`: dem Nutzer vorschlagen, ob sich ein Release lohnt.
-   **Agent legt die Version nach der Tabelle fest,** nennt Inhalt, Version und Begründung (je Stufe die ausschlaggebenden Commits); wartet nicht auf Bestätigung. **Fragt nur,** wenn die Gegenprobe nicht stimmt, 1.0.0 in Frage kommt oder nur `chore`, `test`, `refactor` enthalten sind.
-   Dann `_releases/<version>.md` nach `_agent-process/anweisungen/vorlagen/release.md` auf `release-candidate` anlegen (Inhalt mit relativen Links auf die Anforderungen in `_requirements/done/`); committen, pushen.
