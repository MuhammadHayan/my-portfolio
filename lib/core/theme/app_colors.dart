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

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFffffff), Color(0xFFf3f6ff)],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF60A5FA), Color(0xFF3B82F6)],
  );
}
