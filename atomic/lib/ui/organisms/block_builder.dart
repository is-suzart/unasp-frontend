import 'package:entities/entities.dart';
import 'package:flutter/material.dart';

import '../molecules/hero_module.dart';
import '../molecules/info_card.dart';
import '../molecules/news_card.dart';

class BlockBuilder extends StatelessWidget {
  final PageBlock block;

  const BlockBuilder({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    switch (block.type) {
      case 'section':
      case 'container':
        return _buildLayout(context);
      case 'hero':
        return HeroModule(
          title: block.props.title ?? 'Hero Module',
          description: block.props.description ?? 'Hero Description',
          backgroundImage: block.props.imageUrl,
          onCtaCompressed: () => debugPrint('Hero Action!'),
        );
      case 'card':
        return InfoCard(
          title: block.props.title ?? 'Card Title',
          description: block.props.description,
          onTap: () => debugPrint('Card ${block.props.title} tapped'),
        );
      case 'news-card':
        return NewsCard(
          title: block.props.title ?? 'News Title',
          imageUrl: block.props.imageUrl,
          onTap: () => debugPrint('News ${block.props.title} tapped'),
        );
      default:
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(8),
            color: Colors.red.withOpacity(0.1),
          ),
          child: Text(
            'Unknown Block Type: ${block.type} (ID: ${block.id ?? "?"})',
          ),
        );
    }
  }

  Widget _buildLayout(BuildContext context) {
    final gap = _resolveGap(block.props.gap ?? GapSize.md);
    final layout = block.props.layout ?? LayoutType.list;

    // Cabeçalho da Seção (Título)
    Widget? sectionHeader;
    if (block.props.title != null) {
      sectionHeader = Padding(
        padding: EdgeInsets.only(bottom: gap),
        child: Text(
          block.props.title!,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
      );
    }

    Widget content;

    if (layout == LayoutType.list) {
      // Lista Vertical (Column)
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: block.children.map((child) {
          return Padding(
            padding: EdgeInsets.only(bottom: gap),
            child: BlockBuilder(block: child),
          );
        }).toList(),
      );
    } else if (layout == LayoutType.grid) {
      // Grid Responsivo
      content = LayoutBuilder(
        builder: (context, constraints) {
          // Mobile First: Se largura < 600px, força 1 coluna
          final isMobile = constraints.maxWidth < 600;
          final columns = isMobile ? 1 : (block.props.columns ?? 2);

          // Calcula a largura de cada item
          // totalWidth - (espacos * (colunas - 1)) / colunas
          final itemWidth =
              (constraints.maxWidth - (gap * (columns - 1))) / columns;

          return Wrap(
            spacing: gap,
            runSpacing: gap,
            children: block.children.map((child) {
              return SizedBox(
                width: itemWidth,
                child: BlockBuilder(block: child),
              );
            }).toList(),
          );
        },
      );
    } else {
      // Flex Horizontal (Row com scroll horizontal se necessário ou Wrap)
      content = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: block.children.map((child) {
            return Padding(
              padding: EdgeInsets.only(right: gap),
              child: SizedBox(
                width: 300, // Largura fixa para itens horizontais
                child: BlockBuilder(block: child),
              ),
            );
          }).toList(),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.only(bottom: gap * 2), // Espaço externo da seção
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [if (sectionHeader != null) sectionHeader, content],
      ),
    );
  }

  double _resolveGap(GapSize gap) {
    switch (gap) {
      case GapSize.none:
        return 0;
      case GapSize.sm:
        return 8;
      case GapSize.md:
        return 16;
      case GapSize.lg:
        return 24;
      case GapSize.xl:
        return 32;
    }
  }
}
