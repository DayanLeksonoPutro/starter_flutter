import 'package:flutter/material.dart';
import '../../core/constants/app_theme.dart';

abstract class AppDialog {
  /// Show a non-dismissible loading overlay.
  static void showLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const PopScope(
        canPop: false,
        child: _LoadingDialog(),
      ),
    );
  }

  /// Dismiss the loading overlay shown by [showLoading].
  static void hideLoading(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  /// Show a confirmation dialog. Returns true if user taps confirm.
  static Future<bool> confirm(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'OK',
    String cancelLabel = 'Cancel',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
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
  static void showSnackbar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
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
  const _LoadingDialog();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
