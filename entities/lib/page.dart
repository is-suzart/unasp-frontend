import 'shared/base_page.dart';

/// Represents a standard page structure
class PageEntity extends BasePageEntity {
  final String communityId;

  const PageEntity({
    required super.id,
    required super.name,
    required super.route,
    required super.menu,
    required super.visuals,
    required this.communityId,
  });
}
