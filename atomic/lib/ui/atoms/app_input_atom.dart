import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppInputAtom extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final String? errorText;

  const AppInputAtom({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.errorText,
  });

  @override
  State<AppInputAtom> createState() => _AppInputAtomState();
}

class _AppInputAtomState extends State<AppInputAtom> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText;
  }

  @override
  void didUpdateWidget(covariant AppInputAtom oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.obscureText != oldWidget.obscureText) {
      _isObscured = widget.obscureText;
    }
  }

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    // "Soft colors"
    final fillColor = colorScheme.surfaceContainerHighest.withValues(
      alpha: 0.5,
    );
    final textColor = colorScheme.onSurface;

    // User requested lighter/softer gray for hints
    final hintColor = Colors.grey[400];

    final borderRadius = BorderRadius.circular(20);
    const contentPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 16);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12, bottom: 8),
          child: Text(
            widget.label,
            style: GoogleFonts.robotoSlab(
              fontSize: 14,
              color: textColor.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        TextFormField(
          controller: widget.controller,
          onChanged: widget.onChanged,
          obscureText: _isObscured,
          keyboardType: widget.keyboardType,
          style: GoogleFonts.poppins(color: textColor, fontSize: 16),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: GoogleFonts.robotoSlab(color: hintColor),
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon, color: hintColor, size: 20)
                : null,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _isObscured
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: hintColor,
                    ),
                    onPressed: _toggleVisibility,
                  )
                : null,
            errorText: widget.errorText,
            filled: true,
            fillColor: fillColor,
            contentPadding: contentPadding,
            border: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.5),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(
                color: colorScheme.outline.withValues(alpha: 0.5),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: colorScheme.error, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
