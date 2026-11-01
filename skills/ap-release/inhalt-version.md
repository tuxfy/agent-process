# Stufe 8a: Inhalt und Version

-   **Start:** Der Nutzer sagt „release" — wann, entscheidet er. Zuerst `release-candidate` auf aktuellen Stand bringen (`_agent-process/AGENTS.md`, Abschnitt „Git", „Aktueller Stand"; holt auch die Tags — die setzen Nutzer bzw. CI, die Version zählt ab dem letzten).
-   **Inhalt:** alle Anforderungen, die seit dem letzten Tag nach `release-candidate` zusammengeführt wurden (laut Git-Verlauf; ihre Dokumente liegen in `_requirements/done/`).
-   **Ausnahme — soll eine davon doch nicht mit:** der Agent nimmt sie per Revert-Commit auf `release-candidate` wieder heraus (nach Rückfrage); sie kommt mit einem späteren Release. Der Regelfall ist, sie gar nicht erst zusammenzuführen.
-   **Version bestimmen** — Grundlage sind die Commits auf `release-candidate` seit dem letzten Tag `v<x.y.z>` (bei Zusammenführen per „Squash": die Titel der Pull Requests):

    | Enthalten | ab Version 1.0.0 | vor 1.0.0 |
    |---|---|---|
    | mindestens eine Änderung mit `!` (bricht Bestehendes) | Major: `x+1.0.0` | Minor: `0.y+1.0` |
    | mindestens ein `feat` | Minor: `x.y+1.0` | Minor: `0.y+1.0` |
    | sonst (`fix`, `refactor`, `test`, `chore`, `design`) | Patch: `x.y.z+1` | Patch: `0.y.z+1` |

    -   Es gilt die **höchste** Stufe. Erstes Release ohne vorherigen Tag: `0.1.0`.
    -   **Gegenprobe** mit den Anforderungen: Ist eine Anforderung ein Feature, aber kein `feat`-Commit dabei (oder ein Bug mit `feat`)? Dann stimmen die Commit-Typen nicht — dem Nutzer melden, nicht still korrigieren.
    -   Den Sprung auf **1.0.0** entscheidet nur der Nutzer.
    -   Enthält `release-candidate` seit dem letzten Tag nur `chore`, `test` oder `refactor`: dem Nutzer vorschlagen, ob sich ein Release überhaupt lohnt.
-   **Der Agent legt die Version nach der Tabelle fest** und nennt dem Nutzer Inhalt, Version und Begründung (je Stufe die ausschlaggebenden Commits) — ohne auf Bestätigung zu warten. **Er fragt nur,** wenn die Gegenprobe nicht stimmt, der Sprung auf 1.0.0 in Frage kommt oder `release-candidate` nur `chore`, `test` oder `refactor` enthält.
-   Dann legt der Agent `_releases/<version>.md` nach `_agent-process/anweisungen/vorlagen/release.md` auf `release-candidate` an — Inhalt mit relativen Links auf die Anforderungen in `_requirements/done/` —, committet und pusht.
