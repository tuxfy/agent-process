# Stufe 6: QA

Prüft eine umgesetzte Anforderung über die Tests hinaus, bevor der Nutzer sie abnimmt. Voraussetzung: Stufe 5 abgeschlossen, alle Tests und Prüflauf grün, Status `qa`, Arbeit auf dem Feature-Branch.

| Schritt | Wer | Ergebnis |
|---|---|---|
| 6a Automatische Prüfungen | Agent | Ergebnis unter `# QA → Automatisch` |
| 6b Prüfung durch Rollen | Prüfer (nur lesend) | Befunde, vom Agenten eingestuft |
| 6c Befunde bearbeiten | Agent | blockierende behoben, Rest entschieden |
| 6d CI | Agent | QA-Abschnitt und Status `review` committet, Pull Request eröffnet, CI grün |
| 6e Abnahmepaket | Agent | Paket für den Nutzer (im Gespräch) |

## Umfang

Es gilt die erste passende Zeile.

| Änderung | 6a | Reviewer | Testwirkung | Klicktester | Security |
|---|---|---|---|---|---|
| Spielraum „Schnittstellen/Daten" angekreuzt, neue Abhängigkeiten oder externe Dienste (Umsetzungsplan → Externe Abhängigkeiten) oder Auslieferung (Plan berührt CI, Hosting oder Release) | ✓ | ✓ | ✓ wenn der Diff Code ändert | ✓ bei UI | ✓ |
| Alles andere — Feature oder Bug, Track `quick` oder `complete` | ✓ | ✓ | ✓ wenn der Diff Code ändert | ✓ bei UI | bei Bedarf |

Der Reviewer prüft immer, auch ob jede Änderung einen Test oder eine Begründung hat (etwa bei einem Bug-Fix ohne Test). Bei Track `quick` gibt es keine Prüfung des Plans; unabhängig auf den Code schauen der Reviewer und, wenn sie laufen, Testwirkung und Security. Testwirkung läuft, wenn `.qa/diff.txt` Code ändert — Programmcode, Tests oder Testdaten, auch gelöscht; nicht bei reinen Änderungen an Doku, Texten, Stil oder Konfiguration ohne Logik. Im Zweifel läuft sie — Zeilen ohne Logik lässt sie selbst aus.

Die Rollen laufen als Prüfer-Rollen (siehe `_agent-process/anweisungen/rollen/README.md`); was sie prüfen, steht in ihren Dateien.

## 6a: Automatische Prüfungen

