import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  // ---------------- LIGHT THEME ----------------
  static final ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBackground,
    primaryColor: AppColors.accent,
    colorScheme: const ColorScheme.light(
      primary: AppColors.accent,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textDark,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.textDark,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.textDark),
      bodySmall: TextStyle(fontSize: 14, color: AppColors.textDark),
    ),
    appBarTheme: const AppBarTheme(
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: AppColors.textDark,
    ),
    cardTheme: const CardThemeData(
      color: AppColors.surfaceLight,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    // ⭐ NEW MODERN GRADIENT FOR LIGHT MODE
    extensions: const <ThemeExtension<dynamic>>[
      LightGradientTheme(
        backgroundGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFEAF1FF), // soft blue
            Color(0xFFDDE7FF), // pale blue
            Color(0xFFC3D4FF), // light lavender-blue
            Color(0xFFEEF0FF), // soft white-lavender
          ],
          stops: [0.0, 0.35, 0.75, 1.0],
        ),
      ),
    ],
  );

  // ---------------- DARK THEME ----------------
  static final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.transparent,
    primaryColor: AppColors.accent,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.accent,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textLight,
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.textLight,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textLight,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: AppColors.textLight),
      bodySmall: TextStyle(fontSize: 14, color: AppColors.textLight),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: AppColors.textLight,
    ),
    cardTheme: const CardThemeData(
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    // ⭐ EXISTING DARK GRADIENT (unchanged)
    extensions: const <ThemeExtension<dynamic>>[
      DarkGradientTheme(
        backgroundGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0B1020),
            Color(0xFF111A2E),
            Color(0xFF1A233C),
            Color(0xFF243356),
          ],
          stops: [0.0, 0.4, 0.75, 1.0],
        ),
      ),
    ],
  );
}

// --------------------------------------------------------------------
// ⭐ Custom Theme Extension: LIGHT GRADIENT
// --------------------------------------------------------------------
@immutable
class LightGradientTheme extends ThemeExtension<LightGradientTheme> {
  final LinearGradient backgroundGradient;

  const LightGradientTheme({
    required this.backgroundGradient,
  });

  @override
  LightGradientTheme copyWith({LinearGradient? backgroundGradient}) {
    return LightGradientTheme(
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
    );
  }

  @override
  LightGradientTheme lerp(ThemeExtension<LightGradientTheme>? other, double t) {
    if (other is! LightGradientTheme) return this;
    return LightGradientTheme(
      backgroundGradient:
          LinearGradient.lerp(backgroundGradient, other.backgroundGradient, t)!,
    );
  }
}

// --------------------------------------------------------------------
// ⭐ Custom Theme Extension: DARK GRADIENT (unchanged)
// --------------------------------------------------------------------
@immutable
class DarkGradientTheme extends ThemeExtension<DarkGradientTheme> {
  final LinearGradient backgroundGradient;

  const DarkGradientTheme({
    required this.backgroundGradient,
  });

  @override
  DarkGradientTheme copyWith({LinearGradient? backgroundGradient}) {
    return DarkGradientTheme(
      backgroundGradient: backgroundGradient ?? this.backgroundGradient,
    );
  }

  @override
  DarkGradientTheme lerp(ThemeExtension<DarkGradientTheme>? other, double t) {
    if (other is! DarkGradientTheme) return this;
    return DarkGradientTheme(
      backgroundGradient:
          LinearGradient.lerp(backgroundGradient, other.backgroundGradient, t)!,
    );
  }
}
