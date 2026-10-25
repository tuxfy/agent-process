# Prozessregeln

Prozess von der Idee bis zum Release — unabhängig von Sprache, Framework und Werkzeugen. Gilt in jedem Projekt, das dieses Prozess-Repo als Submodul unter `_agent-process/` einbindet. Projektspezifisches steht in der `AGENTS.md` des Projekts und in `_context/`.

## Ordner

Im Projekt **nie ändern:** `_agent-process/` (dieses Prozess-Repo), `.claude/agents` (Link auf dessen Prüfer-Rollen), `_design-system/` (optional, nur lesen).

| Ordner | Inhalt |
|---|---|
| `_context/` | was man über das Projekt wissen muss (Stack, Befehle, …) |
| `_requirements/backlog/` | Ideen und Anforderungen bis zum Refinement, ohne Nummer |
| `_requirements/` | ab `refined`; Nummer ab dem „Go“ |
| `_requirements/done/` | abgenommen (ab 7c), eingefroren |
| `_releases/` | ein Dokument je Release |

**Grundsatz:** Bauen, Prüfen und Ausliefern (lokal und in der CI) nutzen nie Dateien aus `_agent-process/`.

## Ablauf

Je Stufe eine Anweisung in `_agent-process/anweisungen/`:

| Stufe | Status | Datei |
|---|---|---|
| 0. Projekt einrichten *(einmal)* | — | `00-einrichtung.md` |
| 1. Idee oder Bug | `idea` / `bug` | `01-idee.md` |
| 2. Klärung | `new` | `02-klaerung.md` |
| 3. Design *(bei Bedarf)* | `new` | `03-design.md` |
| 4. Refinement | `refined` | `04-refinement.md` |
| 5. Umsetzung | `in progress` → `qa` | `05-umsetzung.md` |
| 6. QA | `qa` → `review` | `06-qa.md` |
| 7. Abnahme | `accepted` | `07-abnahme.md` |
| 8. Release | — *(live ist, was einen Tag hat)* | `08-release.md` |

Branches — `main` nur per Pull Request (beim Hoster erzwungen):

| Branch | Zweck | Weg nach `main` |
|---|---|---|
| `backlog` | Ideen und Bugs (Stufe 1) | Pull Request |
| `feature/<kurzer-name>` bzw. `fix/<kurzer-name>` | eine Anforderung von Stufe 2 bis zur Abnahme | Pull Request nach `next` (6d) |
| `next` | Sammel-Branch bis zum nächsten Release, mit Release-Dokument | Pull Request nach `main` (8b), dann Tag |

**Zusammenführen nach `next` heißt: kommt ins nächste Release.** Ohne `next`: siehe Abkürzung in `08-release.md`.

## Regeln

-   **Vor der Arbeit an einer Stufe** die zugehörige Anweisungsdatei lesen.
-   **Vor jeder Arbeit am Projekt** `_context/projekt.md` lesen, bei Design-Arbeit zusätzlich `_context/design.md`. Ist `_context/projekt.md` noch nicht ausgefüllt: zuerst Stufe 0.
-   Eine Stufe wird erst begonnen, wenn die vorherige abgeschlossen ist.
-   **Angehalten wird nur an den Freigaben** des Nutzers — Klärung (2), Entwurf (3b/3c), Plan (5a), Go (5b), Abnahme (7a/7c), „release" (8a), Zusammenführen (7c, 8c) — und wenn der Agent eine Entscheidung braucht. **Sonst geht er ohne Rückfrage weiter.**
-   **Meldet der Nutzer einen Fehler oder Wunsch: zuerst als Bug bzw. Idee festhalten** (`_agent-process/anweisungen/01-idee.md`) — nicht sofort beheben. Code entsteht nur für eine Anforderung nach ihrem „Go" (Stufe 5).
-   **Abgenommene Anforderungsdokumente** (`accepted`, in `_requirements/done/`) und **Release-Dokumente nach dem Release** werden nicht mehr geändert; Nachträge gehören in eine neue Anforderung bzw. ins nächste Release.
-   **Prüfer-Rollen** (`_agent-process/anweisungen/rollen/`; welche wann, steht in 5a, 6 und 8b): unabhängige Prüfer mit frischem Blick, die nur lesen (Klicktester: App starten, Screenshots unter `.qa/`) — in Claude Code als Unteragenten unter `.claude/agents/`, sonst eigene Sitzung je Rolle. Mehrere laufen parallel; der Agent führt die Ergebnisse zusammen, doppelte Befunde zu einem mit Nennung aller Rollen.
-   **Sicherheitsthemen in Dokumenten nur abstrakt** (z. B. „Eingaben an einer Stelle ungeprüft weiterverarbeitet“); die konkrete Stelle nur im Gespräch.
-   **Verweise in Dokumenten:** zwischen Dokumenten als relative Markdown-Links; Pull Requests nur als `#<Nummer>`, CI-Läufe nur als Ergebnis mit Datum. Keine Adressen beim Hoster — weder Repo, Pull Requests, CI-Läufe noch die ausgelieferte App; lokale Adressen (z. B. `localhost`) und Platzhalter sind in Ordnung.
-   **Tests werden nie abgeschwächt,** um grün zu werden (Prüfung entfernt, nur bedingt ausgeführt, Erwartung gelockert). Passt ein Test nicht mehr zur Umgebung: die Umgebung des Tests anpassen, nicht die Prüfung.
-   **Am Ende jeder Stufe** sagt der Agent kurz im Gespräch: was erledigt ist, was als Nächstes kommt, was der Nutzer tun oder entscheiden muss.
-   **Abhängigkeiten und Werkzeuge** (Pakete, Browser für Tests u. ä.) installiert der Agent **selbst in seiner Umgebung** (z. B. im Container), nach Rückfrage — nie auf dem Rechner des Nutzers und nie als Aufgabe an den Nutzer.
    -   Neue Pakete nur, wenn sie im freigegebenen Umsetzungsplan stehen.
    -   Die Lock-Datei (z. B. `package-lock.json`) ändert sich nur durch genau diese Installation; sonst wird aus ihr installiert (z. B. `npm ci`).
