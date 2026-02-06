import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextAtom extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const AppTextAtom._({
    super.key,
    required this.text,
    required this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  /// H1: Poppins, Light, 32px (Desktop)
  factory AppTextAtom.h1(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    double fontSize = 32,
    FontWeight fontWeight = FontWeight.w300,
  }) {
    return AppTextAtom._(
      key: key,
      text: text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        height: 0.9,
        letterSpacing: -0.05 * fontSize,
      ),
    );
  }

  /// H2: Poppins, Light, 24px
  factory AppTextAtom.h2(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    double fontSize = 24,
    FontWeight fontWeight = FontWeight.w300,
  }) {
    return AppTextAtom._(
      key: key,
      text: text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        height: 0.9,
        letterSpacing: -0.05 * fontSize,
      ),
    );
  }

  /// H3: Poppins, Light, 20px
  factory AppTextAtom.h3(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    double fontSize = 20,
    FontWeight fontWeight = FontWeight.w300,
  }) {
    return AppTextAtom._(
      key: key,
      text: text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        height: 0.9,
        letterSpacing: -0.05 * fontSize,
      ),
    );
  }

  /// H4: Poppins, Light, 18px
  factory AppTextAtom.h4(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    double fontSize = 18,
    FontWeight fontWeight = FontWeight.w300,
  }) {
    return AppTextAtom._(
      key: key,
      text: text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        height: 0.9,
        letterSpacing: -0.05 * fontSize,
      ),
    );
  }

  /// H5: Poppins, Light, 16px
  factory AppTextAtom.h5(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w300,
  }) {
    return AppTextAtom._(
      key: key,
      text: text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        height: 0.9,
        letterSpacing: -0.05 * fontSize,
      ),
    );
  }

  /// H6: Poppins, Light, 14px
  factory AppTextAtom.h6(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    double fontSize = 14,
    FontWeight fontWeight = FontWeight.w300,
  }) {
    return AppTextAtom._(
      key: key,
      text: text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        height: 0.9,
        letterSpacing: -0.05 * fontSize,
      ),
    );
  }

  /// Script: Oleo Script, Bold
  factory AppTextAtom.script(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    double fontSize = 24,
  }) {
    return AppTextAtom._(
      key: key,
      text: text,
      textAlign: textAlign,
      style: GoogleFonts.oleoScript(
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
        color: color,
      ),
    );
  }

  /// Body: Roboto Slab, Normal, 16px
  factory AppTextAtom.body(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.normal,
  }) {
    return AppTextAtom._(
      key: key,
      text: text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.robotoSlab(
        fontWeight: fontWeight,
        fontSize: fontSize,
        color: color,
        height: 1.5,
      ),
    );
  }

  /// Button: Roboto Slab, Normal, 14px
  factory AppTextAtom.button(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
  }) {
    return AppTextAtom._(
      key: key,
      text: text,
      textAlign: textAlign,
      style: GoogleFonts.robotoSlab(
        fontWeight: FontWeight.normal,
        fontSize: 14,
        color: color,
      ),
    );
  }

  /// Navigation Link: Poppins, 16px
  factory AppTextAtom.nav(
    String text, {
    Key? key,
    Color? color,
    TextAlign? textAlign,
    bool isActive = false,
  }) {
    return AppTextAtom._(
      key: key,
      text: text,
      textAlign: textAlign,
      style: GoogleFonts.poppins(
        fontWeight: isActive ? FontWeight.w600 : FontWeight.w300,
        fontSize: 16,
        color: color,
        letterSpacing: -0.05 * 16,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final finalStyle = style.color == null
        ? style.copyWith(color: Theme.of(context).colorScheme.onSurface)
        : style;

    return Text(
      text,
      textAlign: textAlign,
      style: finalStyle,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
