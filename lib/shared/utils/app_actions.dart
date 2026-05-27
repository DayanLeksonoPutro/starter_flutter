import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_config.dart';
import '../../core/constants/app_strings.dart';

class AppActions {
  AppActions._();

  static Future<void> shareApp(String locale) async {
    final text = AppStrings.get('share_text', locale);
    await Share.share('$text\n${AppConfig.playStoreUrl}');
  }

  static Future<void> rateApp() async {
    final uri = Uri.parse(AppConfig.playStoreUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
