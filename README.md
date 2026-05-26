# Flutter Starter App

Template Flutter untuk Android dengan arsitektur siap pakai. Clone, ubah config, langsung develop — tanpa menyentuh struktur.

---

## Tech Stack

| Package | Kegunaan |
|---|---|
| `provider` | State management |
| `sqflite` | Database SQLite lokal |
| `shared_preferences` | Simpan setting (tema, bahasa) |
| `url_launcher` | Buka URL eksternal |
| `google_fonts` | Custom font |
| `package_info_plus` | Info versi & build number |

---

## Fitur Bawaan

- Dark mode & light mode
- Bilingual: English / Indonesia
- 3-tab bottom navigation
- Onboarding 3 slide (cupertino_icons, skip, persisted)
- Settings screen (share, rate, privacy policy, about)
- SQLite wrapper siap pakai
- `LoadingState` enum (idle / loading / success / error)
- `AppDialog` helper — loading overlay, confirm dialog, snackbar satu baris
- Tema terpusat (warna, spacing, radius)

---

## Struktur Direktori

```
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   │   ├── app_config.dart        # Nama app, URL store, versi
│   │   ├── app_colors.dart        # Palette warna
│   │   ├── app_theme.dart         # Spacing, radius, font
│   │   └── app_strings.dart       # Teks EN / ID
│   ├── database/
│   │   └── database_helper.dart   # Singleton SQLite
│   ├── providers/
│   │   └── settings_provider.dart # ThemeMode + locale + onboardingDone
│   └── utils/
│       └── loading_state.dart     # Enum idle/loading/success/error
├── features/
│   ├── home/
│   ├── list/
│   ├── onboarding/                # 3-slide onboarding + skip
│   └── settings/
└── shared/
    ├── utils/
    │   └── app_dialog.dart        # Loading overlay, confirm, snackbar
    └── widgets/
        └── bottom_nav.dart
```

---

## Mulai Project Baru

1. **Clone repo ini**

2. **Edit `lib/core/constants/app_config.dart`**
   ```dart
   static const String appName          = 'Nama App';
   static const String version          = '1.0.0';
   static const String playStoreUrl     = 'https://play.google.com/store/...';
   static const String privacyPolicyUrl = 'https://domain.com/privacy';
   ```

3. **Ganti warna brand** di `lib/core/constants/app_colors.dart`

4. **Ganti `applicationId`** di `android/app/build.gradle.kts` dan `android:label` di `AndroidManifest.xml`

5. **Ganti ikon launcher** di `android/app/src/main/res/mipmap-*/`

---

## Menjalankan & Build

```bash
# Install dependencies
flutter pub get

# Jalankan di emulator / device
flutter run

# Build APK release
flutter build apk --release

# Build App Bundle (Play Store)
flutter build appbundle --release
```

---

## Checklist Sebelum Publish

- [ ] `appName`, `playStoreUrl`, `privacyPolicyUrl` di `app_config.dart`
- [ ] `applicationId` di `android/app/build.gradle.kts`
- [ ] `android:label` di `AndroidManifest.xml`
- [ ] Warna brand di `app_colors.dart`
- [ ] Teks EN & ID di `app_strings.dart`
- [ ] Ikon launcher
- [ ] `version` & `buildNumber` di `pubspec.yaml`
- [ ] Signing key di `android/app/build.gradle.kts`
- [ ] Test dark mode, ganti bahasa, buka URL privacy policy
- [ ] Ganti konten onboarding (`_slides` + key di `app_strings.dart`)
