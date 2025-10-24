import 'package:flutter/material.dart';

/// Papel Taksi App Color Palette
/// Based on Soft POS Color Guide
class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF373B49);
  static const Color primaryDark = Color(0xFF1E2129);
  static const Color secondary = Color(0xFF8A93B4);
  static const Color accent = Color(0xFF4D38E7);

  // Text Colors
  static const Color textPrimary = Color(0xFF1E2129);
  static const Color textSecondary = Color(0xFF8A93B4);
  static const Color textDisabled = Color(0xFF9296A5);

  // Button Colors
  static const Color buttonDisabled = Color(0xFFF3F4F6);
  static const Color ripple = Color(0xFFE94435);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Background Colors
  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundSecondary = Color(0xFFF9FAFB);
  static const Color backgroundTertiary = Color(0xFFF3F4F6);

  // Divider & Border Colors
  static const Color divider = Color(0xFFE5E7EB);
  static const Color border = Color(0xFFD1D5DB);

  // Overlay Colors
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);

  // Gradient Colors
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary, primaryDark],
  );

  static const LinearGradient accentGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [accent, Color(0xFF6B5AED)],
  );
}
