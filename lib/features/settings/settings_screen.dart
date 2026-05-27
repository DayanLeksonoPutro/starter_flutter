import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_config.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_theme.dart';
import '../../core/providers/settings_provider.dart';
import '../../shared/utils/app_actions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();
    final locale = settings.locale;
    String s(String key) => AppStrings.get(key, locale);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(s('settings_title'))),
      body: ListView(
        children: [
          // ── Appearance ────────────────────────────────────────────────────
          _SectionHeader(label: s('settings_appearance')),

          SwitchListTile(
            secondary: const Icon(Icons.dark_mode_outlined),
            title: Text(s('settings_dark_mode')),
            value: settings.isDarkMode,
            onChanged: settings.toggleDarkMode,
          ),

          ListTile(
            leading: const Icon(Icons.language_outlined),
            title: Text(s('settings_language')),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  locale == 'en' ? 'English' : 'Indonesia',
                  style: theme.textTheme.bodySmall,
                ),
                const SizedBox(width: AppTheme.spacingXs),
                const Icon(Icons.chevron_right, size: 20),
              ],
            ),
            onTap: () => _showLanguagePicker(context, settings),
          ),

          const Divider(),

          // ── About ─────────────────────────────────────────────────────────
          _SectionHeader(label: s('settings_about')),

          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingMd,
              vertical: AppTheme.spacingSm,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppConfig.appName, style: theme.textTheme.titleSmall),
                Text(
                  '${s('settings_version')} ${AppConfig.version} (${AppConfig.buildNumber})',
                  style: theme.textTheme.titleSmall,
                ),
                const SizedBox(height: AppTheme.spacingXs),
                Text(s('about_desc'), style: theme.textTheme.bodySmall),

                const SizedBox(height: AppTheme.spacingSm),
              ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: Text(s('settings_share')),
            onTap: () => AppActions.shareApp(locale),
          ),

          ListTile(
            leading: const Icon(Icons.star_outline_rounded),
            title: Text(s('settings_rate')),
            onTap: () => AppActions.rateApp(),
          ),

          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(s('settings_privacy')),
            trailing: const Icon(Icons.open_in_new, size: 16),
            onTap: () => _openUrl(AppConfig.privacyPolicyUrl),
          ),
          ListTile(
            leading: const Icon(Icons.web_outlined),
            title: Text(s('website')),
            trailing: const Icon(Icons.open_in_new, size: 16),
            onTap: () => _openUrl(AppConfig.websiteUrl),
          ),
        ],
      ),
    );
  }

  void _showLanguagePicker(BuildContext context, SettingsProvider settings) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusLg),
        ),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppTheme.spacingSm),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              ),
            ),
            const SizedBox(height: AppTheme.spacingMd),
            _LanguageTile(
              label: 'English',
              selected: settings.locale == 'en',
              onTap: () {
                settings.setLocale('en');
                Navigator.pop(context);
              },
            ),
            _LanguageTile(
              label: 'Indonesia',
              selected: settings.locale == 'id',
              onTap: () {
                settings.setLocale('id');
                Navigator.pop(context);
              },
            ),
            const SizedBox(height: AppTheme.spacingMd),
          ],
        ),
      ),
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTheme.spacingMd,
        AppTheme.spacingMd,
        AppTheme.spacingMd,
        AppTheme.spacingXs,
      ),
      child: Text(
        label.toUpperCase(),
        style: Theme.of(
          context,
        ).textTheme.labelSmall?.copyWith(letterSpacing: 1.2),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: selected
          ? Icon(Icons.check, color: Theme.of(context).colorScheme.primary)
          : null,
      onTap: onTap,
    );
  }
}
