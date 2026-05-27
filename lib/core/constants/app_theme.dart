import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_transitions.dart';
import 'app_colors.dart';

/// ─── THEME CONFIG ──────────────────────────────────────────────────────────────
/// Central place to tweak shape, typography, spacing, and elevation.
class AppTheme {
  AppTheme._();

  // ── Radius ──────────────────────────────────────────────────────────────────
  static const double radiusXs = 4;
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;
  static const double radiusXl = 24;
  static const double radiusFull = 100;

  static const double buttonRadius = radiusMd;

  // ── Font sizes ───────────────────────────────────────────────────────────────
  static const double fontXs = 11;
  static const double fontSm = 13;
  static const double fontBase = 14;
  static const double fontMd = 16;
  static const double fontLg = 18;
  static const double fontXl = 20;
  static const double font2xl = 24;
  static const double font3xl = 30;

  // ── Spacing ──────────────────────────────────────────────────────────────────
  static const double spacingXs = 4;
  static const double spacingSm = 8;
  static const double spacingMd = 16;
  static const double spacingLg = 24;
  static const double spacingXl = 32;

  // ── Elevation ────────────────────────────────────────────────────────────────
  static const double elevationNone = 0;
  static const double elevationSm = 2;
  static const double elevationMd = 4;
  static const double elevationLg = 8;

  // ── ★ FONT ───────────────────────────────────────────────────────────────────
  // Ganti nama font di kedua baris ini untuk swap typeface seluruh app.
  // Pilihan populer: poppins · inter · nunitoSans · dmSans · outfit · lato
  static TextStyle _f([TextStyle? style]) =>
      GoogleFonts.plusJakartaSans(textStyle: style);
  static TextTheme _applyFont(TextTheme base) =>
      GoogleFonts.plusJakartaSansTextTheme(base);

  // ── Light theme ──────────────────────────────────────────────────────────────
  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        pageTransitionsTheme: AppTransitions.theme,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.background,
        textTheme: _applyFont(_baseTextTheme(
          primary: AppColors.textPrimary,
          secondary: AppColors.textSecondary,
        )),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.textPrimary,
          elevation: elevationNone,
          centerTitle: false,
          titleTextStyle: _f(const TextStyle(
            color: AppColors.textPrimary,
            fontSize: fontLg,
            fontWeight: FontWeight.w600,
          )),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surface,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          type: BottomNavigationBarType.fixed,
          elevation: elevationMd,
        ),
        cardTheme: CardThemeData(
          color: AppColors.surface,
          elevation: elevationSm,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius),
            ),
            textStyle: _f(const TextStyle(
              fontSize: fontBase,
              fontWeight: FontWeight.w600,
            )),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius),
            ),
            textStyle: _f(const TextStyle(
              fontSize: fontBase,
              fontWeight: FontWeight.w600,
            )),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius),
            ),
            textStyle: _f(const TextStyle(
              fontSize: fontBase,
              fontWeight: FontWeight.w600,
            )),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusSm),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusSm),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusSm),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: spacingMd,
            vertical: spacingSm + spacingXs,
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.border,
          thickness: 1,
          space: 1,
        ),
      );

  // ── Dark theme ───────────────────────────────────────────────────────────────
  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        pageTransitionsTheme: AppTransitions.theme,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
          primary: AppColors.primaryLight,
          secondary: AppColors.secondaryLight,
          surface: AppColors.surfaceDark,
          error: AppColors.error,
        ),
        scaffoldBackgroundColor: AppColors.backgroundDark,
        textTheme: _applyFont(_baseTextTheme(
          primary: AppColors.textPrimaryDark,
          secondary: AppColors.textSecondaryDark,
        )),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.surfaceDark,
          foregroundColor: AppColors.textPrimaryDark,
          elevation: elevationNone,
          centerTitle: false,
          titleTextStyle: _f(const TextStyle(
            color: AppColors.textPrimaryDark,
            fontSize: fontLg,
            fontWeight: FontWeight.w600,
          )),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.surfaceDark,
          selectedItemColor: AppColors.primaryLight,
          unselectedItemColor: AppColors.textSecondaryDark,
          type: BottomNavigationBarType.fixed,
          elevation: elevationMd,
        ),
        cardTheme: CardThemeData(
          color: AppColors.surfaceDark,
          elevation: elevationNone,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMd),
            side: const BorderSide(color: AppColors.borderDark),
          ),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.primaryLight,
            foregroundColor: AppColors.backgroundDark,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius),
            ),
            textStyle: _f(const TextStyle(
              fontSize: fontBase,
              fontWeight: FontWeight.w600,
            )),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryLight,
            side: const BorderSide(color: AppColors.primaryLight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius),
            ),
            textStyle: _f(const TextStyle(
              fontSize: fontBase,
              fontWeight: FontWeight.w600,
            )),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryLight,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius),
            ),
            textStyle: _f(const TextStyle(
              fontSize: fontBase,
              fontWeight: FontWeight.w600,
            )),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.surfaceDark,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusSm),
            borderSide: const BorderSide(color: AppColors.borderDark),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusSm),
            borderSide: const BorderSide(color: AppColors.borderDark),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radiusSm),
            borderSide: const BorderSide(color: AppColors.primaryLight, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: spacingMd,
            vertical: spacingSm + spacingXs,
          ),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.borderDark,
          thickness: 1,
          space: 1,
        ),
      );

  // ── Base text theme (size + weight + color, font applied on top) ─────────────
  static TextTheme _baseTextTheme({
    required Color primary,
    required Color secondary,
  }) =>
      TextTheme(
        displayLarge: TextStyle(fontSize: font3xl, fontWeight: FontWeight.w700, color: primary),
        displayMedium: TextStyle(fontSize: font2xl, fontWeight: FontWeight.w700, color: primary),
        titleLarge: TextStyle(fontSize: fontXl, fontWeight: FontWeight.w600, color: primary),
        titleMedium: TextStyle(fontSize: fontLg, fontWeight: FontWeight.w600, color: primary),
        titleSmall: TextStyle(fontSize: fontMd, fontWeight: FontWeight.w500, color: primary),
        bodyLarge: TextStyle(fontSize: fontMd, fontWeight: FontWeight.w400, color: primary),
        bodyMedium: TextStyle(fontSize: fontBase, fontWeight: FontWeight.w400, color: primary),
        bodySmall: TextStyle(fontSize: fontSm, fontWeight: FontWeight.w400, color: secondary),
        labelLarge: TextStyle(fontSize: fontBase, fontWeight: FontWeight.w600, color: primary),
        labelMedium: TextStyle(fontSize: fontSm, fontWeight: FontWeight.w500, color: primary),
        labelSmall: TextStyle(fontSize: fontXs, fontWeight: FontWeight.w500, color: secondary),
      );
}
