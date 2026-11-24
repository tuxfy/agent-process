---
name: ap-planning
description: Teil des Agent-Prozesses (`_agent-process`) – Überblick über die offenen Issues eines Projekts: geht mit dem Nutzer die Seite „Planung" durch, den Überblick über die offenen Issues (Weg zu einem Ziel, Reihenfolge, Verbindungen), und passt sie an. Nutzen nur, wenn der Nutzer „Planung" sagt. Nicht für die Arbeit an einer einzelnen Anforderung und nicht von selbst.
---

# Planung

Arbeitsdokument für gezieletes Vorgehen. Es zeigt den Weg zu definierten Zwischenzielen durch:
- Sortieren von vorhandene Issues
- Hinzufügen von nötigen Aufgaben, die noch nicht als Issue existieren
- Aufzeigen der Zusammenhänge zwischen den Aufgaben

Das Dokument ist kein unumstößlicher Plan nach Wasserfall und wird zusammen mit Nutzer kontinuierlich aktuell gehalten.


## Wo die Seite liegt

- Gibt es `planung.md` im Hauptordner? ja -> dann diese Datei nutzen
- Gibt es `planung.md` im Hauptordner? nein -> Wiki-Seite "Planung" um Git nutzen
    - existiert die Wiki-Seite noch nicht dann anlegen
    - Nutzung: 
        - nur über das Wiki-Repo, nie über die API
        - in temporäres Verzeichnis `.tmp/wiki` außerhalb Projekt klonen 
        - `.tmp `in `.gitignore` eintragen, wenn noch nicht vorhanden
        - Identität des Nutzers verwenden für Commits

## Inhalt

-   **Stand:** Datum der letzten Planung.

### Pro Zwischenziel:
-   **Ziel:** ein prüfbares Ergebnis in einem Satz, kein Thema (z. B. „Ein neues Image erreicht den Server ohne Handgriff" statt „Updates"). Ein Ziel je Planung-Paket; über das Ziel hinaus wird nicht geplant. Erreicht ist es, wenn keine Zeile mit Bezug zum Ziel mehr offen ist; Zeilen `neu` zählen als offen.
-   **Als Nächstes:** Tabelle `| # | Issue | Heute | Danach | Warum hier |`, `#` ist die laufende Nummer der Zeile. Von oben nach unten:
    1.  Bugs mit Schwere hoch (Zeile „Schwere" im Issue; fehlt sie, fragt der Agent in Schritt 3 danach), auch ohne Bezug zum Ziel, davor, was sie voraussetzen;
    2.  was das Ziel braucht;
    3.  eine Trennzeile („nützlich für das Ziel" in der Spalte Issue), darunter, was dem Ziel hilft, ohne nötig zu sein.

    *Heute:* wie es jetzt ist, laut Issue. *Danach:* was nach dem Issue anders ist. *Warum hier:* der Bezug zum Ziel oder zu der späteren Zeile, die es braucht; bei Bugs ohne Bezug zum Ziel „Bug, Schwere hoch". Je ein Satz, verständlich ohne das Issue. Eine Zeile hängt nur von früheren Zeilen ab; hängt sie von einer späteren ab oder hängen zwei voneinander ab, gehört ein Neuschnitt unter „Verbindungen". Eine Zeile kann Zusammengehöriges oder einen Teil nennen (`#13 (…) mit #6 (…)`, `#27 (…) Teil a`).

    *Zeilen `neu`:* Braucht das Ziel oder eine Zeile über der Trennzeile etwas, wofür es kein offenes Issue gibt (auch wenn es unter `_requirements/deferred/` steht), steht es als Zeile `neu: <Kurztitel>` dabei. *Heute* dann laut `_context/` oder mit „(Annahme)"; *Warum hier* nennt, welche Zeile oder ob das Ziel selbst es braucht, Vermutetes endet mit „(Annahme)". Für Nützliches und für „Übrige" keine Zeilen `neu`.
-   **Verbindungen:** welche Issues zusammenhängen oder neu geschnitten werden sollen, je mit einem Satz.
-   **Übrige:** die offenen Issues ohne Bezug zum Ziel, außer Bugs mit Schwere hoch; ohne Reihenfolge.

Issues als `#<Nummer> (<Kurztitel>)`. Nicht auf die Seite: Status der Anforderung, offene Fragen zur Umsetzung (die gehören in die Klärung des Issues) und wie der Nutzer dem Weg folgt. Sicherheitsthemen nur abstrakt (`_agent-process/AGENTS.md`, „Grundsätze", „Dokumente und Issues").

## Ablauf

1.  **Lesen:** 
	1. die Seite (Wiki: vorher klonen wie unter „Wo die Seite liegt") 
	2. alle offenen Issues mit Nummer, Titel, Label und Text (`gh issue list --state open --limit 200 --json number,title,labels,body` bzw. `glab issue list`, alle Seiten, als JSON).
2.  **Vorschlag einholen:** Rolle Planung (`_agent-process/anweisungen/rollen/planung.md`)
	- übergeben:
	    - Seite
	    - Liste der offenen Issues und das Ziel, das der Nutzer beim Anstoß genannt hat (sonst „kein Ziel genannt")
3.  **Durchgehen:** 
	1. Agent legt dem Nutzer den Vorschlag vor -> Ziel und Tabelle wie auf der Seite, dann Verbindungen und was sich gegenüber der Seite ändert 
	2. verständlich und je Issue mit Nummer und Inhalt
	3. Nutzer entscheidet je Punkt
	4. Ändert Nutzer das Ziel, holt der Agent mit dem neuen Ziel einen neuen Vorschlag ein (Schritt 2).
4.  **Anpassen:** 
	1. Zeilen `neu`, die der Nutzer als Issue will, legt  Agent  an (`ap-requirement-capture`) und trägt die Nummer ein
	2. dann schreibt er die Seite nach den Entscheidungen neu (bzw. gibt den Text zum Einfügen aus); Wiki: committen, pushen und aufräumen wie unter „Wo die Seite liegt"
5.  **Folgen nur nach Ja des Nutzers:** 
	1. Verbindungen und Schnitte als Kommentar in die betroffenen Issues
	2. Issues zusammenlegen heißt, eines zu schließen -> übernimmt der Nutzer beim Hoster
	3. etwas, das dauerhaft in `_context/` gehört, als Issue (`ap-requirement-capture`) — `_context/` ändert erst dessen Anforderung

Kein Branch und kein Commit im Projekt-Repo; im Wiki-Repo nur der Commit aus „Wo die Seite liegt".
