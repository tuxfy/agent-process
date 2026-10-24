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

Nur hier im Prozess-Repo, nie unter `_agent-process/` in einem Projekt. Erkenntnisse aus Projekten (Stufe 7, Rückblick) als Vorschlag hierher bringen.
