# Google Play Submission Guide
## EChB Leipzig – Gemeinde App
### App ID: `de.echbleipzig.app`

> **Gesamtzeit:** ca. 2–3 Stunden  
> **Schwierigkeitsgrad:** Mittel — dieser Guide führt Sie durch jeden einzelnen Schritt

---

## Übersicht: Ihre Ausgangslage

| Was | Status |
|-----|--------|
| Google Play Developer Account | ✅ Vorhanden |
| Datenschutzerklärung (URL) | ✅ echb-leipzig.de/datenschutz |
| Release Keystore | ❌ Noch nicht erstellt → **Schritt 1** |
| Screenshots | ❌ Noch nicht erstellt → **Schritt 3** |
| App Bundle (.aab) | ❌ Noch nicht gebaut → **Schritt 2** |
| Play Console Eintrag | ❌ Noch nicht erstellt → **Schritt 4** |
| Release-Track | Internal Testing → Production |

---

## SCHRITT 1 — Release Keystore generieren
### ⚠️ Nur einmal! Niemals löschen oder verlieren.

### 1.1 Keystore erstellen

Öffnen Sie die **Eingabeaufforderung** (`cmd`) in Ihrem Projektordner:

```bash
cd C:\Users\wwewq\StudioProjects\webview
```

Führen Sie diesen Befehl aus:

```bash
keytool -genkey -v -keystore android\app\release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias echb-leipzig
```

Beantworten Sie die Fragen so:

```
Enter keystore password:          ← Starkes Passwort wählen (merken!)
Re-enter new password:            ← Gleiches Passwort wiederholen

What is your first and last name?
  [Unknown]: EChB Leipzig

What is the name of your organizational unit?
  [Unknown]: Gemeinde

What is the name of your organization?
  [Unknown]: Evangeliums-Christen-Baptisten Gemeinde Leipzig

What is the name of your City or Locality?
  [Unknown]: Leipzig

What is the name of your State or Province?
  [Unknown]: Sachsen

What is the two-letter country code for this unit?
  [Unknown]: DE

Is CN=EChB Leipzig, ..., C=DE correct?
  [no]: yes

Enter key password for <echb-leipzig>
  (RETURN if same as keystore password): ← Einfach Enter drücken
```

### 1.2 Keystore in build.gradle.kts eintragen

Öffnen Sie `android/app/build.gradle.kts` und ersetzen Sie den `signingConfigs`-Block:

```kotlin
signingConfigs {
    create("release") {
        storeFile = file("release-key.jks")
        storePassword = "IhrPasswortHier"     // ← Ihr Passwort aus Schritt 1.1
        keyAlias = "echb-leipzig"
        keyPassword = "IhrPasswortHier"       // ← Gleiches Passwort
    }
}
```

### 1.3 Keystore sichern

```
❌ Niemals in Git hochladen
✅ Kopie auf USB-Stick oder externem Laufwerk speichern
✅ Passwort separat notieren und sicher aufbewahren
```

Fügen Sie zur `.gitignore` hinzu:
```
android/app/release-key.jks
android/app/*.jks
```

> **Warum ist das so wichtig?** Ohne diesen Keystore können Sie Ihre App **niemals** aktualisieren. Google Play bindet Updates an den originalen Keystore — ein Verlust bedeutet, Sie müssen die App unter neuer ID neu einreichen.

---

## SCHRITT 2 — App Bundle bauen

### 2.1 Icons und Splash Screen generieren (einmalig)

