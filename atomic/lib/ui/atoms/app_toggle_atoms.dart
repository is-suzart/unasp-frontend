import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppCheckboxAtom extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String label;

  const AppCheckboxAtom({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: value,
              onChanged: onChanged,
              activeColor: scheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              side: BorderSide(color: scheme.outline, width: 1.5),
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.robotoSlab(
                color: scheme.onSurface,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppRadioAtom<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final String label;

  const AppRadioAtom({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<T>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: scheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.robotoSlab(
                color: scheme.onSurface,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppSwitchAtom extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String label;

  const AppSwitchAtom({
    super.key,
    required this.value,
    required this.onChanged,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: value,
              onChanged: onChanged,
              thumbColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return scheme.onPrimary;
                }
                return scheme.onSurfaceVariant;
              }),
              trackColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return scheme.primary;
                }
                return scheme.surfaceContainerHighest;
              }),
              trackOutlineColor: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.transparent;
                }
                return scheme.outline;
              }),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.robotoSlab(
                color: scheme.onSurface,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
