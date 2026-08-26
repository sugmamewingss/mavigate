import 'package:flutter/material.dart';

/// MaviGate Color Palette
/// Designed for "Adulting, but make it fun" & "Academic Planner" vibe:
/// Structured & trustworthy (Deep Navy & Indigo) + Youthful & energizing (Coral, Amber, Mint)
class AppColors {
  AppColors._();

  // Primary & Brand Colors
  static const Color primary = Color(0xFF4F46E5); // Indigo 600 - Structured, modern, tech-forward
  static const Color primaryLight = Color(0xFF818CF8); // Indigo 400
  static const Color primaryDark = Color(0xFF3730A3); // Indigo 800
  static const Color primaryContainer = Color(0xFFEEF2FF); // Soft indigo tint for card highlights

  // Secondary & Fun Accent Colors (Gamified / Energizing)
  static const Color secondary = Color(0xFFFF6B6B); // Playful Coral - Urgency, highlights, fun
  static const Color secondaryLight = Color(0xFFFF8E8E);
  static const Color secondaryContainer = Color(0xFFFFF0F0);

  // Functional & Academic Priority Colors
  static const Color accentAmber = Color(0xFFF59E0B); // Amber - Important deadlines, streaks
  static const Color accentAmberLight = Color(0xFFFEF3C7);
  
  static const Color accentMint = Color(0xFF10B981); // Emerald - Completed goals, GPA boost, wins
  static const Color accentMintLight = Color(0xFFD1FAE5);

  static const Color accentPurple = Color(0xFF8B5CF6); // Creative tasks, campus life
  static const Color accentPurpleLight = Color(0xFFEDE9FE);

  static const Color accentSky = Color(0xFF0EA5E9); // Classes, lectures, timetable
  static const Color accentSkyLight = Color(0xFFE0F2FE);

  // Background & Surface Colors
  static const Color background = Color(0xFFF8FAFC); // Slate 50 - Ultra-clean base
  static const Color backgroundDark = Color(0xFF0B1120); // Dark Navy - Onboarding & night base
  static const Color surface = Color(0xFFFFFFFF); // Pure White cards
  static const Color surfaceDark = Color(0xFF131D31); // Dark Navy Surface card
  static const Color surfaceVariant = Color(0xFFF1F5F9); // Slate 100
  
  // Electric Onboarding & Accent Blue
  static const Color electricBlue = Color(0xFF4361EE);
  static const Color electricBlueLight = Color(0xFF4895EF);

  // Neutral Text Colors
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900 - High contrast readable
  static const Color textPrimaryDark = Color(0xFFF8FAFC); // Light text for dark backgrounds
  static const Color textSecondary = Color(0xFF475569); // Slate 600 - Supportive details
  static const Color textSecondaryDark = Color(0xFF94A3B8); // Slate 400 - Muted text for dark backgrounds
  static const Color textTertiary = Color(0xFF94A3B8); // Slate 400 - Placeholders, timestamps
  static const Color textInverse = Color(0xFFFFFFFF);

  // Borders & Dividers
  static const Color border = Color(0xFFE2E8F0); // Slate 200 - Crisp outlines
  static const Color borderDark = Color(0xFF1E293B); // Slate 800 - Outlines in dark mode
  static const Color borderFocused = Color(0xFF4F46E5);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);
}
