# Prozessregeln

Prozess von der Idee bis zum Release — unabhängig von Sprache, Framework und Werkzeugen. Gilt in jedem Projekt, das dieses Prozess-Repo als Submodul unter `_agent-process/` einbindet. Projektspezifisches steht in der `AGENTS.md` des Projekts und in `_context/`.

## Ordner

| Ordner im Projekt | Inhalt | Gehört |
|---|---|---|
| `_agent-process/` | dieses Prozess-Repo: Prozessregeln, `anweisungen/` (eine Datei je Stufe, dazu `vorlagen/` und `rollen/`), Vorlagen für Init | Prozess-Repo — im Projekt nie ändern |
| `.claude/agents` | Link auf `_agent-process/.claude/agents/`: Prüfer-Rollen als Unteragenten für Claude Code | Prozess-Repo — im Projekt nie ändern |
| `_context/` | **Was** man über das Projekt wissen muss (Stack, Befehle, …) | Projekt |
| `_requirements/backlog/` | Ideen und Anforderungen in Klärung/Refinement, ohne Nummer | Projekt |
| `_requirements/` | `refined` (ohne Nummer) und ab Umsetzung bis zum Release (mit Nummer) | Projekt |
| `_requirements/done/` | abgenommene Anforderungen (ab Stufe 7c, eingefroren) | Projekt |
| `_releases/` | ein Dokument je Release: Inhalt, Gesamtprüfung, Zurückrollen | Projekt |
| `_design-system/` *(optional)* | Submodul des Design-Systems, nur lesen | Design-System — im Projekt nie ändern |

**Grundsatz:** Das Projekt läuft ohne `_agent-process/`. Bauen, Prüfen und Ausliefern (lokal und in der CI) nutzen nur, was im Projekt liegt — nie Dateien aus `_agent-process/`.

## Ablauf

| Stufe | Status | Anweisung |
|---|---|---|
| 0. Projekt einrichten *(einmal, bei Bedarf erneut)* | — | `_agent-process/anweisungen/00-einrichtung.md` |
| 1. Idee oder Bug | `idea` / `bug` | `_agent-process/anweisungen/01-idee.md` |
| 2. Klärung | `new` | `_agent-process/anweisungen/02-klaerung.md` |
| 3. Design *(nur bei Bedarf)* | `new` | `_agent-process/anweisungen/03-design.md` |
| 4. Refinement | `new` → `refined` *(mit der Freigabe des Plans bestätigt)* | `_agent-process/anweisungen/04-refinement.md` |
| 5. Umsetzung | `in progress` | `_agent-process/anweisungen/05-umsetzung.md` |
| 6. QA | `qa` | `_agent-process/anweisungen/06-qa.md` |
| 7. Abnahme | `review` → `accepted` | `_agent-process/anweisungen/07-abnahme.md` |
| 8. Release *(mehrere Anforderungen)* | — *(live ist, was in einem Release mit Tag steht)* | `_agent-process/anweisungen/08-release.md` |

Branches — `main` nur per Pull Request (beim Hoster erzwungen):

| Branch | Zweck | Weg nach `main` |
|---|---|---|
| `backlog` | neue Ideen und Bugs (Stufe 1) | Pull Request, Nutzer führt zusammen |
| `feature/<kurzer-name>` bzw. `fix/<kurzer-name>` | eine Anforderung ab ihrer Aufnahme (Stufe 2) bis zur Abnahme: Dokument, Plan, Code, QA | Pull Request nach `next` (Stufe 6/7) |
| `next` | dauerhafter Sammel-Branch: abgenommene Anforderungen bis zum nächsten Release, dazu das Release-Dokument | Pull Request nach `main` (Stufe 8) als Merge-Commit, danach Tag `v<version>` |

**Zusammenführen nach `next` heißt: kommt ins nächste Release.** Soll eine abgenommene Anforderung noch warten, bleibt ihr Pull Request offen.

Ist im Projekt „Zusammenführen = Ausliefern" festgelegt, entfällt `next` (siehe `08-release.md`, Abkürzung).

## Regeln