```bash
flutter pub get
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

### 2.2 Projekt bereinigen

```bash
flutter clean
flutter pub get
```

### 2.3 Release App Bundle erstellen

```bash
flutter build appbundle --release
```

✅ Erfolgreich wenn Sie sehen:
```
Built build\app\outputs\bundle\release\app-release.aab
```

Die Datei finden Sie hier:
```
C:\Users\wwewq\StudioProjects\webview\build\app\outputs\bundle\release\app-release.aab
```

> **Warum .aab und nicht .apk?** Google Play verlangt seit August 2021 das App Bundle Format (.aab). Es ist kleiner und wird von Google für jedes Gerät optimiert.

---

## SCHRITT 3 — Screenshots erstellen

Google Play verlangt **mindestens 2 Screenshots** für Smartphones.  
Empfohlen: **4–5 Screenshots**, die die wichtigsten Funktionen zeigen.

### 3.1 Screenshots aufnehmen

Verbinden Sie Ihr Android-Gerät oder starten Sie einen Emulator, dann:

```bash
flutter run --release
```

Navigieren Sie zu diesen Seiten und machen Sie jeweils einen Screenshot:

| # | Seite | Wie navigieren |
|---|-------|---------------|
| 1 | **Startseite** (Gemeinde-Tab) | App öffnen |
| 2 | **Gottesdienste** | Tab "Gottesdienst" tippen |
| 3 | **Kontakt-Seite** | Tab "Kontakt" tippen |
| 4 | **Teilen-Dialog** | Share-Button in der App-Leiste tippen |
| 5 | **Datenschutz-Screen** | "Mehr" → "Datenschutzerklärung" tippen |

### 3.2 Screenshot-Anforderungen

| Anforderung | Wert |
|---|---|
| Mindestanzahl | 2 |
| Format | PNG oder JPEG |
| Mindestgröße | 320px an der kürzesten Seite |
| Maximalgröße | 3840px an der längsten Seite |
| Seitenverhältnis | 16:9 oder 9:16 empfohlen |
| Max. Dateigröße | 8 MB pro Screenshot |

### 3.3 Screenshot auf dem Gerät aufnehmen

- **Android:** Power + Lautstärke runter gleichzeitig drücken
- **Emulator:** Kamera-Symbol in der Emulator-Leiste

Screenshots finden Sie unter:
```
C:\Users\wwewq\Pictures\Screenshots\
```

---

## SCHRITT 4 — Play Console: App anlegen

### 4.1 Play Console öffnen

👉 https://play.google.com/console

Klicken Sie auf **"App erstellen"** (oben rechts).

### 4.2 App-Grunddaten eingeben

| Feld | Wert |
|---|---|
| App-Name | `EChB Leipzig – Gemeinde App` |
| Standardsprache | `Deutsch (Deutschland) – de-DE` |
| App oder Spiel | `App` |
| Kostenlos oder kostenpflichtig | `Kostenlos` |

Bestätigen Sie die Richtlinien und klicken Sie **"App erstellen"**.

---

## SCHRITT 5 — App-Inhalt konfigurieren

Im linken Menü unter **"Richtlinien"** → **"App-Inhalt"**:

### 5.1 Datenschutzerklärung

- Klicken Sie auf **"Datenschutzerklärung"**
- URL eingeben: `https://echb-leipzig.de/datenschutz`
- **Speichern**

### 5.2 Werbung

- **"Enthält diese App Werbung?"** → `Nein`
- **Speichern**

### 5.3 Zielgruppe und Inhalt

- Klicken Sie auf **"Zielgruppe und Inhalt"**
- Zielgruppe: `18 und älter` (oder ab 13 wenn Sie Jugendliche einschließen möchten)
- Richtet sich die App an Kinder? → `Nein`
- **Speichern**

### 5.4 Inhalts-Einstufung (Altersfreigabe)

- Klicken Sie auf **"Inhaltseinstufung"**
- Klicken Sie auf **"Fragebogen starten"**
- Kategorie wählen: **"Alles andere"**
- Fragen beantworten (für eine Kirchen-App alles **Nein**)
- Einstufung berechnen → **"Einstufung übernehmen"**

Ergebnis wird sein: **PEGI 3 / Alle**

### 5.5 Datensicherheit (sehr wichtig!)

Klicken Sie auf **"Datensicherheit"**. Basierend auf Ihrer App:

**Datenerhebung und -weitergabe:**
- Erhebt Ihre App Daten? → `Ja`
- Werden alle erhobenen Daten verschlüsselt übertragen? → `Ja`
- Können Nutzer die Löschung ihrer Daten beantragen? → `Ja`

