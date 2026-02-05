class UserEntity {
  final String id;
  final String name;
  final String email;
  final String password;
  final bool admin;
  final String communityId;
  final String position;
  final String? image;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.admin,
    required this.communityId,
    required this.position,
    this.image,
  });
}
