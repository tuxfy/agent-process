# agent-process

Prozess für die Arbeit mit KI-Agenten von der Idee bis zum Release. Wird in jedem Projekt als Git-Submodul unter `_agent-process/` eingebunden. Unabhängig von Sprache, Framework und Werkzeugen.

## Inhalt

| Eintrag | Wozu |
|---|---|
| `AGENTS.md` | Prozessregeln: Ablauf, Branches, Commits, UI-Richtlinie |
| `anweisungen/` | eine Datei je Stufe (0–8), `rollen/` (Prüfer), `vorlagen/` (Idee, Bug, Anforderung, Release) |
| `.claude/agents/` | Prüfer-Rollen als Unteragenten für Claude Code; verweisen auf `anweisungen/rollen/` |
| `init/` | Vorlagen, die Init ins Projekt schreibt |
| `init.sh` | legt im Projekt an, was fehlt; überschreibt nie |

**Grundsatz:** Das Projekt läuft ohne dieses Repo. Init kopiert alles, was Bauen, Prüfen und Ausliefern brauchen, ins Projekt; CI und Build lesen nie aus `_agent-process/`.

## Ablauf im Überblick

Der ganze Weg von der Idee bis live auf einer Seite. Die Einzelheiten je Schritt stehen in `anweisungen/`; maßgeblich sind die Anweisungen und `AGENTS.md` — diese Übersicht wird mit ihnen gepflegt.

**Je Anforderung gibst du vier Freigaben** (bei Design fünf) und führst den Pull Request nach `next` zusammen. **Je Release** sagst du „release" und führst den Pull Request nach `main` zusammen. Alles andere erledigen Agent und CI.

| Zeichen | Bedeutung |
|---|---|
| **GO** | du gibst frei bzw. entscheidest — der Agent wartet |
| **DU** | Handgriff von dir (beim Hoster oder im Terminal) |
| **CI** | läuft automatisch, wenn im Projekt eingerichtet; sonst übernimmst du |
| **C+P** | der Agent committet und pusht, ohne Rückfrage |
| **PR** | der Agent eröffnet einen Pull Request |
| **ZF** | der Agent gibt dir eine Zusammenfassung im Gespräch |

Am Ende **jeder** Stufe sagt der Agent kurz: was erledigt ist, was als Nächstes kommt, was du tun oder entscheiden musst. **Er hält nur an deinen Freigaben (GO) und Handgriffen (DU) an** — sonst geht er ohne Rückfrage weiter.

| Schritt | Wer | Was passiert | Markierung | Branch |
|---|---|---|---|---|
| **0 Einrichten** *(einmal je Projekt)* | Agent schlägt vor | Stack, Prüfungen, Auslieferung, Abnahme in `_context/`; erste Anforderung `grundgeruest` · **ZF:** Checkliste der Einstellungen beim Hoster, ggf. Befehle für das Design-System-Submodul | **GO**, **DU** | — |
| | Agent | `_context/`, erste Anforderung | **C+P** | `feature/grundgeruest` |
| **1 Idee oder Bug** | Agent | Eintrag im Backlog | **C+P**, **PR** nach `main` | `backlog` |
| | CI | Backlog-PR bei grüner Prüfung zusammenführen | **CI** | — |
| **2 Klärung** | Agent | Branch von `main` anlegen, Fragen stellen, Art und Weg vorschlagen · **ZF:** Spielraum und Weg | — | `feature/…` bzw. `fix/…` |
| | du | Spielraum und Weg bestätigen | **GO** | |
| | Agent | Anforderungsdokument | **C+P** | Feature-Branch |
| **3a Ausgangslage** *(nur bei Design)* | Agent | Fakten, keine Gestaltung · **ZF:** Ausgangslage als Text zum Kopieren | — | |
| **3b Entwurf** | du, extern | Entwurf und Brief im Werkzeug deiner Wahl — **extern wird nichts committet** | **DU**, Agent wartet | |
| **3c Übergabe** | du stellst bereit, Agent prüft | Abweichungen, Lücken, Fragen · **ZF:** Prüfbericht | **GO** Entwurf freigeben | |
| | Agent | Entwurf, Brief, Lücken | **C+P** | Feature-Branch |
| **4 Refinement** | Agent | Entscheidungen, Verhalten, Akzeptanzkriterien, Abgrenzung; setzt `refined` | **C+P** | Feature-Branch |
| **5a Plan** | Agent + Rollen | Plan schreiben, prüfen lassen · **ZF:** was passiert, was du entscheidest, Risiken, wer geprüft hat | — | |
| | du | Plan freigeben — bestätigt auch das Refinement | **GO** | |
| | Agent | Plan | **C+P** | Feature-Branch |
| **5b Go** | du | „Go" — jetzt oder später | **GO** | |
| | Agent | Nummer vergeben, Status `in progress` | **C+P** | Feature-Branch |
| **5c Test zuerst** | Agent | roter Test nachgewiesen — kein Commit mit rotem Test | — | |
| **5d/5e Umsetzen, grün** | Agent | je grünem Schritt des Plans; am Ende Status `qa` | **C+P** je Schritt | Feature-Branch |
| **6a–6c QA** | Agent + Rollen | Prüfungen, Befunde; je Korrektur | **C+P** je Korrektur | Feature-Branch |
| **6d CI** | Agent | QA-Abschnitt fertig, Status `review`; dann PR, CI abwarten — Ergebnis steht im PR | **C+P**, **PR** nach `next` | Feature-Branch |
| **6e Abnahmepaket** | Agent | **ZF:** Umgesetztes, Screenshots, Befunde, was nicht automatisch prüfbar war, Checkliste, Startbefehl, PR-Nummer | — | |
| **7a Prüfen** | du | nur, was sich nicht automatisch prüfen lässt (z. B. am Gerät) | **DU** | |
| **7b Befunde** | Agent | zurück zu 5, danach QA erneut | **C+P** je Korrektur | Feature-Branch |
| **7c Abgenommen** | du | Abnahme aussprechen | **GO** | |
| | Agent | Status `accepted`, Abnahme, Rückblick, Dokument nach `_requirements/done/` — ein Commit; CI abwarten · **ZF:** „bereit zum Zusammenführen“ | **C+P** | Feature-Branch |
| | du | erst danach: PR nach `next` zusammenführen (Squash erlaubt) — heißt: kommt ins nächste Release | **DU** | — |
| | Agent | `git switch main`, `git pull --ff-only` | — | `main` |
| **8a Inhalt und Version** | du | „release" — wann, entscheidest du | **GO** | |
| | Agent | Inhalt und Version nach den Regeln; fragt nur bei Widerspruch, 1.0.0 oder nur `chore` · **ZF:** Inhalt und Version mit Begründung | **C+P** | `next` |
| **8b Gesamtprüfung** | Agent | alle Prüfungen, Klicktest; Release-Dokument fertig, dann PR · **ZF:** PR-Nummer, CI grün | **C+P**, **PR** nach `main` | `next` |
| **8c Ausliefern** | du | PR nach `main` **als Merge-Commit** zusammenführen — das ist die Freigabe | **DU** | `main` |
| | CI | Tag setzen, Auslieferung startet (ohne CI: **ZF** Befehle für den Tag, siehe unten) | **CI** | `main` |
| **8d Nachprüfen** | CI + Agent + du | ausgelieferte App testen, Gerät durch dich; sonst zurückrollen, Bug ins Backlog · **ZF:** Ergebnis | **CI** | — |