-   **Vor der Arbeit an einer Stufe** die zugehörige Anweisungsdatei lesen.
-   **Vor jeder Arbeit am Projekt** `_context/projekt.md` lesen, bei Design-Arbeit zusätzlich `_context/design.md`. Ist `_context/projekt.md` noch nicht ausgefüllt: zuerst Stufe 0.
-   Eine Stufe wird erst begonnen, wenn die vorherige abgeschlossen ist.
-   **Angehalten wird nur an den Freigaben** des Nutzers — Klärung (2), Entwurf (3b/3c), Plan (5a), Go (5b), Abnahme (7a/7c), „release" (8a), Zusammenführen (7c, 8c) — und wenn der Agent eine Entscheidung braucht. **Sonst geht er ohne Rückfrage zum nächsten Schritt weiter**, z. B. vom Refinement zum Plan, vom Go zum ersten Test, von 5e in die QA, nach grüner CI zum Abnahmepaket, von 8a zu 8b.
-   **Meldet der Nutzer einen Fehler oder Wunsch: zuerst als Bug bzw. Idee festhalten** (`_agent-process/anweisungen/01-idee.md`) — nicht sofort beheben. Code entsteht nur für eine Anforderung nach ihrem „Go" (Stufe 5).
-   **Abgenommene Anforderungsdokumente** (`accepted`, in `_requirements/done/`) und **Release-Dokumente nach dem Release** werden nicht mehr geändert; Nachträge gehören in eine neue Anforderung bzw. ins nächste Release.
-   **Verweise in Dokumenten:** zwischen Dokumenten als relative Markdown-Links; Pull Requests nur als `#<Nummer>`, CI-Läufe nur als Ergebnis mit Datum. Keine Adressen beim Hoster — weder Repo, Pull Requests, CI-Läufe noch die ausgelieferte App; lokale Adressen (z. B. `localhost`) und Platzhalter sind in Ordnung.
-   **Tests werden nie abgeschwächt,** um grün zu werden (Prüfung entfernt, nur bedingt ausgeführt, Erwartung gelockert). Passt ein Test nicht mehr zur Umgebung: die Umgebung des Tests anpassen, nicht die Prüfung.
-   **Am Ende jeder Stufe** sagt der Agent dem Nutzer kurz (Zusammenfassung im Gespräch, nicht im Dokument) — und macht weiter, wenn keine Freigabe ansteht: was erledigt ist, was als Nächstes kommt (Stufe bzw. Schritt und Anweisungsdatei) und was der Nutzer dafür tun oder entscheiden muss (z. B. Status setzen, freigeben, committen).
-   **Abhängigkeiten und Werkzeuge** (Pakete, Browser für Tests u. ä.) installiert der Agent **selbst in seiner Umgebung** (z. B. im Container), nach Rückfrage — nie auf dem Rechner des Nutzers und nie als Aufgabe an den Nutzer.
    -   Neue Pakete nur, wenn sie im freigegebenen Umsetzungsplan stehen.
    -   Die Lock-Datei (z. B. `package-lock.json`) ändert sich nur durch genau diese Installation; sonst wird aus ihr installiert (z. B. `npm ci`).
-   **Git:** Nur der Agent im Projekt (CLI) committet — externe Werkzeuge (z. B. ein Chat für den Entwurf) nie. Der Agent committet und pusht Arbeits-Branches selbst und eröffnet Pull Requests; **zusammenführen und taggen nur der Nutzer** — siehe Abschnitt „Commits".
-   **Kennung** einer Anforderung ist ihr kurzer Name (Dateiname im Backlog). Die **Nummer** wird erst beim „Go" vergeben (nur im Dateinamen, der Branch behält den kurzen Namen): höchste vergebene Nummer in `_requirements/` und `_requirements/done/` + 1, dreistellig mit führenden Nullen (`007-boulder-log.md`); Nummern werden nie wiederverwendet.

## Commits

Format: Conventional Commits mit dem kurzen Namen als Scope — `<typ>(<kurzer-name>): <details>`, `typ` ∈ `feat`, `fix`, `test`, `refactor`, `chore`, `design`; bricht eine Änderung Bestehendes: `!` nach dem Scope. Für Prozess-Dokumente ohne Code: `chore(<kurzer-name>): …`. **Titel von Pull Requests** folgen demselben Format — beim Zusammenführen per „Squash" (erlaubt für Pull Requests nach `next`) wird der Titel zur Commit-Nachricht und zählt für die Version (Stufe 8). Der Release-Pull-Request nach `main` wird nur als Merge-Commit zusammengeführt.

**Der Agent committet selbst** (ohne Rückfrage), nur an diesen Stellen — und **pusht nach jedem Commit sofort**:

