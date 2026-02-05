import 'shared/base_page.dart';

enum CommunityType { ministerios, other }

class CommunityEntity extends BasePageEntity {
  final CommunityType communityType;
  final String logoUrl;
  final bool isActive;

  // The 'slug' requirement is mapped to the 'route' field in BasePageEntity.
  String get slug => route;

  CommunityEntity({
    required super.id,
    required super.name,
    required super.route, // This serves as the slug
    required this.communityType,
    required super.menu,
    required super.visuals,
    required this.logoUrl,
    required this.isActive,
  }) : super(type: communityType.name);
}
