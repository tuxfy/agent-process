---
name: ap-requirement-build
description: Stufen 5–6 des Agent-Prozesses (`_agent-process`) – plant, setzt um und prüft eine Anforderung (Plan, Umsetzung, kurzer Weg, QA). Nutzen bei einer Anforderung mit Status refined, in progress, qa oder review vor der Abnahme. Nicht für Änderungen nur an Prozess-Dokumenten, nicht für Abnahme (Status review mit Abnahmepaket → `_agent-process/skills/ap-requirement-accept/SKILL.md`) oder Release.
---

# Umsetzung und QA (Stufen 5–6)

Welche Datei dran ist, zeigen das Anforderungsdokument und der Git-Verlauf des Branches. Es gilt die erste passende Zeile. Nur diese Datei laden — ganz:

| Stand | Datei |
|---|---|
| `refined` oder `in progress`, Track `quick` | `kurzer-weg.md`, ab dem ersten offenen Schritt |
| `refined`, ohne Commit `chore(<kurzer-name>): Umsetzungsplan` | `planen.md` (5a) |
| `refined`, Plan committet | `umsetzen.md`, ab 5b |
| `in progress`, mit Commit `chore(<kurzer-name>): Track complete` und ohne Commit `chore(<kurzer-name>): Umsetzungsplan` nach dem letzten davon | `planen.md` (5a) |
| `in progress` | `umsetzen.md`, ab dem ersten offenen Schritt |
| `qa` | `qa.md` |
| `review` | `_agent-process/skills/ap-requirement-accept/SKILL.md` — fehlt dort die Voraussetzung (CI grün, Abnahmepaket gegeben), zuerst `qa.md` ab 6d |

Rote CI (6d), QA-Befunde der Gruppe „umsetzen" (6c, auch aus „entscheiden") und Befunde aus der Abnahme (7b) führen zurück zu `umsetzen.md` (5c/5d) — wie in `qa.md` bzw. `_agent-process/skills/ap-requirement-accept/SKILL.md` beschrieben.

| Schritt | Wer | Ergebnis |
|---|---|---|
| 5a Plan | Agent schreibt, Rollen prüfen, Nutzer gibt frei | Abschnitt `# Umsetzungsplan`, Zusammenfassung für den Nutzer, **Commit und Push** |
| 5b Start | Agent | direkt nach der Plan-Freigabe (nach „später": auf das Wort des Nutzers): Status `in progress`, **Commit** |
| 5c Test zuerst | Agent | roter Test, Testnachweis „Rot" |
| 5d Umsetzen | Agent | Änderung nach Plan, Entscheidungen und UI-Richtlinie |
| 5e Grün | Agent | alle Tests und Prüflauf grün, Testnachweis „Grün", Status `qa` |

Danach: Abnahme (`_agent-process/skills/ap-requirement-accept/SKILL.md`), Release (`_agent-process/skills/ap-release/SKILL.md`).
