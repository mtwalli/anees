import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const String arabicQuranicFont = 'UthmanicHafs';
  static const String arabicUIFont = 'NotoNaskhArabic';
  static const String surahNameFont = 'SurahNameNaskh';

  static ThemeData get light => ThemeData(
        useMaterial3: false,
        brightness: Brightness.light,
        primaryColor: AppColors.blue,
        scaffoldBackgroundColor: AppColors.lightBackground,
        colorScheme: const ColorScheme.light(
          primary: AppColors.blue,
          secondary: AppColors.blueMuted,
          surface: AppColors.lightSurface,
          onPrimary: AppColors.darkBackground,
          onSurface: AppColors.lightText,
        ),
        fontFamily: arabicUIFont,
        textTheme: _textTheme(Brightness.light),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.darkBackground,
          foregroundColor: AppColors.blue,
          titleTextStyle: TextStyle(
            fontFamily: arabicUIFont,
            color: AppColors.blue,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: IconThemeData(color: AppColors.blue),
        ),
        iconTheme: const IconThemeData(color: AppColors.blue),
        dividerColor: AppColors.lightDivider,
        tabBarTheme: const TabBarThemeData(
          labelColor: AppColors.blue,
          unselectedLabelColor: AppColors.lightSubtext,
          indicatorColor: AppColors.blue,
        ),
      );

  static ThemeData get dark => ThemeData(
        useMaterial3: false,
        brightness: Brightness.dark,
        primaryColor: AppColors.blueLight,
        scaffoldBackgroundColor: AppColors.darkBackground,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.blueLight,
          secondary: AppColors.blue,
          surface: AppColors.darkSurface,
          onPrimary: AppColors.darkBackground,
          onSurface: AppColors.darkText,
        ),
        fontFamily: arabicUIFont,
        textTheme: _textTheme(Brightness.dark),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 0,
          backgroundColor: AppColors.darkBackground,
          foregroundColor: AppColors.blueLight,
          titleTextStyle: TextStyle(
            fontFamily: arabicUIFont,
            color: AppColors.blueLight,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          iconTheme: IconThemeData(color: AppColors.blueLight),
        ),
        iconTheme: const IconThemeData(color: AppColors.blueLight),
        dividerColor: AppColors.darkDivider,
        tabBarTheme: const TabBarThemeData(
          labelColor: AppColors.blueLight,
          unselectedLabelColor: AppColors.darkSubtext,
          indicatorColor: AppColors.blueLight,
        ),
      );

  static TextTheme _textTheme(Brightness brightness) {
    final textColor = brightness == Brightness.dark
        ? AppColors.darkText
        : AppColors.lightText;
    final accent =
        brightness == Brightness.dark ? AppColors.blueLight : AppColors.blue;
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: arabicQuranicFont,
        fontSize: 22,
        fontWeight: FontWeight.w400,
        height: 1.8,
        color: textColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: surahNameFont,
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: accent,
      ),
      bodyMedium: TextStyle(
        fontFamily: arabicUIFont,
        fontSize: 14,
        height: 1.6,
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
