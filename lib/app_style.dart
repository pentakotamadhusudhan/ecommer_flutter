import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors (Constant across themes)
  static const Color primary = Colors.teal;

  // Dark Theme Colors
  static const Color darkBg = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkInputBorder = Color(0xFF333333);

  // Light Theme Colors
  static const Color lightBg = Color(0xFFF5F5F5);
  static const Color lightSurface = Colors.white;
  static const Color lightInputBorder = Color(0xFFE0E0E0);
}


class AppTheme {
  // --- DARK THEME ---
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBg,
    cardColor: AppColors.darkSurface,
    colorScheme: const ColorScheme.dark(primary: AppColors.primary),

    // Integrated Text Styles
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1.2,
      ),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.grey),
    ),

    // Integrated Button Styles
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 50),
        side: const BorderSide(color: AppColors.darkInputBorder),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );

  // --- LIGHT THEME ---
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBg,
    cardColor: AppColors.lightSurface,
    colorScheme: const ColorScheme.light(primary: AppColors.primary),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: 1.2,
      ),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
      titleMedium: TextStyle(
        color: Colors.black, // Flips to black for readability
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 50),
        side: const BorderSide(color: AppColors.lightInputBorder),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),

  );

  InputDecoration inputDecoration(BuildContext context, String label) {
    final theme = Theme.of(context);
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: theme.hintColor),
      filled: true,
      fillColor: theme.cardColor,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: theme.dividerColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    );
  }
}


