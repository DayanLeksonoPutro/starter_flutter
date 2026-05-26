/// ─── STRINGS / LOCALIZATION ────────────────────────────────────────────────────
/// Simple two-language map. Replace with flutter_localizations for full i18n.
class AppStrings {
  AppStrings._();

  static const Map<String, Map<String, String>> _strings = {
    'en': {
      // Nav
      'nav_home': 'Home',
      'nav_list': 'List',
      'nav_settings': 'Settings',

      // Home
      'home_title': 'Home',
      'home_welcome': 'Welcome to Starter App',
      'home_subtitle': 'Your new project starts here.',

      // List
      'list_title': 'List',
      'list_empty': 'No items yet.',
      'list_item_prefix': 'Item',

      // Settings
      'settings_title': 'Settings',
      'settings_appearance': 'Appearance',
      'settings_dark_mode': 'Dark Mode',
      'settings_language': 'Language',
      'settings_language_value': 'English',
      'settings_about': 'About',
      'settings_about_app': 'About App',
      'settings_share': 'Share App',
      'settings_rate': 'Rate App',
      'settings_privacy': 'Privacy Policy',
      'settings_version': 'Version',

      // About dialog
      'about_title': 'About App',
      'about_desc': 'This is a Flutter starter template. Replace this description with your app info.',
      'about_close': 'Close',

      // Share
      'share_text': 'Check out this app! Download it now.',
    },
    'id': {
      // Nav
      'nav_home': 'Beranda',
      'nav_list': 'Daftar',
      'nav_settings': 'Pengaturan',

      // Home
      'home_title': 'Beranda',
      'home_welcome': 'Selamat Datang di Starter App',
      'home_subtitle': 'Proyek baru Anda dimulai di sini.',

      // List
      'list_title': 'Daftar',
      'list_empty': 'Belum ada item.',
      'list_item_prefix': 'Item',

      // Settings
      'settings_title': 'Pengaturan',
      'settings_appearance': 'Tampilan',
      'settings_dark_mode': 'Mode Gelap',
      'settings_language': 'Bahasa',
      'settings_language_value': 'Indonesia',
      'settings_about': 'Tentang',
      'settings_about_app': 'Tentang Aplikasi',
      'settings_share': 'Bagikan Aplikasi',
      'settings_rate': 'Beri Nilai Aplikasi',
      'settings_privacy': 'Kebijakan Privasi',
      'settings_version': 'Versi',

      // About dialog
      'about_title': 'Tentang Aplikasi',
      'about_desc': 'Ini adalah template starter Flutter. Ganti deskripsi ini dengan info aplikasi Anda.',
      'about_close': 'Tutup',

      // Share
      'share_text': 'Coba aplikasi ini! Unduh sekarang.',
    },
  };

  static String get(String key, String locale) {
    return _strings[locale]?[key] ?? _strings['en']?[key] ?? key;
  }
}
