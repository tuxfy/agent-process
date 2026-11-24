---
name: ap-planning
description: Teil des Agent-Prozesses (`_agent-process`) – Überblick über die offenen Issues eines Projekts: geht mit dem Nutzer die Seite „Planung" durch, den Überblick über die offenen Issues (Weg zu einem Ziel, Reihenfolge, Verbindungen), und passt sie an. Nutzen nur, wenn der Nutzer „Planung" sagt. Nicht für die Arbeit an einer einzelnen Anforderung und nicht von selbst.
---

# Planung

Arbeitsdokument für gezieltes Vorgehen. Zeigt den Weg zu definierten Zwischenzielen:

-   vorhandene Issues sortieren;
-   nötige Aufgaben ergänzen, die noch kein Issue haben;
-   Zusammenhänge zwischen den Aufgaben zeigen.

Kein unumstößlicher Plan nach Wasserfall; wird mit dem Nutzer laufend aktuell gehalten.

## Wo die Seite liegt

-   `planung.md` im Hauptordner vorhanden → diese Datei nutzen.
-   Sonst Wiki-Seite „Planung" über Git; fehlt sie: anlegen.
    -   nur über das Wiki-Repo, nie über die API;
    -   in ein temporäres Verzeichnis außerhalb des Projekts klonen;
    -   Identität des Nutzers für Commits verwenden.

## Inhalt

-   **Stand:** Datum der letzten Planung.

### Je Zwischenziel

-   **Ziel:** prüfbares Ergebnis in einem Satz, kein Thema (z. B. „Ein neues Image erreicht den Server ohne Handgriff" statt „Updates").
    -   ein Ziel je Planungs-Paket; über das Ziel hinaus nicht planen;
    -   erreicht, wenn keine Zeile mit Bezug zum Ziel mehr offen ist; Zeilen `neu` zählen als offen.
-   **Als Nächstes:** Tabelle `| # | Issue | Heute | Danach | Warum hier |`; `#` = laufende Nummer der Zeile. Von oben nach unten:
    1.  Bugs mit Schwere hoch (Zeile „Schwere" im Issue; fehlt sie, fragt der Agent in Schritt 3), auch ohne Bezug zum Ziel; davor, was sie voraussetzen;
    2.  was das Ziel braucht;
    3.  Trennzeile („nützlich für das Ziel" in Spalte Issue); darunter, was dem Ziel hilft, ohne nötig zu sein.

    Spalten, je ein Satz, verständlich ohne das Issue:
    -   *Heute:* wie es jetzt ist, laut Issue;
    -   *Danach:* was nach dem Issue anders ist;
    -   *Warum hier:* Bezug zum Ziel oder zur späteren Zeile, die es braucht; Bugs ohne Bezug zum Ziel: „Bug, Schwere hoch".

    Regeln:
    -   Zeile hängt nur von früheren Zeilen ab. Hängt sie von einer späteren ab oder zwei voneinander: Neuschnitt unter „Verbindungen".
    -   Zeile kann Zusammengehöriges oder einen Teil nennen (`#13 (…) mit #6 (…)`, `#27 (…) Teil a`).
    -   *Zeilen `neu`:* Braucht das Ziel oder eine Zeile über der Trennzeile etwas ohne offenes Issue (auch wenn es unter `_requirements/deferred/` steht): Zeile `neu: <Kurztitel>`. *Heute* laut `_context/` oder mit „(Annahme)"; *Warum hier* nennt, welche Zeile oder ob das Ziel selbst es braucht; Vermutetes endet mit „(Annahme)". Für Nützliches und „Übrige" keine Zeilen `neu`.
-   **Verbindungen:** welche Issues zusammenhängen oder neu geschnitten werden sollen, je ein Satz.
-   **Übrige:** offene Issues ohne Bezug zum Ziel, außer Bugs mit Schwere hoch; ohne Reihenfolge.

Form und Grenzen:

-   Issues als `#<Nummer> (<Kurztitel>)`.
-   Nicht auf die Seite: Status der Anforderung, offene Fragen zur Umsetzung (gehören in die Klärung des Issues), wie der Nutzer dem Weg folgt.
-   Sicherheitsthemen nur abstrakt (`_agent-process/AGENTS.md`, „Grundsätze", „Dokumente und Issues").

## Ablauf

1.  **Lesen:**
    1.  die Seite (Wiki: vorher klonen wie unter „Wo die Seite liegt");
    2.  alle offenen Issues mit Nummer, Titel, Label, Text (`gh issue list --state open --limit 200 --json number,title,labels,body` bzw. `glab issue list`, alle Seiten, als JSON).
2.  **Vorschlag einholen:** Rolle Planung (`_agent-process/anweisungen/rollen/planung.md`); übergeben: Seite, Liste der offenen Issues, Ziel des Nutzers beim Anstoß (sonst „kein Ziel genannt").
3.  **Durchgehen:**
    1.  Vorschlag vorlegen: Ziel und Tabelle wie auf der Seite, dann Verbindungen und Änderungen gegenüber der Seite;
    2.  verständlich, je Issue mit Nummer und Inhalt;
    3.  Nutzer entscheidet je Punkt;
    4.  ändert er das Ziel: mit neuem Ziel neuen Vorschlag einholen (Schritt 2).
4.  **Anpassen:**
    1.  Zeilen `neu`, die der Nutzer als Issue will: anlegen (`ap-requirement-capture`), Nummer eintragen;
    2.  Seite nach den Entscheidungen neu schreiben (bzw. Text zum Einfügen ausgeben). Wiki: committen und pushen; scheitert der Push: anhalten, Nutzer fragen.
5.  **Folgen, nur nach Ja des Nutzers:**
    1.  Verbindungen und Schnitte als Kommentar in die betroffenen Issues;
    2.  Issues zusammenlegen heißt eines schließen → übernimmt der Nutzer beim Hoster;
    3.  was dauerhaft in `_context/` gehört: als Issue (`ap-requirement-capture`); `_context/` ändert erst dessen Anforderung.

Kein Branch, kein Commit im Projekt-Repo; im Wiki-Repo nur Commit und Push aus Schritt 4.