**Datentypen — wählen Sie Folgendes aus:**

| Kategorie | Datentyp | Erhoben? | Geteilt? | Zweck |
|---|---|---|---|---|
| App-Aktivitäten | Aufgerufene Seiten in der App | Ja | Nein | App-Funktionalität |
| App-Informationen | Absturzprotokolle | Ja | Nein | App-Funktionalität |

> Kontaktdaten (Name, E-Mail etc.) werden von der **Webseite** erhoben, nicht direkt von der App — daher müssen Sie diese hier nicht angeben.

- **Speichern**

---

## SCHRITT 6 — Store-Eintrag ausfüllen

Im linken Menü: **"Store-Präsenz"** → **"Haupt-Store-Eintrag"**

### 6.1 Deutsche Version (Hauptsprache)

**App-Name (max. 30 Zeichen):**
```
EChB Leipzig – Gemeinde App
```

**Kurzbeschreibung (max. 80 Zeichen):**
```
Offizielle App der Baptistengemeinde Leipzig – Gottesdienste & Kontakt
```

**Vollständige Beschreibung (max. 4000 Zeichen):**
```
Willkommen bei der offiziellen App der Evangeliums-Christen-Baptisten Gemeinde Leipzig!

Diese App bietet Ihnen direkten Zugang zu allen Inhalten unserer Gemeinde – schnell, übersichtlich und immer griffbereit.

🏠 GEMEINDE
Erfahren Sie mehr über unsere Gemeinschaft, unsere Geschichte und unsere Werte als evangelisch-christliche Baptistengemeinde im Herzen von Leipzig.

⛪ GOTTESDIENSTE
Alle Informationen zu unseren Gottesdiensten – Zeiten, Orte und besondere Veranstaltungen stets aktuell auf einen Blick.

📖 GLAUBENSBEKENNTNIS
Lernen Sie unseren Glauben und unsere Überzeugungen kennen. Was glauben wir? Worauf gründet sich unser Gemeindeleben?

📚 BIBEL ZU VERSCHENKEN
Wir schenken Bibeln! Erfahren Sie, wie Sie kostenlos eine Bibel für sich oder Ihre Familie erhalten können.

✉️ KONTAKT
Nehmen Sie direkt Kontakt mit uns auf – wir freuen uns auf Ihre Nachricht, Ihr Gebetsanliegen oder Ihren Besuch.

FUNKTIONEN DER APP:
• Schnelle Navigation zwischen allen Gemeindebereichen
• Inhalte ganz einfach mit Freunden und Familie teilen
• Datenschutzfreundlich – keine Weitergabe persönlicher Daten
• Automatische Fehlermeldung bei fehlender Internetverbindung
• Optimiert für alle Android-Geräte

Die EChB Leipzig ist eine lebendige Gemeinde, die seit Jahren Menschen aus Leipzig und Umgebung willkommen heißt. Wir freuen uns auf Sie!

📍 Leipzig, Deutschland
🌐 echb-leipzig.de
📞 0151-56837783
```

### 6.2 Englische Version hinzufügen

Klicken Sie auf **"Übersetzung verwalten"** → **"Sprache hinzufügen"** → **English (United States)**

**App Name:**
```
EChB Leipzig – Church App
```

**Short Description:**
```
Official app of the Baptist Church Leipzig – Services, faith & contact
```

**Full Description:**
```
Welcome to the official app of the Evangeliums-Christen-Baptisten Gemeinde Leipzig (Baptist Church Leipzig)!

This app gives you direct access to all content from our church community – quick, clear, and always at hand.

🏠 COMMUNITY
Learn more about our congregation, our history, and our values as an evangelical Christian Baptist church in the heart of Leipzig, Germany.

⛪ SERVICES
All information about our church services – times, locations, and special events always up to date.

📖 STATEMENT OF FAITH
Get to know our beliefs and convictions. What do we believe? What is the foundation of our church life?

📚 FREE BIBLE
We give away Bibles for free! Find out how you can receive a free Bible for yourself or your family.

✉️ CONTACT
Get in touch with us directly – we welcome your message, prayer request, or visit.

APP FEATURES:
• Quick navigation between all church sections
• Easily share content with friends and family
• Privacy-friendly – no sharing of personal data
• Automatic error message when no internet connection
• Optimized for all Android devices

EChB Leipzig is a vibrant congregation that has been welcoming people from Leipzig and the surrounding area for many years. We look forward to meeting you!

📍 Leipzig, Germany
🌐 echb-leipzig.de
📞 0151-56837783
```