| Stelle | Branch | Inhalt |
|---|---|---|
| Nach der Einrichtung (Stufe 0) | `feature/grundgeruest` | `_context/`, erste Anforderung |
| Neue Idee bzw. neuer Bug (Stufe 1) | `backlog` | Eintrag im Backlog |
| Nach der Klärung (2) | Feature-Branch | Anforderungsdokument |
| Nach freigegebenem Entwurf (3c) | Feature-Branch | Entwurf, Brief, Lücken |
| Nach dem Refinement (4) | Feature-Branch | Dokument nach `_requirements/`, Status `refined` |
| Nach freigegebenem Plan (5a) | Feature-Branch | Plan im Anforderungsdokument |
| Nach dem „Go" (5b) | Feature-Branch | Nummer im Dateinamen, Status `in progress` |
| Nach jedem grünen Schritt des Plans (5c–5e) | Feature-Branch | Code, Tests, Testnachweis |
| Je Korrektur in der QA (6c) bzw. Abnahme (7b) | Feature-Branch | Korrektur mit ihrem Test |
| Vor dem Pull Request (6d) | Feature-Branch | QA-Abschnitt, Status `review` |
| Nach der Abnahme (7c, 7d) | Feature-Branch | Status `accepted`, Abnahme, Rückblick, Dokument nach `_requirements/done/` — ein Commit, vor dem Zusammenführen |
| Im Release (8a, 8b) | `next` | Release-Dokument — fertig, bevor der Pull Request nach `main` eröffnet wird |

-   **Leitplanken** (in Stufe 0 festgelegt, im Grundgerüst eingerichtet): Vor jedem Commit laufen alle Prüfungen (ein Befehl) und die Prüfung des Commit-Formats. Der Agent umgeht sie nie (z. B. kein `--no-verify`).
-   Ein Commit mit rotem Test gibt es nicht: In 5c wird der rote Test nachgewiesen, committet wird erst der grüne Schritt.
-   **Pushen:** Der Agent pusht nur die Branches aus der Tabelle oben und eröffnet die Pull Requests — mit kurzer Beschreibung und Verweis auf das Anforderungs- bzw. Release-Dokument.
-   **Zusammenführen: nur der Nutzer** — im Pull Request beim Hoster. Ausnahme: Pull Requests von `backlog` führt die CI selbst zusammen, wenn das Projekt es eingerichtet hat (Stufe 0). **Tags** setzt die CI nach dem Release-Pull-Request, sonst der Nutzer (Stufe 8); der Agent nie.
-   **CI-Ergebnisse stehen im Pull Request, nicht in Dokumenten.** Anforderungs- und Release-Dokumente nennen den Pull Request (`#<Nummer>`), aber kein Ergebnis eines CI-Laufs — ein Eintrag danach bräuchte einen neuen Commit und damit einen neuen Lauf.
-   **Grün heißt grün in der CI.** Ein lokales Grün reicht nicht für Abnahme oder Tag; maßgeblich ist der CI-Lauf auf dem gepushten Branch.
-   **Nach jedem vom Nutzer zusammengeführten Pull Request** wechselt der Agent auf `main` und holt den aktuellen Stand: `git switch main`, dann `git pull --ff-only`. Auf `main` wird lokal nie committet — so bleibt der lokale `main` immer gleich dem beim Hoster.
-   **Gepushte Commits nie umschreiben.** Vor dem Push darf der Agent lokal aufräumen (`git commit --amend`, `git rebase`, `git reset` ohne `--hard`, `git stash`); danach nicht mehr.
-   **Git-Befehle:** Branch wechseln oder anlegen **nur mit `git switch`** (`git switch <branch>`, `git switch -c <branch>`); Datei auf den letzten Commit zurücksetzen mit `git restore <datei>`. **Nicht verwenden** — in der Umgebung des Agenten gesperrt, Versuche kosten nur Zeit: `git checkout`, `git merge`, `git reset --hard`, Push von Tags, `--force`, `--delete`, `git commit --no-verify`, `git -c …`, `git config` (schreiben). **Tags** legt der Agent nie an — `git tag` nur zum Auflisten (z. B. letzter Tag für die Version).

## UI-Richtlinie

Damit die App einheitlich aussieht, gilt bei **jeder** UI-Arbeit — mit oder ohne Stufe 3:

-   **Das Design-System ist die Richtlinie.** UI nur mit seinen Tokens und Komponenten; seine README-Regeln gelten.
-   **Keine festen Werte** für Farben, Maße, Abstände, Radien oder Schriftgrößen im App-Code — nur Tokens.
-   **Keine Inline-Styles** — Gestaltung steht nur in Stylesheets, damit sie prüfbar bleibt.
-   **Prüflauf:** Die Prüf-Konfiguration liegt im Projekt als `.stylelintrc.json` (von Init angelegt, Erklärung in `_agent-process/init/pruefung/README.md`) und läuft mit den Tests (im Container und in der CI). **Ausnahme** nur mit Markierung an der Stelle (mit Grund) und Eintrag in `_context/design.md`.
-   **Fehlt etwas im Design-System:** in `_context/design.md` benennen, im Projekt vorerst lokal umsetzen (mit Tokens), als Idee für das Design-System vermerken.
-   **Das Design-System wird im Projekt nie bearbeitet.**
