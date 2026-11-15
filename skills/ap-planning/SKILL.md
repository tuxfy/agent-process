---
name: ap-planning
description: Teil des Agent-Prozesses (`_agent-process`) – Überblick über die offenen Issues eines Projekts: geht mit dem Nutzer die Seite „Planung" durch, den Überblick über die offenen Issues (Reihenfolge, Verbindungen), und passt sie an. Nutzen nur, wenn der Nutzer „Planung" sagt. Nicht für die Arbeit an einer einzelnen Anforderung und nicht von selbst.
---

# Planung

Ein Arbeitsdokument für den Nutzer, keine Quelle für Entscheidungen: Es zeigt, in welcher Reihenfolge er die offenen Issues angehen will und wie sie zusammenhängen. Maßgeblich bleiben die Issues und Anforderungen. Der Nutzer stößt die Planung an und entscheidet; zwischen zwei Planungen ändert der Agent die Seite nicht (sonst liest er sie auch nicht: `_agent-process/AGENTS.md`, Tabelle der Skills).

## Wo die Seite liegt

Gibt es `planung.md` im Hauptordner des Projekts (von Git ignoriert, Init trägt sie in `.gitignore` ein), liegt sie dort. Sonst fragt der Agent: Liegt sie als Wiki-Seite „Planung" beim Hoster — dann gibt der Nutzer den Inhalt, und der Agent gibt den neuen Text zum Einfügen aus; das Wiki schreibt er nie selbst —, oder soll sie als `planung.md` neu entstehen? Vorher prüft er mit `git check-ignore -q planung.md`, ob Git sie ignoriert; wenn nicht, bittet er den Nutzer, Init erneut laufen zu lassen. Nie unter `_context/` und nie committet.

## Inhalt

-   **Stand:** Datum der letzten Planung.
-   **Als Nächstes:** die nächsten wenigen Issues in Reihenfolge, je mit einem kurzen Grund. Weiter nach vorn wird nicht geplant.
-   **Verbindungen:** welche Issues zusammenhängen oder neu geschnitten werden sollen, je mit einem Satz.
-   **Übrige:** die übrigen offenen Issues, ohne Reihenfolge.

Nur Verweise als `#<Nummer> (<Kurztitel>)` und kurze Gründe — kein Status, keine Details aus den Issues, nur abstrakt (`_agent-process/AGENTS.md`, „Grundsätze", „Dokumente und Issues").

## Ablauf

1.  **Lesen:** die Seite und alle offenen Issues mit Nummer, Titel, Label und Text (`gh issue list --state open --limit 200 --json number,title,labels,body` bzw. `glab issue list`, alle Seiten, als JSON).
2.  **Vorschlag einholen:** Rolle Planung (`_agent-process/anweisungen/rollen/planung.md`); Seite und Liste der offenen Issues übergibt der Agent im Auftrag als Text.
3.  **Durchgehen:** Der Agent legt dem Nutzer den Vorschlag vor, verständlich und je Issue mit Nummer und Inhalt; der Nutzer entscheidet je Punkt.
4.  **Anpassen:** Der Agent schreibt die Seite nach den Entscheidungen neu (bzw. gibt den Text zum Einfügen aus).
5.  **Folgen nur nach Ja des Nutzers:** Verbindungen und Schnitte als Kommentar in die betroffenen Issues; Issues zusammenlegen heißt, eines zu schließen — das übernimmt der Nutzer beim Hoster (`_agent-process/AGENTS.md`, „Git", „Issues"); eine Lücke oder etwas, das dauerhaft in `_context/` gehört, als Issue (`ap-requirement-capture`) — `_context/` ändert erst dessen Anforderung.

Kein Branch, kein Commit.
