# Prozessregeln

Gilt in jedem Projekt, das dieses Prozess-Repo als Submodul `_agent-process/` einbindet.

## Skills

Vor jeder Arbeit `_context/projekt.md` lesen, bei Design-Arbeit auch `_context/design.md`, gibt es `_context/architektur.md`, immer auch diese; ist `projekt.md` noch nicht ausgefüllt: zuerst `ap-project-setup` (fehlt nur der Abschnitt „Anspruch": den schlägt die Klärung vor). Je Stufe gilt ein Skill unter `_agent-process/skills/`. Eine Stufe beginnt erst, wenn die vorherige abgeschlossen ist; Code entsteht nur für eine Anforderung nach dem Start ihrer Umsetzung.

| Skill | wann |
|---|---|
| `ap-project-setup` | Stufe 0, einmal je Projekt |
| `ap-requirement-capture` | der Nutzer meldet einen Fehler oder Wunsch — **zuerst festhalten, nicht sofort beheben** |
| `ap-requirement-refine` | der Nutzer greift ein Issue auf, oder Status `new`: Klärung, Design, Refinement |
| `ap-requirement-build` | Status `refined`, `in progress`, `qa`: Plan, Umsetzung, QA |
| `ap-requirement-accept` | Status `review` |
| `ap-release` | der Nutzer sagt „release“, oder ein Release ist offen |
| `ap-planning` | der Nutzer sagt „Planung“ — Überblick über die offenen Issues, nur auf seinen Anstoß; sonst liest der Agent die Seite „Planung“ nicht |
| `ap-guideline-ui` | jede Änderung an Dateien unter den UI-Pfaden aus `_context/projekt.md`, ohne UI-Pfade jede Änderung an der Oberfläche |
| `ap-guideline-docs` | jeder Text, den ein Mensch liest, außer Code, Code-Kommentaren und Commit-Nachrichten; auch beim Schreiben von Skills und Rollen-Dateien |

## Halten

-   **Angehalten wird nur an den Freigaben** des Nutzers — Klärung (2), Entwurf (3c), Plan (5a, nicht bei Track `quick`), Abnahme (7c), „release“ (8a) —, an seinen Handgriffen und wenn eine Entscheidung nötig ist. Sonst geht der Agent ohne Rückfrage weiter.
-   **Höchstens 3 Korrekturrunden je Prüfung** (z. B. QA, CI, Abnahme). Findet die Prüfung danach noch etwas, hält der Agent an und fragt den Nutzer, wie es weitergeht.
-   **Bestätigtes ändert nur der Nutzer:** Was er an einer Freigabe bestätigt hat (Ziel, Spielraum, Weg und Track, Anspruch, Entwurf, Plan), ändert der Agent nie selbst. Er stellt die Änderung als Frage — Eintrag mit altem und neuem Wert, Grund und Folgen (z. B. „Design nötig? ja → nein, Stufe 3 entfällt. Soll ich das ändern?“); bestätigt ist nur ein Ja auf diese Frage, nicht Zustimmung zu einer Idee im Gespräch. Dann trägt er es ein und committet (`chore(<kurzer-name>): <Eintrag> geändert`, z. B. `Weg geändert`). Ausnahmen, die der Agent selbst einträgt und dem Nutzer sagt: Wechsel aufs Strengere (Track `quick` → `complete`) und technische Abweichungen vom Plan innerhalb der Entscheidungen.
-   **„Später“:** Sagt der Nutzer, eine Anforderung solle später umgesetzt werden, hält der Agent vor dem Start der Umsetzung an; vermerkt wird das nicht. Eine neue Sitzung arbeitet nur an der Anforderung, die der Nutzer nennt; nennt er keine, fragt der Agent (gilt nicht für `ap-planning`).
-   **Am Ende jeder Stufe** sagt der Agent kurz: was erledigt ist, was als Nächstes kommt, was der Nutzer tun oder entscheiden muss.

## Ordner und Branches

-   **Nie ändern:** `_agent-process/`, `.claude/agents`, `.claude/skills/ap-*`, `_design-system/` und kopierte Dateien des Design-Systems (nur über den Kopierbefehl aus `_context/projekt.md` erneuern). Änderungen am Prozess nur als Vorschlag fürs Prozess-Repo. Bauen, Prüfen und Ausliefern nutzen nie Dateien aus `_agent-process/`.
-   Ideen und Bugs sind Issues beim Hoster. Anforderungen liegen ab Stufe 2 (`grundgeruest` ab Stufe 0) in `_requirements/` (abgenommen in `done/`), bewusst Zurückgestelltes in `_requirements/deferred/` (eine Datei je Eintrag, Regeln in der `README.md` dort), Releases in `_releases/`.
-   `main` nur per Pull Request. Je Anforderung `feature/<kurzer-name>` bzw. `fix/<kurzer-name>`; deren Pull Request geht nach `release-candidate` — **heißt: kommt ins nächste Release** (ohne `release-candidate`: Abkürzung in `ap-release`).

## Git

-   **Commit-Format:** `<typ>(<kurzer-name>): <details>`, `typ` ∈ `feat`, `fix`, `test`, `refactor`, `chore`, `design`; `!` nach dem Scope, wenn Bestehendes bricht; Prozess-Dokumente ohne Code: `chore(<kurzer-name>): …`. Titel von Pull Requests ebenso — beim Squash wird der Titel zur Commit-Nachricht und zählt für die Version.
-   **Committen nur, wo ein Skill oder diese Datei es sagt,** dann sofort pushen; Dateien nur namentlich hinzufügen (`git add <Pfad>`), nie `git add -A` oder `.`; Verschieben mit `git mv`, Löschen mit `git rm`. Den Git-Hook nie umgehen. Pull Requests eröffnet der Agent, mit Verweis auf das Anforderungs- bzw. Release-Dokument.
-   **Zusammenführen und Tags nie durch den Agenten;** auf `main` wird nie committet (Ausnahme: Wiki-Repo, siehe „Issues“).
-   **Issues:** Der Agent legt Issues an, liest und kommentiert sie (`gh issue` bzw. `glab issue` — welcher, zeigt die Adresse von `origin`); schließen, wieder öffnen, löschen und Labels nachträglich ändern nie — geschlossen werden Issues über `Closes #<Nummer>` im Pull Request nach `main` (Release-PR, bei der Abkürzung der Feature-PR), wenn der Nutzer ihn zusammenführt. Im Wiki schreibt der Agent nur die Seite „Planung“, nur im Skill `ap-planning` und nur über das Wiki-Repo (`<Repo>.wiki.git`); dort committet er auf dem Branch, den der Klon ausgecheckt hat, ohne eigenen Branch, auch wenn er `main` heißt.
-   **Aktueller Stand** (gilt nicht für das Wiki-Repo)**:** CI und Nutzer führen auf dem Hoster zusammen, ohne dass der Agent es mitbekommt. Deshalb vor jeder Arbeit auf einem gemeinsamen Branch (`main`, `release-candidate`, wenn es ihn im Projekt gibt) und vor jedem neuen Branch davon:
    1.  `git fetch --prune --tags`.
    2.  Gibt es `origin/<Branch>`: `git switch <Branch>`, `git pull --ff-only`. Gibt es ihn nur lokal (vom Hoster nach dem Zusammenführen gelöscht): `git switch <Branch>`, `git pull --ff-only origin main`, `git push -u origin <Branch>` — scheitert das, anhalten und den Nutzer fragen. Gibt es ihn gar nicht: `git switch main`, `git pull --ff-only`, `git switch -c <Branch>`, `git push -u origin <Branch>`.
    3.  `release-candidate` zusätzlich auf `main` vorspulen: `git pull --ff-only origin main` (nur Fast-Forward, erlaubt), danach pushen. Scheitert das, hat der Branch eigene Commits — dann weiterarbeiten; nie rebasen oder mergen, Vorschläge von Git dazu ignorieren. **Ausnahme:** Unterscheidet sich `_agent-process` zwischen `release-candidate` und `origin/main` (`git diff --quiet HEAD origin/main -- _agent-process` scheitert), anhalten und dem Nutzer die Befehle zum Zusammenführen geben (README des Prozess-Repos, „Aktualisieren“).
    4.  Ein neuer Feature- oder Fix-Branch zweigt erst danach von diesem Stand ab: `git switch -c <neu>`, `git push -u origin <neu>`.
-   Gepushte Commits nie umschreiben; vorher lokal aufräumen ist erlaubt (`--amend`, `rebase`, `reset` ohne `--hard`; `stash` nur wie unter „Wechsel mitten in einer Stufe"). Branches mit `git switch`, Dateien mit `git restore`. Gesperrt, also nicht versuchen: `checkout`, `merge`, `reset --hard`, `--force`, `--delete`, `--no-verify`, `git -c`, `git config` schreiben, Tags pushen.
-   **Wechsel mitten in einer Stufe** zu einer anderen Anforderung: nur nicht Committetes **dieser** Anforderung sichern — ihr Dokument, `_requirements/mockups/<kurzer-name>/`, in dieser Stufe angelegte Einträge in `_requirements/deferred/` und Dateien, die der Agent für sie geändert hat, soweit `git status --porcelain` sie zeigt: `git stash push -u -m <kurzer-name> -- <diese Pfade>`. Zurück: erst auf ihren Branch wechseln, dann den neuesten Eintrag mit genau dieser Nachricht aus `git stash list` holen (`git stash pop <Eintrag>`); scheitert das, anhalten. Alles andere (z. B. Dateien des Nutzers) stasht, verschiebt, löscht oder committet der Agent nie; verhindert es den Wechsel: anhalten und fragen.
-   **Grün heißt grün in der CI** auf dem gepushten Branch; ein lokales Grün reicht nicht für Abnahme oder Release.

## Grundsätze

- Oberste Prämissen:
	 - Best Practice, Standards und KISS haben Vorrang
	 - nichts unnötiges bauen, immer prüfen ob es etwas Fertiges gibt, wenn ja Nutzer darüber informieren und entscheiden lassen
	 - wegräumen, was nicht mehr gebraucht wird
 - Tests:
	- keine Randfälle, keine künstlichen Komplexitäten, die in der realen Welt nicht vorkommen, nur für reale Logik
	- keine Tests für Fehler, die der Agent macht und nicht Logik sind
	- Verhalten testen, nicht Quelltext (`grep` auf das Skript) und nicht Konfiguration Zeile für Zeile
	- gemeinsame Logik nur einmal testen, dort, wo sie liegt
	- Regressionstest nur, wenn der Fehler durch eine übliche Änderung wiederkommen kann
	- **Tests nie abschwächen,** um grün zu werden (Prüfung entfernt, nur bedingt ausgeführt, Erwartung gelockert); passt ein Test nicht zur Umgebung, die Umgebung anpassen. Überflüssige Tests zu streichen ist kein Abschwächen, wenn es Ziel der Anforderung ist und die Abdeckung realer Logik bleibt.
- **Pakete und Werkzeuge** installiert der Agent selbst in seiner Umgebung, nach Rückfrage — nie beim Nutzer und nie als Aufgabe an ihn.
- **Eingefroren:** abgenommene Anforderungen (`_requirements/done/`) und Release-Dokumente ab dem Zusammenführen nach `main`; Nachträge in eine neue Anforderung bzw. ins nächste Release.
- **Dokumente und Issues:** 
	- Sicherheitsthemen nur abstrakt 
	- konkrete Stelle nur im Gespräch
	- in `_context/architektur.md` zudem keine Adressen, Ports, Zugangsdaten, Versionen oder bekannten Schwachstellen -> sie soll Angreifern keine fertige Übersicht liefern
	- Verweise relativ
	- Pull Requests und Issues  als `#<Nummer>` - \<Titel\>
	- keine Adressen beim Hoster
	- keine CI-Ergebnisse (die stehen im Pull Request)

## Bekannte Fehler

*Eine Zeile je Fehler, den Agenten zum zweiten Mal gemacht haben — eingetragen hier im Prozess-Repo, aus den Vorschlägen der Rückblicke (Stufe 7d).*

-   **Befehle für den Nutzer** (Tag auf falschem Commit, 15.11.): Vorher prüft der Agent Branch und `git status` im Arbeitsverzeichnis, in dem der Nutzer sie ausführt; hat er dort nicht Committetes, das sie stören würde, nennt er es vorher. Die Befehle legen ihr Ziel selbst fest (Tag z. B. wie in `ap-release`, `ausliefern.md`) und sind mit `&&` verkettet, damit nach einem Fehler nichts weiterläuft.
- Agent handelte mehrmals nicht nach  Best Practice, Standards und KISS
	- siehe Grundsätze -> Oberste Prämissen
- Agent schrieb mehrmals unnötige Tests
	- siehe Grundsätze -> Tests
