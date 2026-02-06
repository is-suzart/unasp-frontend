import 'package:flutter/material.dart';

/// Centralized mapper to convert string keys to IconData.
/// This prevents logic duplication across Widgets.
class AppIconMapper {
  static IconData? parse(String? iconName) {
    if (iconName == null || iconName.isEmpty) return null;

    switch (iconName) {
      // Navigation
      case 'home':
        return Icons.grid_view_rounded; // Cleaner look for 'home' in dashboard
      case 'school':
      case 'academic':
        return Icons.school_outlined;
      case 'attach_money':
      case 'financial':
        return Icons.attach_money;
      case 'settings':
        return Icons.settings_outlined;

      // Actions
      case 'logout':
        return Icons.logout_rounded;
      case 'notifications':
        return Icons.notifications_none_rounded;
      case 'person':
      case 'profile':
        return Icons.person_outline_rounded;
      case 'search':
        return Icons.search_rounded;

      // Social / Misc
      case 'arrow_forward':
        return Icons.arrow_forward_rounded;
      case 'play_circle':
        return Icons.play_circle_outline_rounded;
      case 'facebook':
        return Icons.facebook;
      case 'instagram':
        return Icons.camera_alt_outlined;
      case 'link':
        return Icons.link;

      default:
        // Try to handle common cases matching standard icon names roughly
        if (iconName.contains('dashboard')) return Icons.dashboard_outlined;
        if (iconName.contains('chart')) return Icons.bar_chart_rounded;
        return Icons
            .circle_outlined; // Default fallback to a bullet point style
    }
  }
}
