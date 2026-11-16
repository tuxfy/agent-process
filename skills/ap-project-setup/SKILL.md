---
name: ap-project-setup
description: Stufe 0 des Agent-Prozesses (`_agent-process`) – legt Stack, Prüfungen, Auslieferung, Abnahme und optional die Architektur eines Projekts in `_context/` fest und legt die erste Anforderung an. Nutzen, wenn `_context/projekt.md` noch nicht ausgefüllt ist oder Stack, Prüfungen oder Auslieferung neu festgelegt werden. Nicht für einzelne Befehle oder kleine Korrekturen an `_context/`.
---

# Stufe 0: Projekt einrichten

Legt **einmal** fest, wie im Projekt gebaut, geprüft, abgenommen und ausgeliefert wird. Alle späteren Stufen lesen diese Festlegungen aus `_context/` statt sie je Anforderung neu zu klären.

**Es wird nichts eingerichtet** — keine Pakete, keine Konfiguration, kein Code. Das Einrichten ist die **erste Anforderung** und läuft wie jede andere durch den Prozess (mit Plan, Prüfern, QA und Abnahme).

## Wann

-   **Neues Projekt:** vor der ersten Idee, die umgesetzt werden soll.
-   **Bestehendes Projekt:** Vorhandenes erkennen und als Ist-Stand vorschlagen (z. B. vorhandene Test-Werkzeuge, CI, Auslieferung) — nicht neu erfinden. Lücken zu den Standardprüfungen benennen.
-   **Erneut,** wenn sich Grundlegendes ändert (z. B. neuer Stack, anderes Release-Modell). Dann nur den betroffenen Teil; daraus entsteht eine Anforderung für die Umstellung.

## Was festgelegt wird

Der Agent schlägt vor, mit kurzer Begründung; **der Nutzer entscheidet** (so fragen wie in `_agent-process/skills/ap-requirement-refine/klaeren.md`). Ergebnis in `_context/projekt.md`, Design-System in `_context/design.md`, Architektur (optional) in `_context/architektur.md`.

