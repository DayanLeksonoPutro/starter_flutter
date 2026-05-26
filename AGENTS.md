# AGENTS.md — Flutter Starter App

> Panduan ini ditujukan untuk AI agent (Claude, Copilot, dll.) yang bekerja di repo ini.
> Baca seluruh file sebelum mengubah kode apa pun.

---

## 1. Gambaran Proyek

Starter template Flutter untuk target **Android**. Setiap project baru cukup clone repo ini, lalu ganti nilai di file config tanpa menyentuh arsitektur.

**Package inti:**

| Package | Versi | Kegunaan |
|---|---|---|
| `provider` | ^6.1.2 | State management |
| `sqflite` | ^2.4.2 | SQLite lokal |
| `shared_preferences` | ^2.3.5 | Simpan setting (theme, bahasa) |
| `url_launcher` | ^6.3.1 | Buka URL eksternal |

---

## 2. Struktur Direktori

```
lib/
├── main.dart                        # Entry point, inisialisasi provider
├── app.dart                         # MaterialApp, theme, routing root (cek onboarding)
├── core/
│   ├── constants/
│   │   ├── app_colors.dart          # ★ PALETTE — edit warna di sini
│   │   ├── app_theme.dart           # ★ THEME  — radius, font size, spacing
│   │   ├── app_config.dart          # ★ CONFIG — nama app, URL store, versi
│   │   └── app_strings.dart         # Teks dua bahasa (en / id)
│   ├── database/
│   │   └── database_helper.dart     # Singleton SQLite wrapper
│   ├── providers/
│   │   └── settings_provider.dart   # ThemeMode + locale + onboardingDone (persisted)
│   └── utils/
│       └── loading_state.dart       # Enum: idle / loading / success / error
├── features/
│   ├── home/
│   │   └── home_screen.dart         # Layar Beranda (dummy)
│   ├── list/
│   │   └── list_screen.dart         # Layar Daftar (dummy)
│   ├── onboarding/
│   │   └── onboarding_screen.dart   # 3-slide onboarding + skip (cupertino_icons)
│   └── settings/
│       └── settings_screen.dart     # Dark mode, bahasa, about, share, rate, privacy
└── shared/
    ├── utils/
    │   └── app_dialog.dart          # showLoading / hideLoading / confirm / showSnackbar
    └── widgets/
        └── bottom_nav.dart          # BottomNavigationBar 3 tab
```

---

## 3. File yang Wajib Diubah Saat Mulai Project Baru

### `lib/core/constants/app_config.dart`
```dart
static const String appName      = 'Nama Aplikasi Baru';
static const String version      = '1.0.0';
static const String playStoreUrl = 'https://play.google.com/store/...';
static const String privacyPolicyUrl = 'https://domain.com/privacy';
```

### `lib/core/constants/app_colors.dart`
Ganti nilai `primary`, `secondary`, `background`, `surface`, dan pasangan dark-nya. Seluruh theme mengambil warna dari sini — tidak ada hardcode warna di tempat lain.

### `lib/core/constants/app_strings.dart`
Tambah atau ganti key teks untuk bahasa `en` dan `id`. Pola penggunaan:
```dart
final s = (String key) => AppStrings.get(key, locale);
Text(s('key_name'))
```

### `pubspec.yaml`
- `name`: nama package (lowercase, underscore)
- `description`: deskripsi singkat

### `android/app/build.gradle` / `AndroidManifest.xml`
- `applicationId`: ganti `com.appnovasi.starter` → ID package baru
- `android:label`: nama app yang muncul di launcher

---

## 4. Utility Siap Pakai

### `LoadingState` — `lib/core/utils/loading_state.dart`
Gunakan di setiap provider yang punya operasi async:
```dart
LoadingState _state = LoadingState.idle;
LoadingState get state => _state;

Future<void> fetchData() async {
  _state = LoadingState.loading; notifyListeners();
  try {
    // ...
    _state = LoadingState.success;
  } catch (_) {
    _state = LoadingState.error;
  }
  notifyListeners();
}
```
Di widget: `if (provider.state.isLoading) CircularProgressIndicator()`

