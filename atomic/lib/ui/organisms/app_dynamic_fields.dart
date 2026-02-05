import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../atoms/app_input_atom.dart';
import '../atoms/app_toggle_atoms.dart';

enum DynamicFieldType { text, number, email, password, checkbox, radio, toggle }

class DynamicFieldConfig {
  final String key;
  final DynamicFieldType type;
  final String label;
  final String? hint;
  final List<String>? options; // For radio
  final dynamic defaultValue;

  const DynamicFieldConfig({
    required this.key,
    required this.type,
    required this.label,
    this.hint,
    this.options,
    this.defaultValue,
  });
}

class AppDynamicFields extends StatelessWidget {
  final List<DynamicFieldConfig> fields;
  final Map<String, dynamic> values;
  final Function(String key, dynamic value) onFieldChanged;

  const AppDynamicFields({
    super.key,
    required this.fields,
    required this.values,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: fields.map((field) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: _buildField(context, field),
        );
      }).toList(),
    );
  }

  Widget _buildField(BuildContext context, DynamicFieldConfig field) {
    final currentValue = values[field.key] ?? field.defaultValue;

    switch (field.type) {
      case DynamicFieldType.text:
      case DynamicFieldType.email:
      case DynamicFieldType.number:
      case DynamicFieldType.password:
        return AppInputAtom(
          label: field.label,
          hint: field.hint,
          // Note: In a real app, you might want to manage controllers differently
          // or pass initialValue if AppInputAtom supported it.
          // Here, we assume the mechanism updates the parent state which rebuilds this widget.
          controller: TextEditingController(text: currentValue?.toString())
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: (currentValue?.toString() ?? '').length),
            ),
          keyboardType: _getKeyboardType(field.type),
          obscureText: field.type == DynamicFieldType.password,
          onChanged: (val) => onFieldChanged(field.key, val),
        );

      case DynamicFieldType.checkbox:
        return AppCheckboxAtom(
          label: field.label,
          value: currentValue == true,
          onChanged: (val) => onFieldChanged(field.key, val),
        );

      case DynamicFieldType.toggle:
        return AppSwitchAtom(
          label: field.label,
          value: currentValue == true,
          onChanged: (val) => onFieldChanged(field.key, val),
        );

      case DynamicFieldType.radio:
        if (field.options == null || field.options!.isEmpty) {
          return Text('No options for radio field ${field.label}');
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, bottom: 8),
              child: Text(
                field.label,
                style: GoogleFonts.robotoSlab(
                  fontSize: 14,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ...field.options!.map(
              (option) => AppRadioAtom<String>(
                label: option,
                value: option,
                groupValue: currentValue?.toString(),
                onChanged: (val) => onFieldChanged(field.key, val),
              ),
            ),
          ],
        );
    }
  }

  TextInputType _getKeyboardType(DynamicFieldType type) {
    switch (type) {
      case DynamicFieldType.email:
        return TextInputType.emailAddress;
      case DynamicFieldType.number:
        return TextInputType.number;
      default:
        return TextInputType.text;
    }
  }
}