### 6.3 Grafiken hochladen

| Asset | Größe | Pflicht | Quelle |
|---|---|---|---|
| App-Icon | 512 × 512 px PNG | ✅ Ja | `assets/ic_launcher_512.png` |
| Feature-Grafik | 1024 × 500 px | ✅ Ja | Erstellen (siehe unten) |
| Screenshots (Smartphone) | Min. 2 Stück | ✅ Ja | Aus Schritt 3 |

**Feature-Grafik erstellen (1024×500):**
1. Gehen Sie zu https://www.canva.com
2. Wählen Sie "Benutzerdefinierte Größe" → 1024 × 500 px
3. Hintergrundfarbe: `#0F2644` (Navy)
4. Text: `EChB Leipzig` in Gold (`#C8A96E`)
5. Untertitel: `Evangeliums-Christen-Baptisten Gemeinde`
6. Als PNG herunterladen

---

## SCHRITT 7 — App kategorisieren

Im linken Menü: **"Store-Präsenz"** → **"Store-Einstellungen"**

| Feld | Wert |
|---|---|
| App-Kategorie | `Lifestyle` |
| Tags | `Kirche`, `Religion`, `Gemeinde` |
| E-Mail-Adresse | `info@echb-leipzig.de` |
| Webseite | `https://echb-leipzig.de` |
| Telefonnummer | `+4915156837783` |

**Speichern**

---

## SCHRITT 8 — Interne Testversion erstellen

### 8.1 Zur Release-Sektion navigieren

Im linken Menü: **"Testen"** → **"Internes Testen"**

Klicken Sie auf **"Neues Release erstellen"**

### 8.2 App Bundle hochladen

1. Klicken Sie auf **"App-Bundles und APKs hochladen"**
2. Wählen Sie die Datei:
   ```
   build\app\outputs\bundle\release\app-release.aab
   ```
3. Warten Sie bis der Upload abgeschlossen ist
4. Google führt automatisch eine Vorprüfung durch (dauert 1–2 Minuten)

### 8.3 Release-Name und Versionshinweise

**Release-Name:**
```
1.0.0 (Erste Version)
```

**Versionshinweise — Deutsch:**
```
Erste Version der EChB Leipzig Gemeinde-App.

• Direkter Zugang zur Gemeindewebseite
• Navigation: Gemeinde, Gottesdienste, Glaube, Bibel, Kontakt
• Teilen-Funktion für Gemeindeseiten
• Datenschutzerklärung integriert
```

**Versionshinweise — Englisch:**
```
First version of the EChB Leipzig Church App.

• Direct access to the church website
• Navigation: Community, Services, Faith, Bible, Contact
• Share functionality for church pages
• Privacy policy integrated
```

### 8.4 Tester hinzufügen

1. Klicken Sie auf den Tab **"Tester"**
2. Klicken Sie auf **"Testerslist erstellen"** oder **"E-Mail-Adressen hinzufügen"**
3. Fügen Sie Ihre eigene E-Mail-Adresse und die Ihrer Kollegen hinzu
4. Klicken Sie auf **"Einladungslink kopieren"** und senden Sie ihn an die Tester

### 8.5 Release einreichen

Klicken Sie auf **"Release einreichen"** → Bestätigen

> Der interne Test ist **sofort** verfügbar, ohne Google-Überprüfung.

---

## SCHRITT 9 — App testen (Internes Testing)

### 9.1 Als Tester installieren

