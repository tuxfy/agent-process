# Stufe 7: Abnahme

Der Nutzer nimmt eine Anforderung ab — auf ihrem Feature-Branch, lokal. Voraussetzung: Stufe 6 abgeschlossen, Abnahmepaket liegt vor, Status `review`.

| Schritt | Wer | Ergebnis |
|---|---|---|
| 7a Prüfen | Nutzer | Abnahme nach Checkliste des Abnahmepakets |
| 7b Befunde | Agent | zurück zu Stufe 5, danach QA erneut |
| 7c Abgenommen | Nutzer | Status `accepted`, Dokument in `_requirements/done/`, Pull Request vom Nutzer zusammengeführt |
| 7d Rückblick | Agent | Erkenntnisse für Projekt bzw. Prozess-Repo |

## 7a: Prüfen

-   Der Nutzer startet die App lokal (Befehl in `_context/projekt.md`) und geht die Checkliste des Abnahmepakets durch — vor allem, was sich nicht automatisch prüfen lässt (z. B. am Gerät).
-   Zur UI-Richtlinie bleibt von Hand zu prüfen, was Prüflauf und QA nicht erkennen.

## 7b: Befunde

-   Befunde → zurück zu Stufe 5 (mit Test, wo möglich), danach Stufe 6 für die betroffenen Teile erneut.
-   Neue Wünsche, die über die Anforderung hinausgehen: als Idee ins Backlog, nicht in diese Anforderung.

## 7c: Abgenommen

-   Der Nutzer gibt ausdrücklich frei. Status `accepted`, Ergebnis unter `# Abnahme` (Datum, was geprüft wurde).
-   Der Agent verschiebt das Dokument nach `_requirements/done/` — ab jetzt ist es eingefroren.
-   Der Agent committet Status, Abnahme, Verschieben und Rückblick (7d) auf dem Feature-Branch und pusht; die CI im Pull Request läuft erneut.
-   **Der Nutzer führt den Pull Request zusammen** (nach `next`). Der Agent wartet darauf und fragt nicht nach.
-   **Zusammenführen nach `next` heißt: kommt ins nächste Release.** Der Agent sagt das am Ende der Abnahme dazu: Soll die Anforderung noch warten, bleibt der Pull Request offen.
-   Ein Release-Dokument gibt es noch nicht — es entsteht erst in Stufe 8.

## 7d: Rückblick

Kurz festhalten, was gehakt hat:

-   **Projekt betreffend** → `_context/` ergänzen.
-   **Prozess betreffend** → als Vorschlag fürs Prozess-Repo notieren (nichts unter `_agent-process/` im Projekt ändern).
-   Rückblick committen.
