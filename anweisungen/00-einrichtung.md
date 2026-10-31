# Stufe 0: Projekt einrichten

Legt **einmal** fest, wie im Projekt gebaut, geprüft, abgenommen und ausgeliefert wird. Alle späteren Stufen lesen diese Festlegungen aus `_context/` statt sie je Anforderung neu zu klären.

**Es wird nichts eingerichtet** — keine Pakete, keine Konfiguration, kein Code. Das Einrichten ist die **erste Anforderung** und läuft wie jede andere durch den Prozess (mit Plan, Prüfern, QA und Abnahme).

## Wann

-   **Neues Projekt:** vor der ersten Idee, die umgesetzt werden soll.
-   **Bestehendes Projekt:** Vorhandenes erkennen und als Ist-Stand vorschlagen (z. B. vorhandene Test-Werkzeuge, CI, Auslieferung) — nicht neu erfinden. Lücken zu den Standardprüfungen benennen.
-   **Erneut,** wenn sich Grundlegendes ändert (z. B. neuer Stack, anderes Release-Modell). Dann nur den betroffenen Teil; daraus entsteht eine Anforderung für die Umstellung.

## Was festgelegt wird

Der Agent schlägt vor, mit kurzer Begründung; **der Nutzer entscheidet** (so fragen wie in `_agent-process/anweisungen/02-klaerung.md`). Ergebnis in `_context/projekt.md`, Design-System in `_context/design.md`.

1.  **Zweck** — wofür das Projekt da ist, in zwei, drei Sätzen.
2.  **Stack** — Sprache, Framework, Build (oder keiner), Laufzeit-Abhängigkeiten.
3.  **Zielformat** — Geräte, Bildschirmgrößen, Ausrichtung, hell/dunkel, Sprache, Barrierefreiheit. Gilt für Entwurf, Tests und Klicktest.
4.  **Design-System** — welches, und wie es zur Laufzeit in die App kommt (z. B. welche Dateien, ob kopiert wird; dann Kopierbefehl). Soll es als Submodul `_design-system/` eingebunden werden, gibt der Agent dem Nutzer die Befehle fertig aus (`git submodule add <design-system> _design-system` und Commit) und wartet — er bindet es nicht selbst ein.
5.  **Prüfungen** — je Kategorie das passende Werkzeug für den Stack (siehe „Standardprüfungen").
6.  **Ein Befehl für alles** — alle Prüfungen laufen mit einem Befehl, lokal in der Umgebung des Agenten und in der CI gleich.
7.  **Umgebung des Agenten** — wo der Agent arbeitet und testet (z. B. Container), was dort verfügbar sein muss.
8.  **Auslieferung und Release** — wohin ausgeliefert wird (Rolle „Hoster", How-to in `_context/`), Release-Modell (Sammel-Branch `release-candidate` oder „Zusammenführen nach `main` = Ausliefern", siehe `_agent-process/anweisungen/08-release.md`), Zurückrollen. Standard für die CI:
    -   **Tag automatisch:** Nach dem Zusammenführen des Release-Pull-Requests setzt die CI den Tag `v<version>` aus dem Release-Dokument; die Auslieferung startet mit dem Tag.
    -   **Nachprüfung automatisch:** Nach der Auslieferung prüft die CI die ausgelieferte App (startet sie, Hauptwege); Geräteprüfung bleibt beim Nutzer.
    -   **Backlog automatisch zusammenführen:** Pull Requests von `backlog`, die nur `_requirements/backlog/` ändern, führt die CI bei grüner Prüfung selbst zusammen.
    -   **Einstellungen beim Hoster** — setzt `sh _agent-process/init.sh --hoster`, soweit möglich (meldet, was fehlt); sonst gibt der Agent dem Nutzer diese Liste zum Abhaken; im How-to festgehalten:
        -   [ ] `main`: Änderungen nur per Pull Request, Prüfung der CI muss grün sein, nur Merge-Commits, kein Force-Push, nicht löschbar
        -   [ ] `release-candidate`: nicht löschbar
        -   [ ] Tags `v*`: nicht änderbar und nicht löschbar
        -   [ ] Auslieferung (z. B. Umgebung beim Hoster) für Tags `v*` freigegeben
        -   [ ] Automatisches Zusammenführen erlaubt; Branches nach dem Zusammenführen automatisch löschen (erst wenn `release-candidate` geschützt ist)
9.  **Abnahme** — wo und wie der Nutzer abnimmt (lokal, Befehl) und was nur am echten Gerät geprüft werden kann (dann beim Nachprüfen nach dem Release).

## Standardprüfungen

Kategorien, unabhängig vom Stack. Welches Werkzeug, entscheidet der Stack; Konfigurationen nur, wo das Prozess-Repo eine eigene Regel hat.

| Kategorie | Standard | Hinweis |
|---|---|---|
| Code-Linter | immer | Fehler und Stil im Code (z. B. ESLint bei JavaScript) |
| Formatierer | immer | mit Standardeinstellungen, keine eigene Konfiguration (z. B. Prettier) |
| Prüflauf UI-Richtlinie | bei UI | Konfiguration `.stylelintrc.json` (von Init angelegt, Erklärung in `_agent-process/init/pruefung/README.md`) |
| Unit-Tests | immer | Logik ohne Oberfläche |
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

-   `_context/projekt.md` (und `_context/design.md`) ausgefüllt; offene Punkte ausdrücklich als offen markiert.
-   **Branch:** Der Agent legt `feature/grundgeruest` von `main` an, committet `_context/` und die erste Anforderung dort und pusht. Stufe 4 läuft auf diesem Branch weiter.
-   **Erste Anforderung** `_requirements/backlog/grundgeruest.md` (Vorlage `_agent-process/anweisungen/vorlagen/anforderung.md`, Status `new`): Einrichten von allem, was Stufe 0 festgelegt hat. Die Entscheidungen verweisen auf `_context/projekt.md`; weiter mit Stufe 4 (Refinement) — Klärung und Design entfallen in der Regel.
-   Bei einem bestehenden Projekt: nur für die Lücken eine Anforderung (z. B. `pruefungen-ergaenzen`).