1. Öffnen Sie den Einladungslink aus Schritt 8.4 auf Ihrem Android-Gerät
2. Klicken Sie auf **"Tester werden"**
3. Klicken Sie auf **"App herunterladen"** → Sie werden zum Play Store weitergeleitet
4. Installieren und testen

### 9.2 Was testen?

```
✅ Öffnet die Startseite (echb-leipzig.de)?
✅ Funktioniert die Navigation (alle 5 Tabs)?
✅ Funktioniert der Zurück-Button?
✅ Funktioniert die Teilen-Funktion?
✅ Erscheint die Fehlermeldung bei deaktiviertem WLAN/Daten?
✅ Funktioniert "Erneut versuchen" nach Verbindungsfehler?
✅ Ist die Datenschutzerklärung über "Mehr" erreichbar?
✅ Sieht das App-Icon korrekt aus?
✅ Wird der Splash Screen beim Start angezeigt?
```

---

## SCHRITT 10 — Produktion einreichen

Sobald alle Tests erfolgreich sind:

### 10.1 Zur Produktionsfreigabe wechseln

Im linken Menü: **"Produktion"** → **"Neues Release erstellen"**

Klicken Sie auf **"Aus internem Test bewerben"** und wählen Sie Ihr getestetes Bundle aus.

### 10.2 Rollout-Prozentsatz

Empfehlung für den ersten Release:
- Beginnen Sie mit **20%** der Nutzer
- Nach 2–3 Tagen ohne Probleme auf 100% erhöhen

### 10.3 Einreichen

Klicken Sie auf **"Release einreichen"**

> Google prüft neue Apps normalerweise innerhalb von **1–3 Tagen**. Bei Kirchenapps ist die Genehmigungsquote sehr hoch.

---

## Was tun, wenn Google die App ablehnt?

| Ablehnungsgrund | Lösung |
|---|---|
| "Thin WebView wrapper" | Sie haben Share-Button + Privacy Policy — das sollte reichen. Falls abgelehnt: Firebase Analytics hinzufügen |
| Fehlende Datenschutzerklärung | URL prüfen: echb-leipzig.de/datenschutz muss erreichbar sein |
| Inhalts-Einstufung unvollständig | Schritt 5.4 wiederholen, alle Fragen sorgfältig beantworten |
| Zielgruppe für Kinder | Sicherstellen dass "Richtet sich an Kinder" = Nein |
| Icon-Probleme | Aus `assets/ic_launcher_512.png` neu hochladen |

---

## Zusammenfassung: Reihenfolge der Schritte

```
Schritt 1 → Keystore generieren + build.gradle.kts aktualisieren
Schritt 2 → flutter clean && flutter build appbundle --release
Schritt 3 → 4–5 Screenshots aufnehmen
Schritt 4 → Play Console: App anlegen
Schritt 5 → App-Inhalt + Datensicherheit ausfüllen
Schritt 6 → Store-Eintrag (DE + EN) + Grafiken hochladen
Schritt 7 → Kategorie + Kontaktdaten eintragen
Schritt 8 → Internes Testing: .aab hochladen + einreichen
Schritt 9 → App auf eigenem Gerät testen
Schritt 10 → Zur Produktion bewerben + einreichen
```

**Geschätzte Gesamtdauer:** 2–3 Stunden

---

## Wichtige Links

| Ressource | URL |
|---|---|
| Google Play Console | https://play.google.com/console |
| Play Console Hilfe | https://support.google.com/googleplay/android-developer |
| App-Inhaltsrichtlinien | https://play.google.com/about/developer-content-policy |
| Datensicherheits-Formular | https://support.google.com/googleplay/android-developer/answer/10787469 |
| Canva (Feature-Grafik) | https://www.canva.com |
| Datenschutzerklärung | https://echb-leipzig.de/datenschutz |

---

*Erstellt für: Evangeliums-Christen-Baptisten Gemeinde Leipzig*  
*App-ID: de.echbleipzig.app*  
*Version: 1.0.0+1*  
*Stand: Mai 2025*
