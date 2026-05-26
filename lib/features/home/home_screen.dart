import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_strings.dart';
import '../../core/constants/app_theme.dart';
import '../../core/providers/settings_provider.dart';
import '../../core/utils/loading_state.dart';
import '../../shared/utils/app_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ── Demo: LoadingState ────────────────────────────────────────────────────────
  LoadingState _fetchState = LoadingState.idle;

  Future<void> _showConfirmDemo() async {
    final ok = await AppDialog.confirm(
      context,
      title: 'Hapus item?',
      message: 'Tindakan ini tidak dapat dibatalkan.',
      confirmLabel: 'Hapus',
      cancelLabel: 'Batal',
    );
    if (!mounted) return;
    AppDialog.showSnackbar(context, ok ? 'Item dihapus' : 'Dibatalkan', isError: ok);
  }

  Future<void> _showLoadingDemo() async {
    AppDialog.showLoading(context);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    AppDialog.hideLoading(context);
  }

  Future<void> _simulateFetch() async {
    setState(() => _fetchState = LoadingState.loading);
    AppDialog.showLoading(context);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    AppDialog.hideLoading(context);

    // Simulate success/error randomly for demo purposes
    final success = DateTime.now().second.isEven;
    setState(() => _fetchState = success ? LoadingState.success : LoadingState.error);

    AppDialog.showSnackbar(
      context,
      success ? 'Data berhasil dimuat' : 'Gagal memuat data',
      isError: !success,
    );
  }

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
            // ── Hero card: demo LoadingState ──────────────────────────────────
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingLg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _StateIcon(state: _fetchState, theme: theme),
                    const SizedBox(height: AppTheme.spacingMd),
                    Text(s('home_welcome'), style: theme.textTheme.titleLarge),
                    const SizedBox(height: AppTheme.spacingXs),
                    Text(_stateLabel(_fetchState, s), style: theme.textTheme.bodySmall),
                    const SizedBox(height: AppTheme.spacingMd),
                    FilledButton.icon(
                      onPressed: _fetchState.isLoading ? null : _simulateFetch,
                      icon: const Icon(Icons.download_rounded, size: 18),
                      label: const Text('Load Data'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppTheme.spacingMd),

            // ── Demo grid: AppDialog variants ─────────────────────────────────
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: AppTheme.spacingSm,
                mainAxisSpacing: AppTheme.spacingSm,
                children: [
                  // Confirm dialog
                  _DemoCard(
                    icon: Icons.bar_chart_rounded,
                    label: 'Confirm Dialog',
                    onTap: _showConfirmDemo,
                  ),
                  // Success snackbar
                  _DemoCard(
                    icon: Icons.notifications_outlined,
                    label: 'Snackbar OK',
                    onTap: () => AppDialog.showSnackbar(context, 'Disimpan!'),
                  ),
                  // Error snackbar
                  _DemoCard(
                    icon: Icons.task_alt_rounded,
                    label: 'Snackbar Error',
                    onTap: () => AppDialog.showSnackbar(
                      context,
                      'Koneksi gagal',
                      isError: true,
                    ),
                  ),
                  // Loading overlay only (no state tracking)
                  _DemoCard(
                    icon: Icons.calendar_today_outlined,
                    label: 'Loading Overlay',
                    onTap: _showLoadingDemo,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _stateLabel(LoadingState state, String Function(String) s) => switch (state) {
        LoadingState.idle => s('home_subtitle'),
        LoadingState.loading => 'Memuat data…',
        LoadingState.success => 'Data berhasil dimuat.',
        LoadingState.error => 'Gagal memuat data. Coba lagi.',
      };
}

// ── State icon yang berubah sesuai LoadingState ───────────────────────────────
class _StateIcon extends StatelessWidget {
  const _StateIcon({required this.state, required this.theme});
  final LoadingState state;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      LoadingState.idle => Icon(Icons.rocket_launch_rounded, size: 40, color: theme.colorScheme.primary),
      LoadingState.loading => SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(strokeWidth: 3, color: theme.colorScheme.primary),
        ),
      LoadingState.success => Icon(Icons.check_circle_rounded, size: 40, color: theme.colorScheme.primary),
      LoadingState.error => Icon(Icons.error_rounded, size: 40, color: theme.colorScheme.error),
    };
  }
}

// ── Grid card dengan onTap ────────────────────────────────────────────────────
class _DemoCard extends StatelessWidget {
  const _DemoCard({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppTheme.spacingMd),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32, color: theme.colorScheme.primary),
              const SizedBox(height: AppTheme.spacingSm),
              Text(label, style: theme.textTheme.labelLarge, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}
