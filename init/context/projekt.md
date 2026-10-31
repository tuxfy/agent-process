# Projekt

*In Stufe 0 (`_agent-process/anweisungen/00-einrichtung.md`) festgelegt; bei Änderungen dort erneut. Offenes ausdrücklich als offen markieren.*

## Zweck

## Stack

*Sprache, Framework, Build, Laufzeit-Abhängigkeiten.*

## Zielformat

*Geräte, Bildschirmgrößen, Ausrichtung, hell/dunkel, Sprache, Barrierefreiheit.*

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

## Befehle

*Lokal starten (Abnahme), Design-System kopieren (falls nötig), weitere.*

## Umgebung des Agenten

*Wo der Agent arbeitet und testet (z. B. Container), was dort verfügbar sein muss.*

## Auslieferung und Release

*Wohin (Rolle „Hoster", How-to in `_context/`), Release-Modell — Standard: Sammel-Branch `release-candidate`, Release = Pull Request nach `main` mit Tag, Version aus dem Inhalt (`_agent-process/anweisungen/08-release.md`); Abkürzung: „Zusammenführen nach `main` = Ausliefern". Zurückrollen.*

## Abnahme

*Wo und wie der Nutzer abnimmt (lokal, Befehl); was nur am echten Gerät prüfbar ist (dann beim Nachprüfen nach dem Release).*
