import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF121212); // Deep Black
  static const Color surface = Color(0xFF1E1E1E); // Dark Grey
  static const Color primary = Color(0xFFC5A08E); // Rose Gold/Copper
  static const Color textMain = Colors.white;
  static const Color textSecondary = Colors.grey;
  static const Color inputBorder = Color(0xFF333333);
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textMain,
    letterSpacing: 1.2,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
}

class AppButtons {
  static ButtonStyle primaryAction = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.black,
    minimumSize: const Size(double.infinity, 56),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  );

  static ButtonStyle socialAction = OutlinedButton.styleFrom(
    foregroundColor: AppColors.textMain,
    minimumSize: const Size(double.infinity, 50),
    side: const BorderSide(color: AppColors.inputBorder),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}
