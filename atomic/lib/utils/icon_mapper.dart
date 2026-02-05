import 'package:flutter/material.dart';

/// Centralized mapper to convert string keys to IconData.
/// This prevents logic duplication across Widgets.
class AppIconMapper {
  static IconData? parse(String? iconName) {
    if (iconName == null || iconName.isEmpty) return null;

    // Normalize string if needed?
    switch (iconName) {
      case 'arrow_forward':
        return Icons.arrow_forward;
      case 'play_circle':
        return Icons.play_circle_outline;
      case 'facebook':
        return Icons.facebook;
      case 'instagram':
        return Icons.camera_alt; // Using camera for instagram placeholder
      case 'link':
      default:
        // If it looks like a social icon but not matched
        if (iconName.contains('facebook')) return Icons.facebook;
        if (iconName.contains('instagram')) return Icons.camera_alt;
        return Icons.link; // Default fallback
    }
  }
}
