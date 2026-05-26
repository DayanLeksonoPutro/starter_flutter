import 'package:package_info_plus/package_info_plus.dart';

/// ─── APP CONFIG ────────────────────────────────────────────────────────────────
/// Call [AppConfig.init()] once in main() before runApp.
/// version, buildNumber, packageName, dan playStoreUrl dibaca otomatis dari build.
class AppConfig {
  AppConfig._();

  static const String appName = 'Starter App';

  /// Privacy policy URL — update before releasing
  static const String privacyPolicyUrl =
      'https://yourwebsite.com/privacy-policy';
  static const String websiteUrl = 'https://yourwebsite.com';

  /// Supported locales
  static const List<String> supportedLocales = ['en', 'id'];
  static const String defaultLocale = 'en';

  // ── Runtime info (set by init) ───────────────────────────────────────────────
  static late PackageInfo _info;

  static String get version => _info.version;
  static String get buildNumber => _info.buildNumber;
  static String get packageName => _info.packageName;
  static String get playStoreUrl =>
      'https://play.google.com/store/apps/details?id=${_info.packageName}';

  static Future<void> init() async {
    _info = await PackageInfo.fromPlatform();
  }
}
