# Stufe 7: Abnahme

Der Nutzer nimmt eine Anforderung ab — auf ihrem Feature-Branch, lokal. Voraussetzung: Stufe 6 abgeschlossen, Abnahmepaket liegt vor, Status `review`.

| Schritt | Wer | Ergebnis |
|---|---|---|
| 7a Prüfen | Nutzer | Abnahme nach Checkliste des Abnahmepakets |
| 7b Befunde | Agent | zurück zu Stufe 5, danach QA erneut |
| 7c Abgenommen | Nutzer, dann Agent | Status `accepted`, Abnahme und Rückblick in einem Commit, CI grün, dann „bereit zum Zusammenführen“ |
| 7d Rückblick | Agent | Inhalt des Rückblicks — Teil des Commits aus 7c |

## 7a: Prüfen

-   Der Nutzer startet die App lokal (Befehl in `_context/projekt.md`) und geht die Checkliste des Abnahmepakets durch — vor allem, was sich nicht automatisch prüfen lässt (z. B. am Gerät).
-   Zur UI-Richtlinie bleibt von Hand zu prüfen, was Prüflauf und QA nicht erkennen.

## 7b: Befunde

-   Befunde → zurück zu Stufe 5 (mit Test, wo möglich), danach Stufe 6 für die betroffenen Teile erneut.
-   Neue Wünsche, die über die Anforderung hinausgehen: als Idee ins Backlog, nicht in diese Anforderung.

## 7c: Abgenommen

-   Der Nutzer gibt ausdrücklich frei.
-   **Ein Commit, vor dem Zusammenführen:** Status `accepted`, Ergebnis unter `# Abnahme` (Datum, was geprüft wurde), Rückblick (7d), Dokument nach `_requirements/done/` verschoben. Der Agent committet und pusht; die CI im Pull Request läuft erneut.
-   **Erst bei grüner CI** meldet der Agent „bereit zum Zusammenführen“ — vorher nicht. Dazu sagt er: Zusammenführen nach `release-candidate` heißt, kommt ins nächste Release; soll die Anforderung noch warten, bleibt der Pull Request offen.
-   **Der Nutzer führt den Pull Request zusammen** (nach `release-candidate`). Der Agent wartet darauf und fragt nicht nach.
-   Ab dem Commit ist das Dokument eingefroren. Was danach noch auffällt, wird eine neue Idee bzw. ein Bug — kein zweiter Pull Request.
-   Ein Release-Dokument gibt es noch nicht — es entsteht erst in Stufe 8.

## 7d: Rückblick

Kurz festhalten, was gehakt hat — fertig, bevor der Commit aus 7c entsteht:

-   **Projekt betreffend** → `_context/` ergänzen.
-   **Prozess betreffend** → als Vorschlag fürs Prozess-Repo notieren (nichts unter `_agent-process/` im Projekt ändern).
