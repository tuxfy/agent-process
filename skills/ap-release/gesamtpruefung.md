# Stufe 8b: Gesamtprüfung

Anforderungen sind einzeln geprüft; hier: funktionieren sie **zusammen**?

1.  **Prüfungen:** alle Tests, Prüflauf, automatische Prüfungen aus Stufe 6, sauberer Lauf auf `release-candidate`.
2.  **Zurückgestelltes aufräumen** (`_requirements/deferred/`, Regeln in der `README.md` dort; bei der Abkürzung gilt deren Abschnitt dazu):
    -   Übernommenes oder Erledigtes löschen;
    -   was jetzt jemand will: als Issue festhalten, erst danach löschen (Einzelheiten in der `README.md` dort);
    -   dem Nutzer kurz nennen, was bleibt;
    -   Änderungen gehen mit dem Commit des Release-Dokuments.
3.  **Anspruch nachfragen:** stimmt der Anspruch in `_context/projekt.md` noch (Nutzerkreis, Daten, Folgen eines Ausfalls)?
    -   einmal je Release fragen; Antwort unter `# Gesamtprüfung`;
    -   steigt er: Befunde dieser Gesamtprüfung damit neu einordnen, vor dem Release-Pull-Request; sinkt er: nichts neu einordnen;
    -   neuen Wert in `_context/projekt.md` bringt Stufe 0 für diesen Teil (eigene Anforderung);
    -   bei der Abkürzung entfällt die Nachfrage; dort prüft nur die Klärung den Anspruch.
4.  **Klicktest** über alle enthaltenen Anforderungen (Rolle Klicktester, nur Hauptwege); dem Klicktester Version und Liste der Anforderungen nennen. Befunde einstufen (`_agent-process/anweisungen/einstufung.md`).
5.  **Ergebnis** unter `# Gesamtprüfung` ins Release-Dokument; damit **fertig**: committen, pushen.
    -   Läuft 8b nach Befunden erneut: Abschnitt ersetzen (Zuordnungen `<datei>` → `#<Nummer>` aus früheren Läufen übernehmen).
    -   Eingefroren ist das Release-Dokument erst ab dem Zusammenführen nach `main`.
    -   Ergebnis der CI steht im Pull Request, nicht im Dokument.
6.  **Pull Request von `release-candidate` nach `main`:**
    -   Titel z. B. `chore(release): v<version>`;
    -   Beschreibung: `Closes #<Nummer>` für jedes Dokument, das seit dem letzten Tag nach `_requirements/done/` kam: `git diff --name-only --no-renames --diff-filter=A <letzter Tag>..HEAD -- _requirements/done/` (letzter Tag: `git describe --tags --abbrev=0`), ohne Tag alle; Nummer aus Zeile `Issue`, fehlt sie: weglassen; so ist auch ein Fix aus 8b dabei;
    -   beim erneuten 8b gibt es ihn schon: Beschreibung ergänzen;
    -   CI läuft dort. **Ohne grüne CI kein Zusammenführen und kein Tag.**
    -   Dem Nutzer sagen: Pull Request `#<Nummer>`, CI grün, bereit zum Zusammenführen.

## Befunde

-   **Blockierend** → betroffene Anforderung über einen Fix-Branch korrigieren (abgezweigt vom aktuellen `release-candidate`, Pull Request dorthin):
    1.  zuerst als Issue festhalten (Stufe 1);
    2.  Klärung wie in Stufe 2 (`_agent-process/skills/ap-requirement-refine/klaeren.md`, „Beginn" mit den Punkten darunter); abgenommenes Dokument bleibt eingefroren;
    3.  dem Nutzer sagen: Pull Request `#<Nummer>` vorerst nicht zusammenführen;
    4.  danach 8b erneut, vorher `release-candidate` auf aktuellen Stand bringen.
-   **Nicht blockierend** gilt in 8b als „zurückstellen": Eintrag `release-<version>-<n>.md` in `_requirements/deferred/` (vor dem Commit des Release-Dokuments), Issue (Stufe 1) oder mit Grund verwerfen.
    -   Schwere hoch: beim Nutzer einzeln nachfragen, vor dem Commit des Release-Dokuments; bis zur Antwort kein Release-Pull-Request.
    -   Will er es umgesetzt haben: wie blockierend (Fix-Branch). Sonst geht das Release weiter.