-   **Git:** Nur der Agent im Projekt (CLI) committet, externe Werkzeuge (z. B. ein Chat für den Entwurf) nie. Zusammenführen und taggen nie der Agent — Abschnitt „Commits".
-   **Kennung** einer Anforderung ist ihr kurzer Name (Dateiname im Backlog). Die **Nummer** wird erst beim „Go" vergeben (nur im Dateinamen, der Branch behält den kurzen Namen): höchste vergebene Nummer in `_requirements/` und `_requirements/done/` + 1, dreistellig mit führenden Nullen (`007-boulder-log.md`); Nummern werden nie wiederverwendet.

## Commits

Format: Conventional Commits mit dem kurzen Namen als Scope — `<typ>(<kurzer-name>): <details>`, `typ` ∈ `feat`, `fix`, `test`, `refactor`, `chore`, `design`; `!` nach dem Scope, wenn Bestehendes bricht; Prozess-Dokumente ohne Code: `chore(<kurzer-name>): …`. **Titel von Pull Requests** ebenso — beim Squash nach `next` wird der Titel zur Commit-Nachricht und zählt für die Version.

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

-   **Leitplanken:** Vor jedem Commit laufen alle Prüfungen und die Prüfung des Commit-Formats (Git-Hook aus dem Grundgerüst) — nie umgehen.
-   Ein Commit mit rotem Test gibt es nicht: In 5c wird der rote Test nachgewiesen, committet wird erst der grüne Schritt.
-   **Pushen:** Der Agent pusht nur die Branches aus der Tabelle oben und eröffnet die Pull Requests — mit kurzer Beschreibung und Verweis auf das Anforderungs- bzw. Release-Dokument.
-   **Zusammenführen: nur der Nutzer** (Pull Requests von `backlog`: die CI, wenn eingerichtet). **Tags:** die CI nach dem Release-Pull-Request, sonst der Nutzer; nie der Agent.
-   **CI-Ergebnisse stehen im Pull Request, nicht in Dokumenten.** Anforderungs- und Release-Dokumente nennen den Pull Request (`#<Nummer>`), aber kein Ergebnis eines CI-Laufs — ein Eintrag danach bräuchte einen neuen Commit und Lauf.
-   **Grün heißt grün in der CI.** Ein lokales Grün reicht nicht für Abnahme oder Tag; maßgeblich ist der CI-Lauf auf dem gepushten Branch.
-   **Nach jedem vom Nutzer zusammengeführten Pull Request** wechselt der Agent auf `main` und holt den Stand (`git switch main`, `git pull --ff-only`); auf `main` wird lokal nie committet.
-   **Gepushte Commits nie umschreiben;** vorher darf der Agent lokal aufräumen (`--amend`, `rebase`, `reset` ohne `--hard`, `stash`).
-   **Git-Befehle:** Branches nur mit `git switch` (`-c` zum Anlegen), Dateien zurücksetzen mit `git restore`, `git tag` nur zum Auflisten. Was die Umgebung sperrt, nicht versuchen (u. a. `checkout`, `merge`, `reset --hard`, `--force`, `--delete`, `--no-verify`, `git -c`, `git config` schreiben, Tags pushen).

## UI-Richtlinie

Damit die App einheitlich aussieht, gilt bei **jeder** UI-Arbeit — mit oder ohne Stufe 3:

-   **Das Design-System ist die Richtlinie.** UI nur mit seinen Tokens und Komponenten; seine README-Regeln gelten.
-   **Keine festen Werte** für Farben, Maße, Abstände, Radien oder Schriftgrößen im App-Code — nur Tokens.
-   **Keine Inline-Styles** — Gestaltung steht nur in Stylesheets, damit sie prüfbar bleibt.
-   **Prüflauf:** Die Prüf-Konfiguration liegt im Projekt als `.stylelintrc.json` (von Init angelegt, Erklärung in `_agent-process/init/pruefung/README.md`) und läuft mit den Tests (im Container und in der CI). **Ausnahme** nur mit Markierung an der Stelle (mit Grund) und Eintrag in `_context/design.md`.
-   **Fehlt etwas im Design-System** (Komponente, Wert, Muster): in `_context/design.md` unter „Lokal umgesetzt — gehört ins Design-System" eintragen, vorerst lokal mit Tokens umsetzen, als Idee für das Design-System vermerken.
-   **Das Design-System wird im Projekt nie bearbeitet.**
