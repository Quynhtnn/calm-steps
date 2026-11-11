# Validation — 11 November 2026

- `flutter pub get --offline`: PASS, resolved dependencies; pubspec.lock included.
- `flutter analyze --no-pub`: PASS, no issues found.
- `flutter test`: PASS — 2 tests: stored account login/favorites/theme after reload; signup validation and Home → Detail → favorite → back.
- Swift `xcrun swiftc -frontend -parse ios/Runner/AppDelegate.swift`: PASS syntax parsing; not an iOS build.
- HTTP API check: the old REST Countries v3 endpoint returned a deprecation response despite HTTP 200. Replaced it with Open-Meteo weather. Actual Open-Meteo request returned JSON containing current temperature, wind, time and timezone.
- Native Android/iOS build, real device UI, OS notification delivery and Figma screenshots: NOT VERIFIED here. No APK/IPA is supplied. Follow README and EVIDENCE_GUIDE on your emulator/device; report an actual delivery only after observing it.

The automated persistence test uses mocked SharedPreferences; the cold-restart screenshot instructions additionally require a real app run. Tests do not prove OS permission behavior or alarm delivery.
