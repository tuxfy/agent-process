# agent-process

Prozess für die Arbeit mit KI-Agenten von der Idee bis zum Release. Wird in jedem Projekt als Git-Submodul unter `_agent-process/` eingebunden. Unabhängig von Sprache, Framework und Werkzeugen.

## Inhalt

| Eintrag | Wozu |
|---|---|
| `AGENTS.md` | Regeln, die immer gelten: welcher Skill wann, Halten, Ordner und Branches, Git, Grundsätze |
| `skills/` | je Stufe ein Skill (`ap-project-setup`, `ap-requirement-capture`, `ap-requirement-refine`, `ap-requirement-build`, `ap-requirement-accept`, `ap-release`), dazu `ap-guideline-ui` für jede UI-Arbeit — `SKILL.md` als Einstieg, Schritt-Dateien daneben |
| `anweisungen/` | `rollen/` (Prüfer), `vorlagen/` (Idee, Bug, Anforderung, Release, Architektur) |
| `.claude/agents/` | Prüfer-Rollen als Unteragenten für Claude Code; verweisen auf `anweisungen/rollen/` |
| `init/` | Vorlagen, die Init ins Projekt schreibt |
| `init.sh` | legt im Projekt an, was fehlt; überschreibt nie Dateien, entfernt nur eigene tote `ap-`-Skill-Links; mit `--hoster` setzt es die Regeln beim Hoster |
| `test/` | Tests fürs Prozess-Repo selbst: `init-test.sh` (Init in einem Wegwerf-Ordner), `hoster-schutz-test.sh` (Regeln beim Hoster an einem Wegwerf-Repo); im Projekt nie genutzt |

**Grundsatz:** Das Projekt läuft ohne dieses Repo. Init kopiert alles, was Bauen, Prüfen und Ausliefern brauchen, ins Projekt; CI und Build lesen nie aus `_agent-process/`.

## Ablauf im Überblick

Der ganze Weg von der Idee bis live auf einer Seite. Die Einzelheiten je Schritt stehen in `skills/` (Rollen und Vorlagen in `anweisungen/`); maßgeblich sind die Skills und `AGENTS.md` — diese Übersicht wird mit ihnen gepflegt.

**Je Anforderung gibst du drei Freigaben** — Klärung, Plan, Abnahme (bei Design vier; bei Track `quick` zwei: Klärung und Abnahme) und führst den Pull Request nach `release-candidate` zusammen. **Je Release** sagst du „release" und führst den Pull Request nach `main` zusammen. Alles andere erledigen Agent und CI.

| Zeichen | Bedeutung |
|---|---|
| **GO** | du gibst frei bzw. entscheidest — der Agent wartet |
| **DU** | Handgriff von dir (beim Hoster oder im Terminal) |
| **CI** | läuft automatisch, wenn im Projekt eingerichtet; sonst übernimmst du |
| **C+P** | der Agent committet und pusht, ohne Rückfrage |
| **PR** | der Agent eröffnet einen Pull Request |
| **ZF** | der Agent gibt dir eine Zusammenfassung im Gespräch |

Am Ende **jeder** Stufe sagt der Agent kurz: was erledigt ist, was als Nächstes kommt, was du tun oder entscheiden musst. **Er hält nur an deinen Freigaben (GO) und Handgriffen (DU) an** — und vor dem Start der Umsetzung, wenn du „später" gesagt hast — sonst geht er ohne Rückfrage weiter.

