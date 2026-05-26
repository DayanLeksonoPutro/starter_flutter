import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_theme.dart';
import '../../core/providers/settings_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<SettingsProvider>().locale;
    String s(String key) => AppStrings.get(key, locale);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(s('home_title'))),
      body: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingMd),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero card ────────────────────────────────────────────────────
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.rocket_launch_rounded,
                      size: 40,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(height: AppTheme.spacingMd),
                    Text(s('home_welcome'), style: theme.textTheme.titleLarge),
                    const SizedBox(height: AppTheme.spacingXs),
                    Text(s('home_subtitle'), style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppTheme.spacingMd),

            // ── Placeholder grid ─────────────────────────────────────────────
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: AppTheme.spacingSm,
                mainAxisSpacing: AppTheme.spacingSm,
                children: [
                  _PlaceholderCard(icon: Icons.bar_chart_rounded, label: 'Stats'),
                  _PlaceholderCard(icon: Icons.notifications_outlined, label: 'Alerts'),
                  _PlaceholderCard(icon: Icons.task_alt_rounded, label: 'Tasks'),
                  _PlaceholderCard(icon: Icons.calendar_today_outlined, label: 'Schedule'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderCard extends StatelessWidget {
  const _PlaceholderCard({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingMd),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: theme.colorScheme.primary),
              const SizedBox(height: AppTheme.spacingSm),
              Text(label, style: theme.textTheme.labelLarge),
            ],
          ),
        ),
      ),
    );
  }
}
