import 'package:flutter/material.dart';

// App Colors - Centralized color management
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF4CAF50);        // Green
  static const Color primaryDark = Color(0xFF388E3C);     // Dark Green
  static const Color primaryLight = Color(0xFF81C784);    // Light Green

  // Secondary Colors
  static const Color secondary = Color(0xFF2E7D32);       // Forest Green
  static const Color accent = Color(0xFFFFEB3B);          // Yellow accent

  // Background Colors
  static const Color background = Color(0xFFF1F8E9);      // Light green background
  static const Color surface = Color(0xFFFFFFFF);         // White
  static const Color cardBackground = Color(0xFFF5F5F5);  // Light grey

  // Text Colors
  static const Color textPrimary = Color(0xFF212121);     // Dark grey
  static const Color textSecondary = Color(0xFF757575);   // Medium grey
  static const Color textHint = Color(0xFF9E9E9E);        // Light grey
  static const Color textOnPrimary = Color(0xFFFFFFFF);   // White text on green

  // Status Colors
  static const Color success = Color(0xFF4CAF50);         // Green
  static const Color error = Color(0xFFF44336);           // Red
  static const Color warning = Color(0xFFFF9800);         // Orange
  static const Color info = Color(0xFF2196F3);            // Blue

  // Border Colors
  static const Color border = Color(0xFFE0E0E0);          // Light border
  static const Color borderFocused = Color(0xFF4CAF50);   // Green focused border
  static const Color borderError = Color(0xFFF44336);     // Red error border

  // Shadow Colors
  static const Color shadow = Color(0x1A000000);          // Light shadow
  static const Color shadowMedium = Color(0x33000000);    // Medium shadow

  // Transparent Colors
  static const Color transparent = Colors.transparent;
  static const Color overlay = Color(0x80000000);         // Dark overlay
}