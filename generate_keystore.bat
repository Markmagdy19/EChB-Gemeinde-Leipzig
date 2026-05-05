@echo off
echo ============================================
echo  EChB Leipzig - Generate Release Keystore
echo ============================================
echo.
echo This will create release-key.jks in the android/app folder.
echo KEEP THIS FILE SAFE - you need it for every future update!
echo.

keytool -genkey -v ^
  -keystore android\app\release-key.jks ^
  -keyalg RSA ^
  -keysize 2048 ^
  -validity 10000 ^
  -alias echb-leipzig

echo.
echo ✓ Keystore created at android\app\release-key.jks
echo.
echo Now update android\app\build.gradle.kts:
echo   storeFile = file("release-key.jks")
echo   storePassword = "YOUR_PASSWORD"
echo   keyAlias = "echb-leipzig"
echo   keyPassword = "YOUR_PASSWORD"
echo.
pause
