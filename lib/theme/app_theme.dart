import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Color Palette - Telemetry High-Octane Dark Mode
  static const Color background = Color(0xFF0B0E14);
  static const Color surface = Color(0xFF161A23);
  static const Color cardDark = Color(0xFF1E2430);
  static const Color glassBorder = Color(0xFF2D3548);

  // Accents & Brand Colors
  static const Color triumphRed = Color(0xFFE60012); // Triumph Racing Crimson
  static const Color neonRed = Color(0xFFFF2A54); // Ducati / Racing
  static const Color electricCyan = Color(0xFF00F0FF); // High Tech / Yamaha
  static const Color neonGreen = Color(0xFF25D366); // WhatsApp / Kawasaki
  static const Color vividGold = Color(0xFFFFD700); // Ohlins / Brembo
  static const Color bmwBlue = Color(0xFF0066FF); // BMW M
  static const Color darkBanner = Color(0xFF10141D); // Header background

  static const Color textPrimary = Color(0xFFF0F4F8);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: neonRed,
      colorScheme: const ColorScheme.dark(
        primary: neonRed,
        secondary: electricCyan,
        surface: surface,
        tertiary: vividGold,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.orbitron(
          fontSize: 38,
          fontWeight: FontWeight.w900,
          color: textPrimary,
          letterSpacing: 1.5,
        ),
        displayMedium: GoogleFonts.orbitron(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: 1.2,
        ),
        displaySmall: GoogleFonts.orbitron(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        headlineMedium: GoogleFonts.rajdhani(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        titleLarge: GoogleFonts.rajdhani(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 15,
          color: textPrimary,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 13,
          color: textSecondary,
          height: 1.4,
        ),
        labelLarge: GoogleFonts.rajdhani(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.0,
          color: textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardDark,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: glassBorder, width: 1),
        ),
      ),
    );
  }

  // Helper Glassmorphism & Neon BoxDecorations
  static BoxDecoration glassDecoration({
    Color? borderColor,
    Color? fillColor,
    double borderRadius = 16,
  }) {
    return BoxDecoration(
      color: fillColor ?? surface.withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ?? glassBorder,
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  // iOS Liquid Glassmorphism Decoration Utility
  static BoxDecoration liquidGlassDecoration({
    Color? borderColor,
    Color? fillColor,
    double borderRadius = 20,
    double glowOpacity = 0.25,
  }) {
    return BoxDecoration(
      color: fillColor ?? const Color(0xFF141923).withValues(alpha: 0.65),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: borderColor ?? Colors.white.withValues(alpha: 0.16),
        width: 1.2,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.45),
          blurRadius: 24,
          offset: const Offset(0, 10),
        ),
        if (borderColor != null)
          BoxShadow(
            color: borderColor.withValues(alpha: glowOpacity),
            blurRadius: 16,
            spreadRadius: 0,
          ),
      ],
    );
  }

  // iOS Liquid Glass Pill Button / Chip Utility
  static BoxDecoration liquidGlassPill({
    Color? accentColor,
    bool isActive = false,
  }) {
    final activeColor = accentColor ?? triumphRed;
    return BoxDecoration(
      color: isActive
          ? activeColor.withValues(alpha: 0.25)
          : const Color(0xFF161B26).withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(30),
      border: Border.all(
        color: isActive ? activeColor : Colors.white.withValues(alpha: 0.14),
        width: isActive ? 1.5 : 1.0,
      ),
      boxShadow: isActive
          ? [
              BoxShadow(
                color: activeColor.withValues(alpha: 0.3),
                blurRadius: 14,
                spreadRadius: 1,
              ),
            ]
          : [],
    );
  }

  static BoxDecoration neonGlowDecoration({
    required Color color,
    double borderRadius = 16,
  }) {
    return BoxDecoration(
      color: surface,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.35),
          blurRadius: 18,
          spreadRadius: 1,
        ),
      ],
    );
  }
}
