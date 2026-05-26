import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// ─── SETTINGS PROVIDER ─────────────────────────────────────────────────────────
/// Persists and exposes: themeMode and locale.
class SettingsProvider extends ChangeNotifier {
  static const _keyTheme = 'theme_mode';
  static const _keyLocale = 'locale';
  static const _keyOnboarding = 'onboarding_done';

  ThemeMode _themeMode = ThemeMode.system;
  String _locale = 'en';
  bool _onboardingDone = false;

  ThemeMode get themeMode => _themeMode;
  String get locale => _locale;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get onboardingDone => _onboardingDone;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final themeName = prefs.getString(_keyTheme) ?? 'system';
    _themeMode = _parseThemeMode(themeName);
    _locale = prefs.getString(_keyLocale) ?? 'en';
    _onboardingDone = prefs.getBool(_keyOnboarding) ?? false;
    notifyListeners();
  }

  Future<void> completeOnboarding() async {
    _onboardingDone = true;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyOnboarding, true);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyTheme, mode.name);
  }

  Future<void> toggleDarkMode(bool isDark) async {
    await setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> setLocale(String locale) async {
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyLocale, locale);
  }

  void toggleLocale() {
    setLocale(_locale == 'en' ? 'id' : 'en');
  }

  ThemeMode _parseThemeMode(String name) {
    return ThemeMode.values.firstWhere(
      (m) => m.name == name,
      orElse: () => ThemeMode.system,
    );
  }
}
