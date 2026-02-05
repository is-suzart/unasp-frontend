import 'package:flutter/material.dart';
import 'app_text_atom.dart';

class AppNavLinkAtom extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;
  final Color? textColor;
  final IconData? icon;

  const AppNavLinkAtom({
    super.key,
    required this.label,
    required this.isActive,
    required this.onTap,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Theme & Colors
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final effectiveColor = textColor ?? colorScheme.onSurface;

    // "A cor deve ser um creme suave ou off-white"
    // Using onSurface as requested for Clean Architecture compliance.

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50), // Stadium
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut, // Smooth transition
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), // StadiumBorder
          border: Border.all(
            // Active: Border width 1.0. Inactive: Transparent.
            color: isActive ? effectiveColor : Colors.transparent,
            width: 1.0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: effectiveColor, size: 20),
              const SizedBox(width: 8),
            ],
            AppTextAtom.body(
              label,
              // 2. Typography: Roboto Slab (via AppTextAtom.body)
              // Weight: Normal (w400) as requested for PC-4 style.
              fontWeight: FontWeight.w400,
              // Color: White when active or inactive (as requested: "na cor branca")
              // Wait, "quando ativo no dourado". So: Active=Gold, Inactive=White.
              color: effectiveColor,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
