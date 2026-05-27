import 'package:flutter/material.dart';
import '../../core/constants/app_theme.dart';

abstract class AppDialog {
  /// Show a non-dismissible loading overlay.
  /// Opsional: tampilkan [message] di bawah spinner.
  static void showLoading(BuildContext context, {String? message}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) =>
          PopScope(canPop: false, child: _LoadingDialog(message: message)),
    );
  }

  /// Dismiss the loading overlay shown by [showLoading].
  static void hideLoading(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  /// Show a confirmation dialog. Returns true if user taps confirm.
  /// Opsional: tambah [icon] dan [iconColor] di atas judul.
  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'OK',
    String cancelLabel = 'Cancel',
    IconData? icon,
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: icon != null
            ? Icon(icon, size: 62, color: Theme.of(ctx).colorScheme.primary)
            : null,
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(cancelLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Show a floating snackbar. Pass [isError] true for error styling.
  /// Opsional: tambah [icon] di depan teks.
  static void showSnackbar(
    BuildContext context,
    String message, {
    bool isError = false,
    IconData? icon,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                size: 18,
                color: isError
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
            ],
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: isError
            ? Theme.of(context).colorScheme.error
            : Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        ),
      ),
    );
  }
}

class _LoadingDialog extends StatelessWidget {
  const _LoadingDialog({this.message});
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(message!, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
