import 'visual_components.dart';

/// Represents the top navigation/menu
class MenuEntity {
  final String logo;
  final String? logoIcon; // Icon version of the logo
  final List<MenuItemEntity> items;
  final List<ButtonEntity> buttons;

  const MenuEntity({
    required this.logo,
    this.logoIcon,
    required this.items,
    this.buttons = const [],
  });
}

/// Represents an individual item in the menu
class MenuItemEntity {
  final String text;
  final String url;
  final String? icon;

  const MenuItemEntity({required this.text, required this.url, this.icon});
}
