import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const String arabicQuranicFont = 'UthmanicHafs';
  static const String arabicUIFont = 'NotoNaskhArabic';
  static const String surahNameFont = 'SurahNameNaskh';

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.blue,
          brightness: Brightness.light,
          primary: AppColors.blue,
          secondary: AppColors.blueMuted,
          surface: AppColors.lightBackground,
          onPrimary: AppColors.darkBackground,
          onSurface: AppColors.lightText,
        ),
        scaffoldBackgroundColor: AppColors.lightBackground,
        fontFamily: arabicUIFont,
        textTheme: _textTheme(Brightness.light),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: AppColors.darkBackground,
          foregroundColor: AppColors.blue,
          titleTextStyle: const TextStyle(
            fontFamily: arabicUIFont,
            color: AppColors.blue,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: const IconThemeData(color: AppColors.blue),
          surfaceTintColor: Colors.transparent,
        ),
        iconTheme: const IconThemeData(color: AppColors.blue),
        dividerColor: AppColors.lightDivider,
        dividerTheme: const DividerThemeData(color: AppColors.lightDivider),
        tabBarTheme: const TabBarThemeData(
          labelColor: AppColors.blue,
          unselectedLabelColor: AppColors.lightSubtext,
          indicatorColor: AppColors.blue,
          dividerColor: Colors.transparent,
        ),
        cardTheme: const CardThemeData(
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.darkBackground,
          contentTextStyle: const TextStyle(
            fontFamily: arabicUIFont,
            color: AppColors.blue,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        dialogTheme: DialogThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          surfaceTintColor: Colors.transparent,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.blue,
            foregroundColor: AppColors.darkBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.blue,
            side: const BorderSide(color: AppColors.blue),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppColors.blue),
        ),
        chipTheme: const ChipThemeData(
          selectedColor: AppColors.blue,
          labelStyle: TextStyle(fontFamily: arabicUIFont),
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.blueLight,
          brightness: Brightness.dark,
          primary: AppColors.blueLight,
          secondary: AppColors.blue,
          surface: AppColors.darkBackground,
          onPrimary: AppColors.darkBackground,
          onSurface: AppColors.darkText,
        ),
        scaffoldBackgroundColor: AppColors.darkBackground,
        fontFamily: arabicUIFont,
        textTheme: _textTheme(Brightness.dark),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: AppColors.darkBackground,
          foregroundColor: AppColors.blueLight,
          titleTextStyle: const TextStyle(
            fontFamily: arabicUIFont,
            color: AppColors.blueLight,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: const IconThemeData(color: AppColors.blueLight),
          surfaceTintColor: Colors.transparent,
        ),
        iconTheme: const IconThemeData(color: AppColors.blueLight),
        dividerColor: AppColors.darkDivider,
        dividerTheme: const DividerThemeData(color: AppColors.darkDivider),
        tabBarTheme: const TabBarThemeData(
          labelColor: AppColors.blueLight,
          unselectedLabelColor: AppColors.darkSubtext,
          indicatorColor: AppColors.blueLight,
          dividerColor: Colors.transparent,
        ),
        cardTheme: const CardThemeData(
          surfaceTintColor: Colors.transparent,
          elevation: 0,
        ),
        snackBarTheme: SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.darkSurface,
          contentTextStyle: const TextStyle(
            fontFamily: arabicUIFont,
            color: AppColors.blueLight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        dialogTheme: DialogThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          surfaceTintColor: Colors.transparent,
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.blueLight,
            foregroundColor: AppColors.darkBackground,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.blueLight,
            side: const BorderSide(color: AppColors.blueLight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: AppColors.blueLight),
        ),
        chipTheme: const ChipThemeData(
          selectedColor: AppColors.blueLight,
          labelStyle: TextStyle(fontFamily: arabicUIFont),
        ),
      );

  static TextTheme _textTheme(Brightness brightness) {
    final textColor = brightness == Brightness.dark
        ? AppColors.darkText
        : AppColors.lightText;
    final accent =
        brightness == Brightness.dark ? AppColors.blueLight : AppColors.blue;
    return TextTheme(
      // ── Quranic display ──────────────────────────────────────────────────────
      displayLarge: TextStyle(
        fontFamily: arabicQuranicFont,
        fontSize: 22,
        fontWeight: FontWeight.w400,
        height: 1.8,
        color: textColor,
      ),
      displayMedium: TextStyle(
        fontFamily: arabicQuranicFont,
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 1.8,
        color: textColor,
      ),
      displaySmall: TextStyle(
        fontFamily: arabicQuranicFont,
        fontSize: 18,
        fontWeight: FontWeight.w400,
        height: 1.8,
        color: textColor,
      ),
      // ── Headlines ────────────────────────────────────────────────────────────
      headlineLarge: TextStyle(
        fontFamily: arabicUIFont,
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: surahNameFont,
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: accent,
      ),
      headlineSmall: TextStyle(
        fontFamily: arabicUIFont,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      // ── Titles ───────────────────────────────────────────────────────────────
      titleLarge: TextStyle(
        fontFamily: arabicUIFont,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
      titleMedium: TextStyle(
        fontFamily: arabicUIFont,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      titleSmall: TextStyle(
        fontFamily: arabicUIFont,
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      // ── Body ─────────────────────────────────────────────────────────────────
      bodyLarge: TextStyle(
        fontFamily: arabicUIFont,
        fontSize: 16,
        height: 1.6,
        color: textColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: arabicUIFont,
        fontSize: 14,
        height: 1.6,
        color: textColor,
      ),
      bodySmall: TextStyle(
        fontFamily: arabicUIFont,
        fontSize: 12,
        height: 1.5,
        color: textColor,
      ),
      // ── Labels ───────────────────────────────────────────────────────────────
      labelLarge: TextStyle(
        fontFamily: arabicUIFont,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelMedium: TextStyle(
        fontFamily: arabicUIFont,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
      labelSmall: TextStyle(
        fontFamily: arabicUIFont,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: textColor,
      ),
    );
  }
}