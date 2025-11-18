import 'package:flutter/material.dart';

class AppColors {
  // Neutral backgrounds
  static const Color lightBackground = Color(0xFFF6F7FB);
  static const Color darkBackground = Color(0xFF0B1020);

  // Primary accent (subtle, Apple-like)
  static const Color accent = Color(0xFF3B82F6); // blue
  static const Color accentSoft = Color(0xFF60A5FA);

  // Text
  static const Color textDark = Color(0xFF0F172A);
  static const Color textLight = Color(0xFFF8FAFC);

  // Gentle gray for cards / surfaces
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF0F172A);

  // Scaffold light theme gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFFFFF),
      Color(0xFFF0F7FF), // frosted white-blue
      Color(0xFFE4F0FF), // light sky blue
      Color(0xFFD8EBFF), // slightly stronger blue
    ],
    stops: [0.0, 0.4, 0.75, 1.0],
  );

  // Card light theme gradient
  static const cardlightGradient = LinearGradient(
    colors: [
      Color(0xFFF9F7FF),
      Color(0xFFFFFFFF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Container light theme gradient
  static const containerlightGradient = LinearGradient(
    colors: [
      Color(0xFFF4EFFF), // soft lavender
      Color(0xFFE7F0FF), // soft blue
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Buton gradient theme
  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF7F00FF), // vivid purple
      Color(0xFF0072FF), // deep blue
    ],
  );

  // navbar underline gradient
  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF60A5FA), Color(0xFF3B82F6)],
  );
}
