import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Brand
  static const Color primary = Color(0xFF00D4FF); // Electric Teal
  static const Color primaryDark = Color(0xFF0099CC);
  static const Color secondary = Color(0xFF7C3AED); // Violet
  static const Color secondaryLight = Color(0xFF9D67F5);

  // Backgrounds
  static const Color background = Color(0xFF080D1A); // Deep Navy
  static const Color surface = Color(0xFF0F1629); // Card Surface
  static const Color surfaceLight = Color(0xFF1A2240); // Lighter Card
  static const Color surfaceGlass = Color(0x1AFFFFFF); // Glass overlay

  // Text
  static const Color textPrimary = Color(0xFFF0F4FF);
  static const Color textSecondary = Color(0xFF8A9CC2);
  static const Color textMuted = Color(0xFF4A5880);
  static const Color textOnPrimary = Color(0xFF080D1A);

  // Status Colors
  static const Color success = Color(0xFF00E5A0); // Mint Green
  static const Color warning = Color(0xFFFFB830); // Amber
  static const Color error = Color(0xFFFF4C6A); // Coral Red
  static const Color info = Color(0xFF00D4FF);

  // Health Metric States
  static const Color healthNormal = Color(0xFF00E5A0);
  static const Color healthBorderline = Color(0xFFFFB830);
  static const Color healthCritical = Color(0xFFFF4C6A);

  // Triage Colors
  static const Color triageGreen = Color(0xFF00E5A0);
  static const Color triageAmber = Color(0xFFFFB830);
  static const Color triageRed = Color(0xFFFF4C6A);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00D4FF), Color(0xFF7C3AED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient backgroundGradient = LinearGradient(
    colors: [Color(0xFF080D1A), Color(0xFF0F1629), Color(0xFF141E35)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF1A2240), Color(0xFF0F1629)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient tealGradient = LinearGradient(
    colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient violetGradient = LinearGradient(
    colors: [Color(0xFF9D67F5), Color(0xFF7C3AED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Divider
  static const Color divider = Color(0xFF1E2B4A);

  // Chart colors
  static const List<Color> chartColors = [
    Color(0xFF00D4FF),
    Color(0xFF7C3AED),
    Color(0xFF00E5A0),
    Color(0xFFFFB830),
    Color(0xFFFF4C6A),
  ];
}
