import 'package:flutter/material.dart';

class AppColors {
  // ── Black & Light-Blue palette ─────────────────────────────────────────────
  // Light: cool off-white background, near-black text
  static const Color background = Color(0xFFF0F6FC);
  static const Color textColor = Color(0xFF0A1520);

  // Dark: pure black background, light blue text
  static const Color darkBackground = Color(0xFF1A1A1A);
  static const Color darkSurface = Color(0xFF111111);
  static const Color darkTextColor = Color(0xFF90CFFA);

  // Getter theme colors
  static Color getTextColor(bool isDarkMode) =>
      isDarkMode ? darkTextColor : textColor;
  static Color getBackgroundColor(bool isDarkMode) =>
      isDarkMode ? darkBackground : background;
  static Color getSurfaceColor(bool isDarkMode) =>
      isDarkMode ? darkSurface : Colors.white;
}
