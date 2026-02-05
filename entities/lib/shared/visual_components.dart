import 'package:flutter/material.dart';

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

/// Represents a Generic Button action
class ButtonEntity {
  final String text;
  final String url;
  final String? icon;
  final AppButtonStyle style; // Typed Enum
  final AppButtonColor color; // Typed Enum

  const ButtonEntity({
    required this.text,
    required this.url,
    this.icon,
    this.style = AppButtonStyle.filled,
    this.color = AppButtonColor.primary,
  });
}

/// Alignment options for visual components
enum VisualAlignment { left, center, right }

/// Base class for visual elements like Cards and Sections
abstract class VisualComponent {
  final String title;
  final String subtitle;
  final String? text;
  final Color? backgroundColor;
  final String? backgroundImage;
  final List<ButtonEntity> buttons;
  final VisualAlignment alignment;
  final int order;

  const VisualComponent({
    required this.title,
    required this.subtitle,
    this.text,
    this.backgroundColor,
    this.backgroundImage,
    this.buttons = const [],
    this.alignment = VisualAlignment.left,
    this.order = 0,
  });
}

class CardEntity extends VisualComponent {
  const CardEntity({
    required super.title,
    required super.subtitle,
    super.text,
    super.backgroundColor,
    super.backgroundImage,
    super.buttons,
    super.alignment,
    super.order,
  });
}

class SectionEntity extends VisualComponent {
  const SectionEntity({
    required super.title,
    required super.subtitle,
    super.text,
    super.backgroundColor,
    super.backgroundImage,
    super.buttons,
    super.alignment,
    super.order,
  });
}
