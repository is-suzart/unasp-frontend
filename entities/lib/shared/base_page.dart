import 'menu.dart';
import 'visual_components.dart';

/// Base class for pages that carry common structure:
/// ID, Name, Route, Type, Menu, and Visuals.
abstract class BasePageEntity {
  final String id;
  final String name;
  final String route;
  final String? type; // Optional in base/Page, required in Community
  final MenuEntity menu;
  final List<VisualComponent> visuals;

  const BasePageEntity({
    required this.id,
    required this.name,
    required this.route,
    this.type,
    required this.menu,
    required this.visuals,
  });
}