### `AppDialog` — `lib/shared/utils/app_dialog.dart`
```dart
// Loading overlay
AppDialog.showLoading(context);
await doSomething();
AppDialog.hideLoading(context);

// Konfirmasi
final ok = await AppDialog.confirm(context, title: 'Hapus?', message: 'Data akan dihapus.');
if (ok) { /* lanjut */ }

// Snackbar
AppDialog.showSnackbar(context, 'Berhasil disimpan');
AppDialog.showSnackbar(context, 'Gagal', isError: true);
```

### Onboarding — `lib/features/onboarding/onboarding_screen.dart`
- 3 slide dengan icon `CupertinoIcons`, title, subtitle
- Tombol Skip + dots indicator + Next / Get Started
- Status disimpan via `SettingsProvider.completeOnboarding()` → SharedPreferences
- `app.dart` otomatis route ke `MainNavigation` jika onboarding sudah selesai
- **Ganti konten:** edit konstanta `_slides` di `_OnboardingScreenState` dan key string di `app_strings.dart`

---

## 6. Panduan Menambah Fitur

### Menambah screen baru
1. Buat file di `lib/features/<nama_fitur>/<nama>_screen.dart`
2. Gunakan `Scaffold` + `AppBar` standar
3. Ambil `locale` via `context.watch<SettingsProvider>().locale` untuk teks

### Menambah tabel database
1. Buka `lib/core/database/database_helper.dart`
2. Tambah `CREATE TABLE` di `_onCreate`
3. Naikkan konstanta `_version` dan tangani migrasi di `_onUpgrade`
4. Buat repository class di `lib/features/<fitur>/` yang mengakses `DatabaseHelper.instance`

### Menambah item Setting
Tambahkan `ListTile` baru di `lib/features/settings/settings_screen.dart` di dalam `ListView`. Kelompokkan dalam section yang sesuai (`_SectionHeader`).

### Menambah bahasa ketiga
1. Tambah entri map di `app_strings.dart`: `'ms': { ... }`
2. Tambah ke `AppConfig.supportedLocales`
3. Tambah tile di `_showLanguagePicker` di `settings_screen.dart`

---

## 7. Aturan Kode

- **State management**: Provider only. Jangan tambah Bloc/Riverpod/GetX kecuali diminta eksplisit.
- **Warna**: Selalu ambil dari `AppColors` atau `Theme.of(context).colorScheme`. Jangan hardcode `Color(0xFF...)` di widget.
- **Spacing / radius**: Gunakan konstanta `AppTheme.spacing*` dan `AppTheme.radius*`.
- **Teks**: Selalu melalui `AppStrings.get(key, locale)`. Jangan hardcode string UI.
- **SQLite**: Akses hanya melalui `DatabaseHelper.instance`. Jangan buka database langsung.
- **Navigasi**: Gunakan `IndexedStack` di `MainNavigation` (sudah ada). Untuk halaman detail gunakan `Navigator.push`.

---

## 8. Menjalankan & Build

```bash
# Install dependencies
flutter pub get

# Jalankan di emulator/device
flutter run

# Build APK release
flutter build apk --release

# Build App Bundle (Play Store)
flutter build appbundle --release
```

---

## 9. Checklist Sebelum Publish

- [ ] Ganti `appName`, `playStoreUrl`, `privacyPolicyUrl` di `app_config.dart`
- [ ] Ganti `applicationId` di `android/app/build.gradle`
- [ ] Ganti `android:label` di `AndroidManifest.xml`
- [ ] Ganti warna brand di `app_colors.dart`
- [ ] Lengkapi teks `en` & `id` di `app_strings.dart`
- [ ] Ganti ikon launcher (`android/app/src/main/res/mipmap-*/`)
- [ ] Set `version` dan `buildNumber` di `pubspec.yaml`
- [ ] Aktifkan signing di `android/app/build.gradle`
- [ ] Test dark mode, ganti bahasa, dan buka URL privacy policy
- [ ] Ganti konten onboarding (`_slides` + key di `app_strings.dart`)
- [ ] Pastikan onboarding hanya muncul sekali (test uninstall/reinstall)