-   Alle Prüfungen aus `_context/projekt.md` → „Prüfungen" (in Stufe 0 festgelegt).
-   Was dort festgelegt, aber (noch) nicht eingerichtet ist oder nicht lief: im QA-Abschnitt ausdrücklich nennen, nicht still weglassen.
-   **Warnungen, die nicht blockieren** (z. B. Schwachstellen in Entwicklungswerkzeugen): als Hinweis unter `# QA`; ist eine neu und nicht schon erfasst: als Issue festhalten (Stufe 1, z. B. „Werkzeuge aktualisieren"), wenn sie jemand angehen will, sonst als Eintrag in `_requirements/deferred/`.
-   Ergebnis unter `# QA → Automatisch`: je Prüfung Befehl und Ergebnis.

## 6b: Prüfung durch Rollen

Reviewer, Testwirkung, Klicktester und Security laut Umfang-Tabelle; vor jedem Lauf (auch bei erneuter QA) schreibt der Agent den Diff neu nach `.qa/diff.txt` (wie, steht in `_agent-process/anweisungen/rollen/README.md`). Danach stuft er die Befunde ein (blockierend, empfohlen, Hinweis — `_agent-process/anweisungen/rollen/README.md`). Der Klicktester legt Screenshots der wichtigen Zustände unter `.qa/` ab (nicht committet), neben dem Entwurf — für das Abnahmepaket (6e).

## 6c: Befunde bearbeiten

-   **Blockierend:** zurück zu Stufe 5 (5c/5d) — mit Test, wo möglich; danach QA erneut (siehe unten: alle Prüfungen, Reviewer immer, übrige Rollen für die betroffenen Teile). Bei Track `quick` gelten die Abbruchgründe aus `_agent-process/skills/ap-requirement-build/kurzer-weg.md`.
-   **Empfohlen:** umsetzen, mit Grund ablehnen oder bewusst verschieben — dann Eintrag in `_requirements/deferred/` (Regeln in der `README.md` dort), committet mit dem QA-Abschnitt (6d); was jemand umsetzen will, als Issue festhalten (Stufe 1).
-   **Hinweis:** nach Ermessen; nichts muss. Kandidaten für später ebenfalls nach `_requirements/deferred/`.
-   **Ändert der Agent in der QA etwas:** wie in Stufe 5 — Test, wo möglich (erst rot, dann grün), danach alle Prüfungen erneut; Eintrag im Testnachweis. Unter `# QA → Befunde` steht **je Änderung** der Test (Name) oder, warum es keinen gibt — ohne eins von beiden gilt die Änderung als nicht abgeschlossen. Je umgesetztem Befund ein eigener Commit (`umsetzen.md`, Abschnitt „Commits"). **Danach läuft der Reviewer immer erneut** — auch wenn er den Befund nicht gemeldet hat —, die übrigen Rollen für die betroffenen Teile.
-   Berührt ein Befund eine Entscheidung der Anforderung: nicht selbst entscheiden — dem Nutzer vorlegen.
-   Ergebnis unter `# QA → Befunde`: je Befund kurz, was damit passiert ist.

## 6d: CI

-   Nach den Befunden: sauberer Lauf grün; **QA-Abschnitt fertig schreiben, Status `review` setzen, committen (samt Einträgen in `_requirements/deferred/`) und pushen** — danach ändert sich am Dokument in Stufe 6 nichts mehr.
-   Dann einen **Pull Request nach `release-candidate`** eröffnen, in der Beschreibung `Refs #<Nummer>` mit der Nummer aus der Zeile `Issue` im Kopf des Dokuments (fehlt sie: weglassen); der CI-Lauf läuft dort.
    -   Bei der Abkürzung (`_agent-process/skills/ap-release/SKILL.md`): Pull Request direkt nach `main`, mit `Closes #<Nummer>` statt `Refs #<Nummer>`.
    -   Sonst vorher `release-candidate` auf aktuellen Stand bringen bzw. vom aktuellen `main` anlegen, wenn es ihn noch nicht gibt (`_agent-process/AGENTS.md`, Abschnitt „Git", „Aktueller Stand").
-   **CI-Lauf abwarten** (im Pull Request).
-   **Rot in der CI:** zurück zu Stufe 5, die Korrektur als eigener Commit wie ein Befund (`umsetzen.md`, Abschnitt „Commits") — zuerst klären, warum lokal grün war (was hat lokal anders gelegen?), und das als Test bzw. im sauberen Lauf absichern.
-   **Das Ergebnis der CI steht im Pull Request,** nicht im Dokument. Bei Rot geht der Status zurück auf `qa`, bis wieder alles grün ist; der Befund kommt dann unter `# QA → Befunde`, und der Reviewer läuft erneut.

## 6e: Abnahmepaket

Für den Nutzer, kurz und in Alltagssprache, im Gespräch:

-   **Was umgesetzt ist** — drei bis fünf Sätze.
-   **Screenshots** der wichtigen Zustände aus `.qa/`, neben dem Entwurf (bei UI).
-   **Was die QA gefunden hat** und was damit passiert ist.
-   **Was die automatische Prüfung nicht abdecken konnte** — ausdrücklich, damit der Nutzer gezielt danach schaut (z. B. andere Browser-Engine als auf dem Zielgerät, Installation, Funktionen, die nur am echten Gerät laufen).
-   **Checkliste für die Abnahme** — die Kriterien mit Prüfung „manuell", als konkrete Handgriffe (z. B. „am iPhone: Kopieren, in Notizen einfügen, Text vergleichen").
-   **Wie die Abnahme lokal startet** (Befehl aus `_context/projekt.md`).
-   **Pull Request** `#<Nummer>` und dass die CI dort grün ist.

Weiter mit `_agent-process/skills/ap-requirement-accept/SKILL.md`.