| Schritt | Wer | Was passiert | Markierung | Branch |
|---|---|---|---|---|
| **0 Einrichten** *(einmal je Projekt)* | Agent schlägt vor | Stack, Prüfungen, Auslieferung, Abnahme in `_context/`; erste Anforderung `grundgeruest` · **ZF:** Einstellungen beim Hoster, soweit Init sie nicht gesetzt hat, ggf. Befehle für das Design-System-Submodul | **GO**, **DU** | — |
| | Agent | Issue für die erste Anforderung; `_context/`, erste Anforderung | **C+P** | `feature/grundgeruest` |
| **1 Idee oder Bug** | Agent oder du | Issue beim Hoster, Label `idee` bzw. `bug` · **ZF:** Nummer | — | — |
| **2 Klärung** | Agent | Issue lesen, Branch vom aktuellen `main` anlegen, ins Issue kommentieren | — | `feature/…` bzw. `fix/…` |
| | Agent | Dokument mit Anliegen aus dem Issue | **C+P** | Feature-Branch |
| | Agent | Fragen stellen, Art, Weg und Track vorschlagen · **ZF:** Spielraum, Weg und Track | — | |
| | du | Spielraum, Weg und Track (`quick` / `complete`) bestätigen | **GO** | |
| | Agent | Anforderungsdokument | **C+P** | Feature-Branch |
| **3a Ausgangslage** *(nur bei Design)* | Agent | Fakten, keine Gestaltung · **ZF:** Ausgangslage als Text zum Kopieren | — | |
| **3b Entwurf** | du, extern | Entwurf und Brief im Werkzeug deiner Wahl — **extern wird nichts committet** | **DU**, Agent wartet | |
| **3c Übergabe** | du stellst bereit, Agent + Rollen prüfen | Befunde der Rollen Entwurf und Barrierefreiheit, Lücken, Fragen · **ZF:** Prüfbericht | **GO** Entwurf freigeben | |
| | Agent | Entwurf, Brief, Lücken | **C+P** | Feature-Branch |
| **4 Refinement** | Agent | Entscheidungen, Verhalten, Akzeptanzkriterien, Abgrenzung; setzt `refined` | **C+P** | Feature-Branch |
| **5 kurzer Weg** *(nur Track `quick`, statt 5a/5b)* | Agent | Plan als Notiz, Start ohne Freigabe (hast du „später" gesagt: auf dein Wort) · **ZF:** was umgesetzt wird, Akzeptanzkriterien · Abbruch → Track `complete`, zurück zu 5a | **C+P** | Feature-Branch |
| **5a Plan** | Agent + Rollen | Plan schreiben, prüfen lassen · **ZF:** was passiert, was du entscheidest, Risiken, wer geprüft hat | — | |
| | du | Plan freigeben — bestätigt auch das Refinement | **GO** | |
| | Agent | Plan | **C+P** | Feature-Branch |
| **5b Start** | Agent | direkt nach der Plan-Freigabe (hast du „später" gesagt: auf dein Wort): Status `in progress` | **C+P** | Feature-Branch |
| **5c Test zuerst** | Agent | roter Test nachgewiesen — kein Commit mit rotem Test | — | |
| **5d/5e Umsetzen, grün** | Agent | ein oder mehrere grüne Commits; am Ende Status `qa` | **C+P** | Feature-Branch |
| **6a–6c QA** | Agent + Rollen | Prüfungen, Befunde; je umgesetztem Befund ein Korrektur-Commit | **C+P** je Befund | Feature-Branch |
| **6d CI** | Agent | QA-Abschnitt fertig, Status `review`; dann PR, CI abwarten — Ergebnis steht im PR | **C+P**, **PR** nach `release-candidate` | Feature-Branch |
| **6e Abnahmepaket** | Agent | **ZF:** Umgesetztes, Screenshots, Befunde, was nicht automatisch prüfbar war, Checkliste, Startbefehl, PR-Nummer | — | |
| **7a Prüfen** | du | nur, was sich nicht automatisch prüfen lässt (z. B. am Gerät) | **DU** | |
| **7b Befunde** | Agent | zurück zu 5, je umgesetztem Befund ein Korrektur-Commit, danach QA erneut | **C+P** je Befund | Feature-Branch |
| **7c Abgenommen** | du | Abnahme aussprechen | **GO** | |
| | Agent | Status `accepted`, Abnahme, Rückblick, Dokument nach `_requirements/done/`, ggf. Zurückgestelltes — ein Commit; CI abwarten · **ZF:** „bereit zum Zusammenführen“ | **C+P** | Feature-Branch |
| | du | erst danach: PR nach `release-candidate` zusammenführen (Squash erlaubt) — heißt: kommt ins nächste Release | **DU** | — |
| **8a Inhalt und Version** | du | „release" — wann, entscheidest du | **GO** | |
| | Agent | Inhalt und Version nach den Regeln; fragt nur bei Widerspruch, 1.0.0 oder nur `chore` · **ZF:** Inhalt und Version mit Begründung | **C+P** | `release-candidate` |
| **8b Gesamtprüfung** | Agent | alle Prüfungen, Klicktest; Release-Dokument fertig, dann PR mit `Closes #…` für die Issues des Releases · **ZF:** PR-Nummer, CI grün | **C+P**, **PR** nach `main` | `release-candidate` |
| **8c Ausliefern** | du | PR nach `main` **als Merge-Commit** zusammenführen — das ist die Freigabe | **DU** | `main` |
| | CI | Tag setzen, Auslieferung startet (ohne CI: **ZF** Befehle für den Tag, mit Version) | **CI** | `main` |
| **8d Nachprüfen** | CI + Agent + du | ausgelieferte App testen, Gerät durch dich; sonst zurückrollen, Bug als Issue · **ZF:** Ergebnis | **CI** | — |

Nach 8d ist nichts mehr zu committen: Was live ist, zeigt der Tag.

**Nie durch den Agenten:** zusammenführen, Tags, Push nach `main`. **Nie extern** (z. B. ein Chat für den Entwurf): Commits.

## Ordner und Branches im Projekt

| Ordner | Inhalt |
|---|---|
| `_context/` | was man über das Projekt wissen muss (Stack, Befehle, …) |
| `_requirements/` | ab Stufe 2 (Klärung), `grundgeruest` ab Stufe 0; Dateiname `<Nr>-<kurzer-name>.md` mit der Issue-Nummer |
| `_requirements/done/` | abgenommen (ab 7c), eingefroren |
| `_requirements/deferred/` | bewusst Zurückgestelltes (Befunde, abgetrennte Ziele), eine Datei je Eintrag; Regeln in der `README.md` dort |
| `_releases/` | ein Dokument je Release |

| Branch | Zweck | Weg nach `main` |
|---|---|---|
| `feature/<kurzer-name>` bzw. `fix/<kurzer-name>` | eine Anforderung von Stufe 2 bis zur Abnahme | Pull Request nach `release-candidate` (6d) |
| `release-candidate` | Sammel-Branch bis zum nächsten Release, mit Release-Dokument | Pull Request nach `main` (8b), dann Tag |

Ohne `release-candidate`: siehe Abkürzung in `skills/ap-release/SKILL.md`.

## Neues Projekt

Im neuen Projekt-Hauptordner:

1.  `git init -b main`
2.  `git submodule add <prozess-repo> _agent-process`
3.  `sh _agent-process/init.sh` — gibt aus, was angelegt wurde und was nur gemeldet wird
4.  Ausgabe prüfen, erster Commit auf `main`, pushen
5.  `sh _agent-process/init.sh --hoster` — setzt jetzt die Regeln beim Hoster (siehe „Was Init anlegt")
6.  Claude starten (erst nach Init, sonst fehlen die Unteragenten und Skills) und mit Stufe 0 beginnen (`skills/ap-project-setup/SKILL.md`)

Die CI braucht das Submodul nicht; beim Auschecken in der CI Submodule nicht laden.

## Bestehendes Projekt klonen

`git clone --recurse-submodules <projekt>` — oder nachträglich `git submodule update --init`.

## Aktualisieren

Der Stand des Prozesses hängt am Branch (das Projekt speichert nur einen Verweis auf einen Commit dieses Repos). Neue Feature-Branches zweigen von `main` ab — deshalb geht ein Update **direkt nach `main`**, nicht über `release-candidate`.

Im Projekt-Hauptordner:

```
git switch main
git pull --ff-only
git switch -c feature/prozess-aktualisieren
git submodule update --remote _agent-process
sh _agent-process/init.sh
git add -A
git commit -m "chore(prozess-aktualisieren): Prozess-Repo auf neuen Stand"
git push -u origin feature/prozess-aktualisieren
```

1.  Ausgabe von Init prüfen (Hinweise, z. B. neuer Stand der Prüf-Konfiguration; neue oder entfernte Skill-Links). Verweise in eingefrorenen Dokumenten (`_requirements/done/`, Release-Dokumente) auf umbenannte Dateien des Prozesses bleiben, wie sie sind.
2.  Pull Request **nach `main`** eröffnen, bei grüner CI zusammenführen.
3.  `main` in `release-candidate` übernehmen, damit beide denselben Prozess-Stand haben (der Agent hält sonst vor der Arbeit auf `release-candidate` an; geht es per Fast-Forward, spult er selbst vor):

    ```
    git switch main
    git pull --ff-only
    git switch release-candidate
    git pull --ff-only
    git merge main -m "chore(prozess-aktualisieren): main in release-candidate"
    git push origin release-candidate
    git switch main
    ```
4.  Claude neu starten — Unteragenten (`.claude/agents`), Skills (`.claude/skills`) und `CLAUDE.md` werden nur beim Start gelesen.

## Was Init anlegt

| Quelle | Ziel im Projekt | Wenn das Ziel schon existiert |
|---|---|---|
| `init/AGENTS.md` | `AGENTS.md` | unverändert; fehlt der Verweis auf `_agent-process/AGENTS.md`: melden |
| `init/CLAUDE.md` | `CLAUDE.md` | unverändert; fehlende `@`-Verweise melden |
| `.claude/agents/` | `.claude/agents` als Link | ist es ein Ordner statt Link: melden |
| `skills/ap-*/` | je Skill ein Link `.claude/skills/ap-*` | Link unverändert, zeigt er woandershin oder ist es ein Ordner: melden; ein `ap-`-Link ohne Ziel, der auf `../../_agent-process/skills/` zeigt (Skill entfallen) wird entfernt; ist `.claude/skills` selbst ein Link: melden, nichts anlegen; Einträge ohne Präfix `ap-` (eigene Skills) bleiben unberührt |
| `init/context/*` | `_context/` | unverändert; fehlt in `projekt.md` der Abschnitt `## UI-Pfade`: Hinweis |
| — | `_requirements/done/`, `_releases/` | nichts tun |
| — | `_requirements/backlog/` (alter Stand) | nicht mehr angelegt; ist er da: melden, mit Einträgen „je Eintrag ein Issue anlegen“ |
| `init/requirements/deferred/README.md` | `_requirements/deferred/README.md` | unverändert |
| `init/pruefung/stylelint.json` | `.stylelintrc.json` | unverändert; weicht die Vorlage ab: melden |
| `init/gitignore` | `.gitignore` | fehlende Zeilen ergänzen |
| `init/hoster-schutz.sh` *(nur mit `--hoster`)* | Regeln beim Hoster laut Checkliste in Stufe 0 (GitHub per `gh`, GitLab per `glab`), Labels `idee` und `bug`; Einzelheiten und Grenzen im Kopf des Skripts | vorhandene Regeln und Labels unverändert, außer einem zu schwachen Schutz von `main`; was fehlt: melden (auch ausgeschaltete Issues) |

## Änderungen am Prozess

Ändert sich ein Schritt, eine Freigabe oder eine Commit-Stelle: „Ablauf im Überblick" oben im selben Commit nachziehen.

Nur hier im Prozess-Repo, nie unter `_agent-process/` in einem Projekt. Erkenntnisse aus Projekten (Stufe 7, Rückblick) als Vorschlag hierher bringen.
