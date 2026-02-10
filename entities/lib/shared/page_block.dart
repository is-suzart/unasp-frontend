enum LayoutType {
  grid,
  flex, // Equivalente a Row
  list, // Equivalente a Column
}

enum GapSize {
  none,
  sm, // 8
  md, // 16
  lg, // 24
  xl, // 32
}

class PageBlockProps {
  final LayoutType? layout;
  final int? columns;
  final GapSize? gap;
  final String? title;
  final String? description;
  final String? variant; // primary, secondary, outlined
  final String? imageUrl;
  final Map<String, dynamic> extras;

  const PageBlockProps({
    this.layout,
    this.columns,
    this.gap,
    this.title,
    this.description,
    this.variant,
    this.imageUrl,
    this.extras = const {},
  });

  factory PageBlockProps.fromJson(Map<String, dynamic> json) {
    return PageBlockProps(
      layout: json['layout'] != null
          ? LayoutType.values.firstWhere(
              (e) => e.name == json['layout'],
              orElse: () => LayoutType.list,
            )
          : null,
      columns: json['columns'],
      gap: json['gap'] != null
          ? GapSize.values.firstWhere(
              (e) => e.name == json['gap'],
              orElse: () => GapSize.md,
            )
          : null,
      title: json['title'],
      description: json['description'],
      variant: json['variant'],
      imageUrl: json['imageUrl'],
      extras: Map<String, dynamic>.from(json)
        ..removeWhere(
          (key, value) => [
            'layout',
            'columns',
            'gap',
            'title',
            'description',
            'variant',
            'imageUrl',
          ].contains(key),
        ),
    );
  }
}

class PageBlock {
  final String? id;
  final String type;
  final PageBlockProps props;
  final List<PageBlock> children;

  const PageBlock({
    this.id,
    required this.type,
    required this.props,
    this.children = const [],
  });

  factory PageBlock.fromJson(Map<String, dynamic> json) {
    return PageBlock(
      id: json['id'],
      type: json['type'] ?? 'unknown',
      props: PageBlockProps.fromJson(json['props'] ?? {}),
      children:
          (json['children'] as List<dynamic>?)
              ?.map((e) => PageBlock.fromJson(e))
              .toList() ??
          [],
    );
  }
}
