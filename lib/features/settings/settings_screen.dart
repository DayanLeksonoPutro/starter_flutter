import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/constants/app_config.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_theme.dart';
import '../../core/providers/settings_provider.dart';

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
          _SectionHeader(label: s('about')),
          Text(
            AppConfig.appName,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: AppTheme.spacingXs),
          Text('v${AppConfig.version}'),
          const SizedBox(height: AppTheme.spacingMd),
          Text(s('about_desc')),
          // ── Appearance section ────────────────────────────────────────────
          _SectionHeader(label: s('settings_appearance')),

          SwitchListTile(
            secondary: const Icon(Icons.dark_mode_outlined),
            title: Text(s('settings_dark_mode')),
            value: settings.isDarkMode,
            onChanged: (v) => settings.toggleDarkMode(v),
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
            onTap: () => _showLanguagePicker(context, settings, s),
          ),

          const Divider(),

          // ── About section ─────────────────────────────────────────────────
          _SectionHeader(label: s('settings_about')),

          ListTile(
            leading: const Icon(Icons.share_outlined),
            title: Text(s('settings_share')),
            onTap: () => _shareApp(s),
          ),

          ListTile(
            leading: const Icon(Icons.star_outline_rounded),
            title: Text(s('settings_rate')),
            onTap: () => _openUrl(AppConfig.playStoreUrl),
          ),

          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: Text(s('settings_privacy')),
            trailing: const Icon(Icons.open_in_new, size: 16),
            onTap: () => _openUrl(AppConfig.privacyPolicyUrl),
          ),

          const Divider(),

          // ── Version ───────────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingMd),
            child: Center(
              child: Text(
                '${s('settings_version')} ${AppConfig.version} (${AppConfig.buildNumber})',
                style: theme.textTheme.bodySmall,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLanguagePicker(
    BuildContext context,
    SettingsProvider settings,
    String Function(String) s,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radiusLg),
        ),
      ),
      builder: (_) {
        return SafeArea(
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
                value: 'en',
                selected: settings.locale == 'en',
                onTap: () {
                  settings.setLocale('en');
                  Navigator.pop(context);
                },
              ),
              _LanguageTile(
                label: 'Indonesia',
                value: 'id',
                selected: settings.locale == 'id',
                onTap: () {
                  settings.setLocale('id');
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: AppTheme.spacingMd),
            ],
          ),
        );
      },
    );
  }

  void _showAboutDialog(BuildContext context, String Function(String) s) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(s('about_title')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConfig.appName,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: AppTheme.spacingXs),
            Text('v${AppConfig.version}'),
            const SizedBox(height: AppTheme.spacingMd),
            Text(s('about_desc')),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(s('about_close')),
          ),
        ],
      ),
    );
  }

  Future<void> _shareApp(String Function(String) s) async {
    // share_plus package for real sharing; kept minimal to avoid extra dep
    // Replace with: Share.share(s('share_text'));
    debugPrint('Share: ${s('share_text')}');
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
    required this.value,
    required this.selected,
    required this.onTap,
  });
  final String label;
  final String value;
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