1.  **Zweck und Anspruch** — wofür das Projekt da ist, in zwei, drei Sätzen; dazu der **Anspruch**, an dem Prüfer-Befunde und Bugs gemessen werden (`_agent-process/anweisungen/rollen/README.md`, „Einstufung"), mit kurzer Begründung aus Nutzerkreis, Art der Daten und Folgen eines Ausfalls:
    -   **einfach** — nur der Nutzer selbst oder wenige Bekannte, keine fremden persönlichen Daten, ein Ausfall ist ärgerlich, aber folgenlos (z. B. ein eigener Server);
    -   **normal** — weitere Nutzer oder persönliche Daten, ein Ausfall ist spürbar;
    -   **hoch** — viele Nutzer, sensible Daten oder Geld, ein Ausfall ist teuer.
2.  **Stack** — Sprache, Framework, Build (oder keiner), Laufzeit-Abhängigkeiten.
3.  **Zielformat** — Geräte, Bildschirmgrößen, Ausrichtung, hell/dunkel, Sprache, Barrierefreiheit. Gilt für Entwurf, Tests und Klicktest.
4.  **Design-System** — welches, und wie es zur Laufzeit in die App kommt (z. B. welche Dateien, ob kopiert wird; dann Kopierbefehl). Soll es als Submodul `_design-system/` eingebunden werden, gibt der Agent dem Nutzer die Befehle fertig aus (`git submodule add <design-system> _design-system` und Commit) und wartet — er bindet es nicht selbst ein. Dazu die **UI-Pfade** (in `_context/projekt.md`): wo UI-Code liegt, damit UI-Arbeit erkennbar ist.
5.  **Prüfungen** — je Kategorie das passende Werkzeug für den Stack (siehe „Standardprüfungen").
6.  **Ein Befehl für alles** — alle Prüfungen laufen mit einem Befehl, lokal in der Umgebung des Agenten und in der CI gleich.
7.  **Umgebung des Agenten** — wo der Agent arbeitet und testet (z. B. Container), was dort verfügbar sein muss.
8.  **Auslieferung und Release** — wohin ausgeliefert wird (Rolle „Hoster", How-to in `_context/`), Release-Modell (Sammel-Branch `release-candidate` oder „Zusammenführen nach `main` = Ausliefern", siehe `_agent-process/skills/ap-release/SKILL.md`), Zurückrollen. Standard für die CI:
    -   **Tag automatisch:** Nach dem Zusammenführen des Release-Pull-Requests setzt die CI den Tag `v<version>` aus dem Release-Dokument; die Auslieferung startet mit dem Tag.
    -   **Nachprüfung automatisch:** Nach der Auslieferung prüft die CI die ausgelieferte App (startet sie, Hauptwege); Geräteprüfung bleibt beim Nutzer.
    -   **Einstellungen beim Hoster** — setzt `sh _agent-process/init.sh --hoster`, soweit möglich (meldet, was fehlt); sonst gibt der Agent dem Nutzer diese Liste zum Abhaken; im How-to festgehalten:
        -   [ ] `main`: Änderungen nur per Pull Request, Prüfung der CI muss grün sein, nur Merge-Commits, kein Force-Push, nicht löschbar
        -   [ ] `release-candidate`: nicht löschbar
        -   [ ] Tags `v*`: nicht änderbar und nicht löschbar
        -   [ ] Auslieferung (z. B. Umgebung beim Hoster) für Tags `v*` freigegeben
        -   [ ] Branches nach dem Zusammenführen automatisch löschen (erst wenn `release-candidate` geschützt ist)
        -   [ ] Issues eingeschaltet; Labels `idee` und `bug` angelegt
9.  **Abnahme** — wo und wie der Nutzer abnimmt (lokal, Befehl) und was nur am echten Gerät geprüft werden kann (dann beim Nachprüfen nach dem Release).
10. **Architektur** *(optional)* — vorschlagen, wenn das Projekt aus mehreren Diensten besteht, mehrere Netze hat oder der Anspruch „hoch" ist; sonst entfällt sie. Dann `_context/architektur.md` nach `_agent-process/anweisungen/vorlagen/architektur.md`, nur mit dem, was der Nutzer bestätigt, und in `AGENTS.md` des Projekts unter „Festlegungen" verlinken. Sie beschreibt, was wie zusammenhängt (Bausteine, Erreichbarkeit, Vertrauensgrenzen, Daten, Entscheidungen über eine Anforderung hinaus); wie gearbeitet wird (Prüfungen und wo sie laufen, Auslieferung, Sicherung, Wiederaufbau), bleibt in `_context/projekt.md`.

## Standardprüfungen

Kategorien, unabhängig vom Stack. Welches Werkzeug, entscheidet der Stack; Konfigurationen nur, wo das Prozess-Repo eine eigene Regel hat.

| Kategorie | Standard | Hinweis |
|---|---|---|
| Code-Linter | immer | Fehler und Stil im Code (z. B. ESLint bei JavaScript) |
| Formatierer | immer | mit Standardeinstellungen, keine eigene Konfiguration (z. B. Prettier) |
| Prüflauf UI-Richtlinie | bei UI | Konfiguration `.stylelintrc.json` (von Init angelegt, Erklärung in `_agent-process/init/pruefung/README.md`) |
| Unit-Tests | für Logik (sobald es welche gibt) | eigene Logik ohne Oberfläche; Code, der nur ein externes Werkzeug aufruft, prüft der echte Lauf bzw. die Abnahme |
| E2E-Tests | bei UI | im Zielformat |
| Schwachstellen in Abhängigkeiten | immer | **ausgelieferte** Abhängigkeiten blockieren (z. B. `npm audit --omit=dev`); **Entwicklungswerkzeuge** nur als Warnung (voller Audit, blockiert nicht) |
| Geheimnisse im Code | immer | Suche nach Zugangsdaten, Schlüsseln, Tokens |
| Barrierefreiheit | optional bei UI | z. B. axe in den E2E-Tests |
| Sauberer Lauf | immer | ein Befehl, der den aktuellen Commit in einen leeren Ordner klont (ohne Submodule, Abhängigkeiten, ungetrackte Dateien) und dort wie die CI installiert und alle Prüfungen ausführt — findet, was nur lokal vorhanden ist |
| Git-Hook vor dem Commit | immer | führt alle Prüfungen (ein Befehl) aus; Commit nur bei grün |
| Commit-Format | immer | prüft Conventional Commits mit Scope (z. B. commitlint) |

Abweichungen (eine Kategorie bewusst weglassen) mit Grund in `_context/projekt.md`.

Im Grundgerüst werden Werkzeuge in aktuellen Versionen eingerichtet; Warnungen des vollen Audits werden dabei zuerst durch Aktualisieren behoben, erst danach hingenommen.

## Ergebnis

-   `_context/projekt.md` (und `_context/design.md`, ggf. `_context/architektur.md`) ausgefüllt; offene Punkte ausdrücklich als offen markiert.
-   **Issue:** erst, wenn Issues eingeschaltet und die Labels angelegt sind (Checkliste oben bzw. `init.sh --hoster`; prüfen mit `gh label list` bzw. `glab label list`) — abweichend von Stufe 1, die ohne Label anlegt. Dann legt der Agent es an (Stufe 1, `_agent-process/skills/ap-requirement-capture/SKILL.md`; Label `idee`, Titel „Grundgerüst einrichten"; was fehlt: Einrichten von allem, was Stufe 0 festgelegt hat; Ziel: gebaut, geprüft und ausgeliefert wird wie in `_context/projekt.md`). Die Freigabe von Stufe 0 gilt als Aufgreifen. Geht das Anlegen nicht: Text zum Kopieren ausgeben und auf die Nummer warten (Handgriff des Nutzers).
-   **Branch:** Der Agent legt `feature/grundgeruest` vom aktuellen `main` an (`_agent-process/AGENTS.md`, Abschnitt „Git", „Aktueller Stand") und kommentiert direkt nach dem Push ins Issue: „Aufgegriffen auf `feature/grundgeruest`" (geht das nicht: Kommentar zum Kopieren ausgeben). Dann committet er dort `_context/` (ggf. mit `AGENTS.md` des Projekts für den Verweis auf die Architektur) und die erste Anforderung (`chore(grundgeruest): Einrichtung, Anliegen aus Issue #<Nummer>`) und pusht. Stufe 4 läuft auf diesem Branch weiter.
-   **Erste Anforderung** `_requirements/<Nr>-grundgeruest.md` (`<Nr>` = Issue-Nummer wie in `_agent-process/skills/ap-requirement-refine/klaeren.md`, „Dokument"; Vorlage `_agent-process/anweisungen/vorlagen/anforderung.md`, `Issue #<Nummer>`, Status `new`, Track `complete`; im Abschnitt „Anliegen" der Text des Issues, unter „Einordnung" das Ziel aus dem Issue — es steht in diesem Skill fest und gilt mit der Freigabe von Stufe 0 als bestätigt): Einrichten von allem, was Stufe 0 festgelegt hat. Die Entscheidungen verweisen auf `_context/projekt.md`; weiter mit Stufe 4 (Refinement) — Klärung und Design entfallen in der Regel.
-   Bei einem bestehenden Projekt: nur für die Lücken eine Anforderung (z. B. `pruefungen-ergaenzen`), ebenso bei einem erneuten Durchlauf für die Umstellung — Issue wie oben, Titel und Text beschreiben die Lücke bzw. Umstellung; dann Klärung wie üblich (Stufe 2, `_agent-process/skills/ap-requirement-refine/klaeren.md`, kurzer Name nach den Regeln dort). Die Änderungen an `_context/` kommen mit dem ersten Commit dort.
