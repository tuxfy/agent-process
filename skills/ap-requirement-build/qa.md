# Stufe 6: QA

Prüft eine umgesetzte Anforderung über die Tests hinaus, bevor der Nutzer sie abnimmt.

**Voraussetzung:** Stufe 5 abgeschlossen, alle Tests und Prüflauf grün, Status `qa`, auf dem Feature-Branch.

| Schritt | Wer | Ergebnis |
|---|---|---|
| 6a Automatische Prüfungen | Agent | Ergebnis unter `# QA → Automatisch` |
| 6b Prüfung durch Rollen | Prüfer (nur lesend) | Befunde, vom Agenten eingeordnet |
| 6c Befunde bearbeiten | Agent; Nutzer bei „entscheiden" | jeder Befund umgesetzt, zurückgestellt, verworfen oder vermerkt |
| 6d CI | Agent | QA-Abschnitt und Status `review` committet, Pull Request eröffnet, CI grün |
| 6e Abnahmepaket | Agent | Paket für den Nutzer (im Gespräch) |

## Umfang

Erste passende Zeile gilt.

| Änderung | 6a | Reviewer | Testwirkung | Klicktester | Security |
|---|---|---|---|---|---|
| Spielraum „Schnittstellen/Daten" angekreuzt, neue Abhängigkeiten oder externe Dienste (Umsetzungsplan → Externe Abhängigkeiten) oder Auslieferung (Plan berührt CI, Hosting oder Release) | ✓ | ✓ | ✓ wenn der Diff Code ändert | ✓ bei UI | ✓ |
| Alles andere — Feature oder Bug, Track `quick` oder `complete` | ✓ | ✓ | ✓ wenn der Diff Code ändert | ✓ bei UI | bei Bedarf |

## 6a: Automatische Prüfungen

-   Alle Prüfungen aus `_context/projekt.md` → „Prüfungen" (festgelegt in Stufe 0).
-   Festgelegt, aber (noch) nicht eingerichtet oder nicht gelaufen: im QA-Abschnitt ausdrücklich nennen, nicht still weglassen.
-   **Nicht blockierende Warnungen** (z. B. Schwachstellen in Entwicklungswerkzeugen): unter `# QA` vermerken. Neu und noch nicht erfasst → Issue (Stufe 1, z. B. „Werkzeuge aktualisieren"), wenn es jemand angehen will; sonst Eintrag in `_requirements/deferred/`.
-   Ergebnis unter `# QA → Automatisch`: je Prüfung Befehl und Ergebnis.

## 6b: Prüfung durch Rollen

Reviewer, Testwirkung, Klicktester, Security laut Umfang-Tabelle.

-   Vor jedem Lauf (auch bei erneuter QA) Diff neu nach `.qa/diff.txt` (wie: `_agent-process/anweisungen/rollen/README.md`).
-   Danach Befunde einordnen (`_agent-process/anweisungen/einstufung.md`).
-   Klicktester legt Screenshots wichtiger Zustände unter `.qa/` ab (nicht committet), neben dem Entwurf; für das Abnahmepaket (6e).

## 6c: Befunde bearbeiten

-   **Reihenfolge:**
    1.  dem Nutzer vorlegen, was laut Einstufung zu ihm geht;
    2.  nach seiner Antwort umsetzen: Gruppe „umsetzen" und was der Nutzer umgesetzt haben will;
    3.  „zurückstellen" und „vermerken" sonst nicht umsetzen.
-   **Entscheiden:**
    -   Was der Nutzer umgesetzt haben will: wie „umsetzen". Weitet es Anliegen oder Entscheidung aus oder schränkt sie ein: `_agent-process/AGENTS.md`, „Halten"; bei Track `quick` zusätzlich die Abbruchgründe.
    -   Blockierendes nicht zurückstellen: nur umsetzen oder die Entscheidung im Refinement ändern.
-   **Umsetzen:**
    -   zurück zu Stufe 5 (5c/5d);
    -   danach QA erneut (alle Prüfungen; Reviewer immer, übrige Rollen für die betroffenen Teile);
    -   bei Track `quick`: Abbruchgründe aus `_agent-process/skills/ap-requirement-build/kurzer-weg.md`.
-   **Zurückstellen:** Eintrag in `_requirements/deferred/` (Regeln in der `README.md` dort), committet mit dem QA-Abschnitt (6d); bzw. Issue (Stufe 1).
-   **Verwerfen, vermerken, Behelf:** unter `# QA → Befunde`, mit Grund bzw. „bleibt bis #<Nummer>".
-   **Korrekturen nur über „Umsetzen":** während der QA nichts nebenbei korrigieren.
-   **Ergebnis** unter `# QA → Befunde`: je Befund kurz, was damit passiert ist.

## 6d: CI

1.  Nach den Befunden: sauberer Lauf grün; QA-Abschnitt fertig; Status `review`; committen (samt Einträgen in `_requirements/deferred/`) und pushen. Danach ändert sich in Stufe 6 nichts mehr am Dokument.
2.  **Pull Request nach `release-candidate`;** Beschreibung `Refs #<Nummer>` (Nummer aus Zeile `Issue` im Kopf des Dokuments; fehlt sie: weglassen). Dort läuft die CI.
    -   Abkürzung (`_agent-process/skills/ap-release/SKILL.md`): Pull Request direkt nach `main`, mit `Closes #<Nummer>` statt `Refs #<Nummer>`.
    -   Sonst vorher `release-candidate` auf aktuellen Stand bringen bzw. vom aktuellen `main` anlegen, wenn es ihn noch nicht gibt (`_agent-process/AGENTS.md`, „Git", „Aktueller Stand").
3.  **CI-Lauf abwarten** (im Pull Request).

-   **Rot in der CI:** zurück zu Stufe 5; zuerst klären, warum lokal grün war (was lag lokal anders?); Korrektur als eigener Commit wie ein Befund (`umsetzen.md`, „Commits").
-   **Ergebnis der CI steht im Pull Request,** nicht im Dokument. Bei Rot: Status zurück auf `qa` bis alles grün; Befund unter `# QA → Befunde`; Reviewer läuft erneut.

## 6e: Abnahmepaket

Für den Nutzer im Gespräch:

-   **Was umgesetzt ist:** drei bis fünf Sätze.
-   **Screenshots** wichtiger Zustände aus `.qa/`, neben dem Entwurf (bei UI).
-   **Was die QA gefunden hat:** Entschiedenes mit Ergebnis; Zurückgestelltes mit Schwere hoch einzeln, übrige je Gruppe mit Zahl; Einzelheiten unter `# QA → Befunde`.
-   **Was die automatische Prüfung nicht abdecken konnte,** ausdrücklich, damit der Nutzer gezielt schaut (z. B. andere Browser-Engine als auf dem Zielgerät, Installation, Funktionen nur am echten Gerät).
-   **Checkliste für die Abnahme:** Kriterien mit Prüfung „manuell" als konkrete Handgriffe (z. B. „am iPhone: Kopieren, in Notizen einfügen, Text vergleichen").
-   **Wie die Abnahme lokal startet** (Befehl aus `_context/projekt.md`).
-   **Pull Request** `#<Nummer>`, CI dort grün.

Weiter mit `_agent-process/skills/ap-requirement-accept/SKILL.md`.