Nach 8d ist nichts mehr zu committen: Was live ist, zeigt der Tag.

**Tag von Hand** (solange die CI ihn nicht setzt):

```
git switch main
git pull --ff-only
git tag -a v<version> -m "Release v<version>"
git push origin v<version>
```

**Nie durch den Agenten:** zusammenführen, Tags, Push nach `main`. **Nie extern** (z. B. ein Chat für den Entwurf): Commits.

## Neues Projekt

Im neuen Projekt-Hauptordner:

1.  `git init -b main`
2.  `git submodule add <prozess-repo> _agent-process`
3.  `sh _agent-process/init.sh` — gibt aus, was angelegt wurde und was nur gemeldet wird
4.  Ausgabe prüfen, erster Commit auf `main` (bevor `main` beim Hoster geschützt wird)
5.  Claude starten (erst nach Init, sonst fehlen die Unteragenten) und mit Stufe 0 beginnen (`anweisungen/00-einrichtung.md`)

Die CI braucht das Submodul nicht; beim Auschecken in der CI Submodule nicht laden.

## Bestehendes Projekt klonen

`git clone --recurse-submodules <projekt>` — oder nachträglich `git submodule update --init`.

## Aktualisieren

Der Stand des Prozesses hängt am Branch (das Projekt speichert nur einen Verweis auf einen Commit dieses Repos). Neue Feature-Branches zweigen von `main` ab — deshalb geht ein Update **direkt nach `main`**, nicht über `next`.

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

1.  Ausgabe von Init prüfen (Hinweise, z. B. neuer Stand der Prüf-Konfiguration).
2.  Pull Request **nach `main`** eröffnen, bei grüner CI zusammenführen.
3.  `main` in `next` übernehmen, damit beide gleich bleiben:

    ```
    git switch main
    git pull --ff-only
    git switch next
    git pull --ff-only
    git merge main -m "chore: main in next nach Prozess-Update"
    git push origin next
    git switch main
    ```
4.  Claude neu starten — Unteragenten (`.claude/agents`) und `CLAUDE.md` werden nur beim Start gelesen.

## Was Init anlegt

| Quelle | Ziel im Projekt | Wenn das Ziel schon existiert |
|---|---|---|
| `init/AGENTS.md` | `AGENTS.md` | unverändert; fehlt der Verweis auf `_agent-process/AGENTS.md`: melden |
| `init/CLAUDE.md` | `CLAUDE.md` | unverändert; fehlende `@`-Verweise melden |
| `.claude/agents/` | `.claude/agents` als Link | ist es ein Ordner statt Link: melden |
| `init/context/*` | `_context/` | unverändert |
| — | `_requirements/backlog/`, `_requirements/done/`, `_releases/` | nichts tun |
| `init/pruefung/stylelint.json` | `.stylelintrc.json` | unverändert; weicht die Vorlage ab: melden |
| `init/gitignore` | `.gitignore` | fehlende Zeilen ergänzen |

## Änderungen am Prozess

Ändert sich ein Schritt, eine Freigabe oder eine Commit-Stelle: „Ablauf im Überblick" oben im selben Commit nachziehen.

Nur hier im Prozess-Repo, nie unter `_agent-process/` in einem Projekt. Erkenntnisse aus Projekten (Stufe 7, Rückblick) als Vorschlag hierher bringen.
