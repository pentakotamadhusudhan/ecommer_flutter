import 'package:flutter/material.dart';

// Constant Text Styles
class TextStyleConst {
  // Heading Text Style
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  static const TextStyle labelstyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // Subheading Text Style
  static const TextStyle subheading = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );

  // Body Text Style
  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: Colors.black87,
  );

  // Button Text Style
  static const TextStyle button = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // Error Text Style
  static const TextStyle error = TextStyle(
    fontSize: 14,
    color: Colors.red,
  );

  // Placeholder Text Style (e.g., for text fields)
  static const TextStyle placeholder = TextStyle(
    fontSize: 16,
    color: Colors.grey,
  );

  // Custom Text Style Example
  static TextStyle customTextStyle({
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.normal,
    Color color = Colors.black,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
