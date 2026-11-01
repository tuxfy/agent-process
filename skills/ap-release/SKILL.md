---
name: ap-release
description: Stufe 8 des Agent-Prozesses (`_agent-process`) – bringt den Stand von release-candidate live (Inhalt und Version, Gesamtprüfung, Ausliefern, Nachprüfen). Nutzen, wenn der Nutzer „release" sagt oder ein Release offen ist (Release-Dokument ohne Tag, Pull Request nach main offen oder zusammengeführt, Nachprüfung ausstehend). Nicht für Abnahme oder Umsetzung einzelner Anforderungen.
---

# Stufe 8: Release

Bringt den Stand von `release-candidate` — eine oder mehrere abgenommene Anforderungen — live. **Wann** released wird, entscheidet der Nutzer; **was** mitkommt, hat er schon entschieden: alles, was er nach `release-candidate` zusammengeführt hat (siehe `_agent-process/skills/ap-requirement-accept/SKILL.md`, 7c). Die **Version** wird erst jetzt bestimmt, aus dem Inhalt. Ein Release hat ein eigenes Dokument `_releases/<version>.md`. Auslieferung: `_context/projekt.md`.

**Grundsatz:** Was live ist, zeigt Git — der Tag `v<version>` und das Release-Dokument, das mit ihm nach `main` kam. Es gibt keinen Status „live" in Dokumenten und nach dem Tag keinen Commit mehr.

| Schritt | Wer | Ergebnis |
|---|---|---|
| 8a Inhalt und Version | Agent | Inhalt und Version nach festen Regeln, Release-Dokument auf `release-candidate` |
| 8b Gesamtprüfung | Agent | alle Prüfungen grün auf `release-candidate`, Release-Dokument fertig, Pull Request nach `main`, **CI grün** |
| 8c Ausliefern | Nutzer | Pull Request als Merge-Commit zusammengeführt — **das ist die Freigabe**; Tag durch die CI (sonst durch den Nutzer) |
| 8d Nachprüfen | CI + Agent + Nutzer | automatischer Test des ausgelieferten Stands, Gerät durch den Nutzer |

Welche Datei dran ist, zeigen die Release-Dokumente unter `_releases/` auf `release-candidate`, die Tags `v*`, der Git-Verlauf von `release-candidate` und der Pull Request nach `main`. **Offenes Release** = ein Release-Dokument, zu dem es noch keinen Tag `v<version>` gibt. Es gilt die erste passende Zeile. Nur diese Datei laden — ganz:

| Stand | Datei |
|---|---|
| Offenes Release, Pull Request nach `main` zusammengeführt | `ausliefern.md`, 8c (Tag) |
| Offenes Release, Pull Request nach `main` offen, CI grün oder noch laufend (abwarten), `# Gesamtprüfung` im Release-Dokument ausgefüllt und danach kein Commit auf `release-candidate` | `ausliefern.md`, 8c (Zusammenführen durch den Nutzer abwarten) |
| Offenes Release, sonst | `gesamtpruefung.md` (8b) |
| Tag gerade gesetzt, Nachprüfung noch nicht gemeldet — nur im Gespräch erkennbar, im Zweifel nachfragen | `ausliefern.md`, 8d |
| Nutzer sagt „release" | `inhalt-version.md` (8a) |
| Abkürzung (siehe unten) | `gesamtpruefung.md` auf dem Feature-Branch, nach dem Zusammenführen `ausliefern.md`, 8d |

## Abkürzung

Ist im Projekt festgelegt, dass Zusammenführen bereits ausliefert (z. B. „jeder Stand auf `main` geht live"), gibt es kein `release-candidate`: Der Pull Request der Anforderung geht direkt nach `main`; der Nutzer führt ihn nach der Abnahme zusammen; Stufe 8 besteht dann nur aus 8b (auf dem Feature-Branch) und 8d, ein Release-Dokument entfällt.
