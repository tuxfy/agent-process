# Projekt

*In Stufe 0 (`_agent-process/skills/ap-project-setup/SKILL.md`) festgelegt; bei Änderungen dort erneut. Offenes ausdrücklich als offen markieren.*

## Zweck

## Anspruch

*einfach | normal | hoch — mit kurzer Begründung (Nutzerkreis, Daten, Folgen eines Ausfalls); Bedeutung: `_agent-process/skills/ap-project-setup/SKILL.md`, „Was festgelegt wird", Punkt 1.*

## Stack

*Sprache, Framework, Build, Laufzeit-Abhängigkeiten.*

## Zielformat

*Geräte, Bildschirmgrößen, Ausrichtung, hell/dunkel, Sprache, Barrierefreiheit.*

## UI-Pfade

*Wo UI-Code liegt (z. B. `app/**/*.{css,html,jsx,tsx,vue}`); daran erkennt der Agent UI-Arbeit (Skill `ap-guideline-ui`).*

## Prüfungen

| Kategorie | Werkzeug | Befehl |
|---|---|---|
| Code-Linter | | |
| Formatierer | | |
| Prüflauf UI-Richtlinie | Stylelint, `.stylelintrc.json` | |
| Unit-Tests | | |
| E2E-Tests | | |
| Schwachstellen in Abhängigkeiten | | |
| Geheimnisse im Code | | |
| Barrierefreiheit *(optional)* | | |
| Sauberer Lauf | | |
| Git-Hook vor dem Commit | | |
| Commit-Format | | |

**Alle Prüfungen:** `<ein Befehl>` — lokal und in der CI gleich. Bewusst weggelassen: *(Kategorie, Grund)*

**Wo was läuft:** *(nur, wenn nicht alles überall gleich läuft — je Prüfung: Git-Hook, lokal, CI im Pull Request, geplanter Lauf, Update-Werkzeug; wer was abdeckt)*

## Befehle

*Lokal starten (Abnahme), Design-System kopieren (falls nötig), weitere.*

## Umgebung des Agenten

*Wo der Agent arbeitet und testet (z. B. Container), was dort verfügbar sein muss.*

## Auslieferung und Release

*Wohin (Rolle „Hoster", How-to in `_context/`), Release-Modell — Standard: Sammel-Branch `release-candidate`, Release = Pull Request nach `main` mit Tag, Version aus dem Inhalt (`_agent-process/skills/ap-release/SKILL.md`); Abkürzung: „Zusammenführen nach `main` = Ausliefern". Zurückrollen. Gibt es Server oder gespeicherte Daten: Sicherung und Wiederaufbau.*

## Abnahme

*Wo und wie der Nutzer abnimmt (lokal, Befehl); was nur am echten Gerät prüfbar ist (dann beim Nachprüfen nach dem Release).*
