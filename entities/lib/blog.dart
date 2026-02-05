import 'user.dart';

class BlogEntity {
  final String id;
  final String title;
  final String route;

  /// Stores the content of the blog, intended to be HTML or JSON Delta from a rich text editor.
  final String content;
  final UserEntity author;

  const BlogEntity({
    required this.id,
    required this.title,
    required this.route,
    required this.content,
    required this.author,
  });
}
