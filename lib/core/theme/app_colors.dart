import 'package:flutter/material.dart';

/// Black and light-blue palette used across both Material theme and quran_library styles.
class AppColors {
  AppColors._();

  // ── Blue shades ────────────────────────────────────────────────────────────
  static const Color blue = Color(0xFF5BB8F5);
  static const Color blueLight = Color(0xFF90CFFA);
  static const Color blueDark = Color(0xFF2E8FD4);
  static const Color blueMuted = Color(0xFF4AA8E8);

  // ── Light theme ───────────────────────────────────────────────────────────
  static const Color lightBackground = Color(0xFFF0F6FC); // cool off-white
  static const Color lightSurface = Color(0xFFE3EFF8);
  static const Color lightText = Color(0xFF0A1520);
  static const Color lightSubtext = Color(0xFF3A5068);
  static const Color lightDivider = Color(0xFFAACCE8);

  // ── Dark theme (blue on black) ─────────────────────────────────────────────
  static const Color darkBackground = Color(0xFF0D0D0D);
  static const Color darkSurface = Color(0xFF001525);
  static const Color darkText = Color(0xFFD0E8F8);
  static const Color darkSubtext = Color(0xFF6AAAD0);
  static const Color darkDivider = Color(0xFF0D2A40);

  // ── Shared ─────────────────────────────────────────────────────────────────
  static const Color transparent = Colors.transparent;

  // ── Helpers ───────────────────────────────────────────────────────────────
  static Color background(bool isDark) =>
      isDark ? darkBackground : lightBackground;
  static Color surface(bool isDark) => isDark ? darkSurface : lightSurface;
  static Color text(bool isDark) => isDark ? darkText : lightText;
  static Color subtext(bool isDark) => isDark ? darkSubtext : lightSubtext;
  static Color divider(bool isDark) => isDark ? darkDivider : lightDivider;
  static Color accent(bool isDark) => isDark ? blueLight : blue;
}
