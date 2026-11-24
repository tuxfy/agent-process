---
name: ap-requirement-accept
description: Stufe 7 des Agent-Prozesses (`_agent-process`) – der Nutzer nimmt eine Anforderung ab; Befunde, Abnahme-Commit und Rückblick. Nutzen bei Status review mit grüner CI und übergebenem Abnahmepaket, oder wenn der Nutzer Befunde oder „abgenommen" meldet. Nicht für neue Wünsche (Skill ap-requirement-capture).
---

# Stufe 7: Abnahme

Der Nutzer nimmt eine Anforderung ab, auf ihrem Feature-Branch, lokal.

**Voraussetzung:** Stufe 6 abgeschlossen, Abnahmepaket liegt vor, Status `review`.

| Schritt | Wer | Ergebnis |
|---|---|---|
| 7a Prüfen | Nutzer | Abnahme nach Checkliste des Abnahmepakets |
| 7b Befunde | Agent | zurück zu Stufe 5, danach QA erneut |
| 7c Abgenommen | Nutzer, dann Agent | Status `accepted`, Abnahme und Rückblick in einem Commit, CI grün, dann „bereit zum Zusammenführen“ |
| 7d Rückblick | Agent | Inhalt des Rückblicks — Teil des Commits aus 7c |

## 7a: Prüfen

-   Nutzer startet die App lokal (Befehl in `_context/projekt.md`), geht die Checkliste des Abnahmepakets durch; vor allem, was nicht automatisch prüfbar ist (z. B. am Gerät).
-   Zur UI-Richtlinie von Hand prüfen, was Prüflauf und QA nicht erkennen.

## 7b: Befunde

1.  Befunde des Nutzers zuerst unter `# Abnahme → Befunde` ins Dokument (je Befund ein Punkt).
2.  Zurück zu Stufe 5 (mit Test, wo möglich); je umgesetztem Befund ein eigener Commit (`_agent-process/skills/ap-requirement-build/umsetzen.md`, „Commits").
3.  Danach Stufe 6 für die betroffenen Teile erneut, Reviewer immer.

-   Track `quick`: Abbruchgründe aus `_agent-process/skills/ap-requirement-build/kurzer-weg.md`.
-   Neue Wünsche über die Anforderung hinaus: als Issue (Stufe 1), nicht in diese Anforderung.
-   Befund, den der Nutzer bewusst verschiebt: Eintrag in `_requirements/deferred/` (Regeln in der `README.md` dort), committet mit dem Commit aus 7c.

## 7c: Abgenommen

1.  Nutzer gibt ausdrücklich frei.
2.  **Ein Commit, vor dem Zusammenführen:** Status `accepted`; Ergebnis unter `# Abnahme` (Datum, was geprüft wurde); Rückblick (7d); Dokument nach `_requirements/done/` verschoben; ggf. Einträge in `_requirements/deferred/`. Committen und pushen; CI im Pull Request läuft erneut.
3.  **Erst bei grüner CI** „bereit zum Zusammenführen“ melden, vorher nicht. Dazu sagen: Zusammenführen nach `release-candidate` heißt, kommt ins nächste Release; soll die Anforderung noch warten, bleibt der Pull Request offen.
4.  **Nutzer führt den Pull Request zusammen** (nach `release-candidate`). Agent wartet, fragt nicht nach.

-   Ab dem Commit ist das Dokument eingefroren. Was danach auffällt: neue Idee bzw. Bug, kein zweiter Pull Request.
-   Release-Dokument gibt es noch nicht; entsteht erst in Stufe 8.

## 7d: Rückblick

Kurz festhalten, was gehakt hat; fertig vor dem Commit aus 7c:

-   **Projekt betreffend** → `_context/` ergänzen.
-   **Prozess betreffend** → als Vorschlag fürs Prozess-Repo notieren (nichts unter `_agent-process/` im Projekt ändern). Fehler schon in einem früheren Rückblick → als Zeile für „Bekannte Fehler“ in `_agent-process/AGENTS.md` vorschlagen.
