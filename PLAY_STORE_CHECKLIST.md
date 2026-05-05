# EChB Leipzig – Google Play Submission Checklist

## ✅ DONE — Already in the code

| # | Item | Status |
|---|------|--------|
| 1 | Target SDK 34 | ✅ Done |
| 2 | Min SDK 21 | ✅ Done |
| 3 | NDK 27.0.12077973 pinned | ✅ Done |
| 4 | Network Security Config | ✅ Done |
| 5 | ProGuard rules (WebView + Riverpod) | ✅ Done |
| 6 | isMinifyEnabled + isShrinkResources | ✅ Done |
| 7 | Native Share button | ✅ Done |
| 8 | Privacy Policy screen (German) | ✅ Done |
| 9 | Splash screen (flutter_native_splash) | ✅ Done |
| 10 | Custom User-Agent (Chrome Mobile) | ✅ Done |
| 11 | Deep link intent filter | ✅ Done |
| 12 | onWebResourceError — main frame only | ✅ Done |
| 13 | App icon — all Android mipmap sizes | ✅ Done |
| 14 | App icon — adaptive icon (Android 8+) | ✅ Done |
| 15 | App icon — iOS all sizes | ✅ Done |
| 16 | App icon — 512x512 for Play Console | ✅ Done (assets/ic_launcher_512.png) |
| 17 | Portrait orientation locked | ✅ Done |
| 18 | flutter_launcher_icons configured | ✅ Done |

---

## 🔴 YOU MUST DO — Before submitting

### Step 1 — Install dependencies & generate icons + splash
```bash
flutter pub get
dart run flutter_launcher_icons
dart run flutter_native_splash:create
```

### Step 2 — Generate a Release Keystore (run once, keep forever)
```bash
# Run generate_keystore.bat  (Windows)
# OR run this in terminal:
keytool -genkey -v -keystore android/app/release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias echb-leipzig
```
Then update `android/app/build.gradle.kts`:
```kotlin
storeFile = file("release-key.jks")
storePassword = "YOUR_PASSWORD"
keyAlias = "echb-leipzig"
keyPassword = "YOUR_PASSWORD"
```
⚠️ NEVER lose `release-key.jks` — you need it for every future update!

### Step 3 — Build App Bundle
```bash
flutter build appbundle --release
```
Upload `build/app/outputs/bundle/release/app-release.aab` to Play Console.

### Step 4 — Play Console Store Listing

**App name:**
```
EChB Leipzig – Gemeinde App
```

**Short description:**
```
Offizielle App der Evangelisch-Christlichen Baptistengemeinde Leipzig
```

**Full description:**
```
Willkommen bei der offiziellen App der EChB Gemeinde Leipzig!

Diese App bietet Ihnen direkten Zugang zu allen Inhalten unserer Gemeinde:

🏠 GEMEINDE
Erfahren Sie mehr über unsere Gemeinschaft und unsere Werte als evangelisch-christliche Baptistengemeinde.

⛪ GOTTESDIENSTE
Alle Informationen zu unseren Gottesdiensten – Zeiten, Orte und besondere Veranstaltungen immer griffbereit.

📖 GLAUBENSBEKENNTNIS
Lernen Sie unseren Glauben und unsere Überzeugungen kennen.

📚 BIBEL ZU VERSCHENKEN
Wir schenken Bibeln! Erfahren Sie, wie Sie kostenlos eine Bibel erhalten können.

✉️ KONTAKT
Nehmen Sie direkt Kontakt mit uns auf.

FUNKTIONEN DER APP:
• Teilen Sie Inhalte ganz einfach mit Freunden und Familie
• Schnelle Navigation zwischen allen Gemeindebereichen
• Datenschutzfreundlich – die App erhebt keine persönlichen Daten
• Offline-Fehlermeldung mit automatischer Wiederverbindung
• Optimiert für Android

Die EChB Leipzig ist eine evangelisch-christliche Baptistengemeinde im Herzen von Leipzig. Wir freuen uns auf Ihren Besuch!
```

**Category:** Lifestyle
**Content rating:** Everyone
**Privacy Policy URL:** https://echb-leipzig.de/datenschutz/

### Step 5 — Screenshots (required: minimum 2, recommended 5)
Take screenshots on a real device or emulator showing:
1. Home screen (Gemeinde tab)
2. Gottesdienste page
3. Share dialog open
4. Privacy Policy screen
5. Offline error screen

### Step 6 — Upload assets to Play Console
- Hi-res icon: `assets/ic_launcher_512.png` (512×512)
- Feature graphic: 1024×500px (create in Canva or similar — navy background with logo)

---

## 🟡 Optional Extras (improves ranking & retention)

- [ ] Add Firebase Analytics to track usage
- [ ] Add push notifications via firebase_messaging
- [ ] Request website owner to add `/.well-known/assetlinks.json` for verified deep links
- [ ] Submit to Internal Testing track first, then Production

---

## Full Build Commands

```bash
flutter pub get
dart run flutter_launcher_icons        # generates app icons
dart run flutter_native_splash:create  # generates splash screens
flutter clean
flutter build appbundle --release      # for Play Store (.aab)
flutter build apk --release            # for direct install (.apk)
```
