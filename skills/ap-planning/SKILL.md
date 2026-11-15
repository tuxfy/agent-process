---
name: ap-planning
description: Teil des Agent-Prozesses (`_agent-process`) – Überblick über die offenen Issues eines Projekts: geht mit dem Nutzer die Seite „Planung" durch, den Überblick über die offenen Issues (Reihenfolge, Verbindungen), und passt sie an. Nutzen nur, wenn der Nutzer „Planung" sagt. Nicht für die Arbeit an einer einzelnen Anforderung und nicht von selbst.
---

# Planung

Ein Arbeitsdokument für den Nutzer, keine Quelle für Entscheidungen: Es zeigt, in welcher Reihenfolge er die offenen Issues angehen will und wie sie zusammenhängen. Maßgeblich bleiben die Issues und Anforderungen. Der Nutzer stößt die Planung an und entscheidet; zwischen zwei Planungen ändert der Agent die Seite nicht (sonst liest er sie auch nicht: `_agent-process/AGENTS.md`, Tabelle der Skills).

## Wo die Seite liegt

Gibt es `planung.md` im Hauptordner des Projekts (von Git ignoriert, Init trägt sie in `.gitignore` ein), liegt sie dort. Sonst fragt der Agent, ob sie als Wiki-Seite „Planung" beim Hoster liegt oder als `planung.md` neu entstehen soll.

-   **Wiki beim Hoster (GitHub und GitLab):** nur über das Wiki-Repo, nie über die API oder die Weboberfläche. Adresse: Ausgabe von `git remote get-url origin`, ohne `/` und `.git` am Ende, dahinter `.wiki.git` (SSH bleibt SSH, HTTPS bleibt HTTPS). In Schritt 1 klont der Agent es in ein temporäres Verzeichnis außerhalb des Projekts (`d="$(mktemp -d)" && git clone <Adresse> "$d/wiki" && echo "$d/wiki"`) und merkt sich den Pfad. Dort liest und ändert er nur `Planung.md`, eine andere Datei nie. Ist das Wiki-Repo leer, gilt „Wenn das nicht geht"; fehlt nur `Planung.md`, fragt er, ob er sie neu anlegen soll; wenn nicht, gilt „Wenn das nicht geht". In Schritt 4 fügt er sie namentlich hinzu, committet mit `chore(planung): Planung aktualisiert` auf dem Branch, den der Klon ausgecheckt hat (kein eigener Branch, auch wenn er `main` heißt), und pusht. Zwischen Klonen und Push kein `fetch` und kein `pull` — „Aktueller Stand" (`_agent-process/AGENTS.md`, „Git") gilt für das Wiki-Repo nicht. Scheitert der Commit (z. B. fehlende Identität), hält er an und fragt; nichts umkonfigurieren. Lehnt der Hoster den Push ab (Wiki seit Schritt 1 geändert), hält er an, klont neu in ein neues Verzeichnis, zeigt dem Nutzer die Unterschiede an `Planung.md` und fragt, ob er seinen Text auf dieser Grundlage neu schreiben soll — kein Pull, kein Rebase, kein Merge, kein Force. Die temporären Verzeichnisse löscht er, sobald der Push gelungen ist oder der Nutzer die Änderung verwirft, vorher nicht.
-   **Wenn das nicht geht** (Wiki nicht aktiv, bei GitHub noch keine erste Seite, Klonen scheitert): Der Nutzer gibt den Inhalt, der Agent gibt den neuen Text zum Einfügen aus.
-   **`planung.md` neu:** Vorher prüft der Agent mit `git check-ignore -q planung.md`, ob Git sie ignoriert; wenn nicht, bittet er den Nutzer, Init erneut laufen zu lassen.

`planung.md` liegt nie unter `_context/` und wird nie committet.

## Inhalt

-   **Stand:** Datum der letzten Planung.
-   **Als Nächstes:** die nächsten wenigen Issues in Reihenfolge, je mit einem kurzen Grund. Weiter nach vorn wird nicht geplant.
-   **Verbindungen:** welche Issues zusammenhängen oder neu geschnitten werden sollen, je mit einem Satz.
-   **Übrige:** die übrigen offenen Issues, ohne Reihenfolge.

Nur Verweise als `#<Nummer> (<Kurztitel>)` und kurze Gründe — kein Status, keine Details aus den Issues, nur abstrakt (`_agent-process/AGENTS.md`, „Grundsätze", „Dokumente und Issues").

## Ablauf

1.  **Lesen:** die Seite (Wiki: vorher klonen wie unter „Wo die Seite liegt") und alle offenen Issues mit Nummer, Titel, Label und Text (`gh issue list --state open --limit 200 --json number,title,labels,body` bzw. `glab issue list`, alle Seiten, als JSON).
2.  **Vorschlag einholen:** Rolle Planung (`_agent-process/anweisungen/rollen/planung.md`); Seite und Liste der offenen Issues übergibt der Agent im Auftrag als Text.
3.  **Durchgehen:** Der Agent legt dem Nutzer den Vorschlag vor, verständlich und je Issue mit Nummer und Inhalt; der Nutzer entscheidet je Punkt.
4.  **Anpassen:** Der Agent schreibt die Seite nach den Entscheidungen neu (bzw. gibt den Text zum Einfügen aus); Wiki: committen, pushen und aufräumen wie unter „Wo die Seite liegt".
5.  **Folgen nur nach Ja des Nutzers:** Verbindungen und Schnitte als Kommentar in die betroffenen Issues; Issues zusammenlegen heißt, eines zu schließen — das übernimmt der Nutzer beim Hoster (`_agent-process/AGENTS.md`, „Git", „Issues"); eine Lücke oder etwas, das dauerhaft in `_context/` gehört, als Issue (`ap-requirement-capture`) — `_context/` ändert erst dessen Anforderung.

Kein Branch und kein Commit im Projekt-Repo; im Wiki-Repo nur der Commit aus „Wo die Seite liegt".
