import 'package:entities/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AtomicTheme {
  static ThemeData get lightTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: UnaspColors.sandBeige,
        onPrimary: UnaspColors.pureWhite,
        secondary: UnaspColors.mintTeal, // Updated to use mint
        onSecondary: UnaspColors
            .pureBlack, // Consider darker gray if avoiding pure black
        tertiary: UnaspColors.sunflower, // Updated to use sunflower
        onTertiary: UnaspColors.darkCharcoal,
        error: UnaspColors.softCoral,
        onError: UnaspColors.pureWhite,
        surface: UnaspColors.background,
        onSurface: UnaspColors.darkCharcoal, // Avoid pure black
        outline: UnaspColors.grayStandard,
      ),
    );
    return _applyFonts(base);
  }

  static ThemeData get darkTheme {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: UnaspColors.periwinkle,
        onPrimary: UnaspColors.softWhite, // Not pure white
        secondary: UnaspColors.mintTeal,
        onSecondary: UnaspColors.darkBackground,
        tertiary: UnaspColors.sunflower,
        onTertiary: UnaspColors.darkBackground,
        error: UnaspColors.softCoral,
        onError: UnaspColors.softWhite,
        surface: UnaspColors.darkSurface, // Slightly lighter than bg
        onSurface: UnaspColors.softWhite, // Not pure white
        background: UnaspColors.darkBackground,
        onBackground: UnaspColors.softWhite,
        outline: UnaspColors.dimGray,
      ),
      scaffoldBackgroundColor: UnaspColors.darkBackground,
    );
    return _applyFonts(base);
  }

  static ThemeData _applyFonts(ThemeData base) {
    return base.copyWith(
      textTheme: GoogleFonts.robotoSlabTextTheme(base.textTheme).copyWith(
        // Headlines -> Poppins
        displayLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          letterSpacing: -0.05 * 57,
          height: 0.9,
        ),
        displayMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          letterSpacing: -0.05 * 45,
          height: 0.9,
        ),
        displaySmall: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          letterSpacing: -0.05 * 36,
          height: 0.9,
        ),
        headlineLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          letterSpacing: -0.05 * 32,
          height: 0.9,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          letterSpacing: -0.05 * 28,
          height: 0.9,
        ),
        headlineSmall: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          letterSpacing: -0.05 * 24,
          height: 0.9,
        ),
        titleLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          letterSpacing: -0.05 * 22,
          height: 0.9,
        ),
        titleMedium: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          letterSpacing: -0.05 * 16,
          height: 0.9,
        ),
        titleSmall: GoogleFonts.poppins(
          fontWeight: FontWeight.w300,
          letterSpacing: -0.05 * 14,
          height: 0.9,
        ),

        // Body -> Roboto Slab (Default)
        bodyLarge: GoogleFonts.robotoSlab(fontWeight: FontWeight.w400),
        bodyMedium: GoogleFonts.robotoSlab(fontWeight: FontWeight.w400),
        bodySmall: GoogleFonts.robotoSlab(fontWeight: FontWeight.w400),
      ),
    );
  }
}
