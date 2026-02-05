import 'package:entities/theme.dart';
import 'package:flutter/material.dart';
import 'app_text_atom.dart';

enum AppButtonStyle { filled, outlined }

enum AppButtonColor {
  primary,
  secondary,
  danger,
  warning,
  neutral,
  mint,
  sunflower,
  periwinkle,
  coral,
}

class AppButtonAtom extends StatelessWidget {
  final String label;
  final IconData? icon;
  final AppButtonStyle style;
  final AppButtonColor color;
  final VoidCallback? onPressed;

  const AppButtonAtom({
    super.key,
    required this.label,
    required this.style,
    required this.color,
    this.icon,
    this.onPressed,
  });

  Color _getColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    switch (color) {
      case AppButtonColor.primary:
        return scheme.primary;
      case AppButtonColor.secondary:
        return scheme.secondary;
      case AppButtonColor.danger:
        return scheme.error;
      case AppButtonColor.warning:
        return Colors.orange;
      case AppButtonColor.neutral:
        return scheme.surfaceContainerHighest;
      case AppButtonColor.mint:
        return UnaspColors.mintTeal;
      case AppButtonColor.sunflower:
        return UnaspColors.sunflower;
      case AppButtonColor.periwinkle:
        return UnaspColors.periwinkle;
      case AppButtonColor.coral:
        return UnaspColors.softCoral;
    }
  }

  Color _getOnColor(BuildContext context) {
    if (style == AppButtonStyle.outlined) {
      return _getColor(context); // Outlined uses same color for text
    }
    final scheme = Theme.of(context).colorScheme;
    switch (color) {
      case AppButtonColor.primary:
        return scheme.onPrimary;
      case AppButtonColor.secondary:
        return scheme.onSecondary;
      case AppButtonColor.danger:
        return scheme.onError;
      case AppButtonColor.warning:
        return Colors.white;
      case AppButtonColor.neutral:
        return scheme.onSurfaceVariant;
      case AppButtonColor.mint:
        return UnaspColors.pureBlack; // Dark text on light mint
      case AppButtonColor.sunflower:
        return UnaspColors.pureBlack; // Dark text on yellow
      case AppButtonColor.periwinkle:
        return Colors.white; // White text on purple
      case AppButtonColor.coral:
        return Colors.white; // White text on coral
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = _getColor(context);
    final onColor = _getOnColor(context);

    // Padding for "respiro"
    final padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 20);

    // Border Radius
    final borderRadius = BorderRadius.circular(30);

    // Content: Row with Text + Icon
    final content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextAtom.button(
          label,
          color: onColor, // Explicitly pass color as it varies by style/theme
        ),
        if (icon != null) ...[
          const SizedBox(width: 8),
          Icon(icon, size: 18, color: onColor), // Icon matches text color
        ],
      ],
    );

    if (style == AppButtonStyle.filled) {
      return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: themeColor,
          foregroundColor: onColor,
          padding: padding,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          elevation: 0,
        ),
        child: content,
      );
    } else {
      return OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: themeColor,
          side: BorderSide(color: themeColor, width: 1.0),
          padding: padding,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
        ),
        child: content,
      );
    }
  }
}
