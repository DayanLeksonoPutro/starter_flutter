import 'package:flutter/material.dart';

/// Jenis transisi halaman yang tersedia.
enum AppTransitionType {
  fadeScale,  // Fade + scale dari 0.94 → 1.0  (default — Google Photos feel)
  slideUp,    // Slide dari bawah + fade        (modal feel)
  slideRight, // Slide horizontal kanan          (iOS feel)
  fade,       // Fade saja                       (minimal, elegant)
}

/// ─── TRANSITION CONFIG ────────────────────────────────────────────────────────
/// Semua konfigurasi transisi ada di satu tempat.
/// Berlaku otomatis untuk Navigator.push — tidak perlu ubah per-halaman.
class AppTransitions {
  AppTransitions._();

  // ★ GANTI DI SINI — satu baris untuk swap transisi seluruh app
  static const AppTransitionType defaultType = AppTransitionType.fadeScale;

  // ★ DURASI — 200 (snappy) · 280 (balanced) · 400 (cinematic)
  static const Duration duration = Duration(milliseconds: 280);

  /// Tambahkan ke ThemeData: `pageTransitionsTheme: AppTransitions.theme`
  static PageTransitionsTheme get theme => const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: _TransitionBuilder(defaultType),
          TargetPlatform.iOS: _TransitionBuilder(defaultType),
          TargetPlatform.macOS: _TransitionBuilder(defaultType),
        },
      );

  /// Gunakan ini sebagai pengganti [Navigator.push] untuk halaman detail.
  /// Bisa override tipe transisi per-halaman via parameter [type].
  ///
  /// ```dart
  /// AppTransitions.push(context, const DetailScreen());
  /// AppTransitions.push(context, const ModalSheet(), type: AppTransitionType.slideUp);
  /// ```
  static Future<T?> push<T>(
    BuildContext context,
    Widget page, {
    AppTransitionType? type,
  }) =>
      Navigator.push<T>(
        context,
        PageRouteBuilder<T>(
          transitionDuration: duration,
          reverseTransitionDuration: duration,
          pageBuilder: (_, _, _) => page,
          transitionsBuilder: (_, anim, sec, child) =>
              _build(type ?? defaultType, anim, child),
        ),
      );

  static Widget _build(
    AppTransitionType type,
    Animation<double> anim,
    Widget child,
  ) {
    switch (type) {
      case AppTransitionType.fadeScale:
        return FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeOut),
          child: ScaleTransition(
            scale: Tween(begin: 0.94, end: 1.0).animate(
              CurvedAnimation(parent: anim, curve: Curves.easeOutCubic),
            ),
            child: child,
          ),
        );

      case AppTransitionType.slideUp:
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: anim,
            curve: const Interval(0, 0.6, curve: Curves.easeOut),
          ),
          child: SlideTransition(
            position: Tween(
              begin: const Offset(0, 0.06),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
            child: child,
          ),
        );

      case AppTransitionType.slideRight:
        return SlideTransition(
          position: Tween(
            begin: const Offset(1.0, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
          child: child,
        );

      case AppTransitionType.fade:
        return FadeTransition(
          opacity: CurvedAnimation(parent: anim, curve: Curves.easeInOut),
          child: child,
        );
    }
  }
}

class _TransitionBuilder extends PageTransitionsBuilder {
  const _TransitionBuilder(this.type);
  final AppTransitionType type;

  @override
  Widget buildTransitions<T>(route, context, animation, secondaryAnimation, child) =>
      AppTransitions._build(type, animation, child);
}
