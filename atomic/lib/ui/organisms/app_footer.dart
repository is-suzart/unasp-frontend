import 'package:atomic/ui/atoms/app_nav_link_atom.dart';
import 'package:atomic/ui/atoms/app_text_atom.dart';
import 'package:atomic/utils/icon_mapper.dart'; // Import Mapper
import 'package:entities/shared/visual_components.dart' as entity;
import 'package:entities/shared/menu.dart';
import 'package:flutter/material.dart';

class AppFooter extends StatelessWidget {
  final MenuEntity menu;
  final String description;
  final String email;
  final List<entity.ButtonEntity> socialIcons;
  final List<MenuItemEntity>? column2Links;
  final List<MenuItemEntity>? column3Links;

  const AppFooter({
    super.key,
    required this.menu,
    this.description = 'Transformando vidas através da educação e da fé.',
    this.email = 'contato@unasp.br',
    this.socialIcons = const [],
    this.column2Links,
    this.column3Links,
  });

  @override
  Widget build(BuildContext context) {
    // Theme Awareness
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDesktop = MediaQuery.of(context).size.width > 900;

    // Use Theme colors instead of hardcoded
    // Background: Inverse Surface (often dark) or generic dark color from palette
    // Requirements said "Pure Black / Dark Charcoal".
    // If Theme doesn't have it, we should suggest adding to Theme extension.
    // For now, assuming standard Material 3 Dark mapping or fallback relative to theme.
    // If light theme: SurfaceTint or InverseSurface.
    final backgroundColor = colorScheme.brightness == Brightness.light
        ? const Color(0xFF121212) // Always dark footer requested
        : colorScheme.surface; // Already dark

    final textColor = Colors.white70;
    const titleColor = Colors.white;

    final content = isDesktop
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildColumn1(titleColor, textColor, context)),
              const SizedBox(width: 32),
              Expanded(child: _buildColumn2(titleColor, textColor)),
              const SizedBox(width: 32),
              Expanded(child: _buildColumn3(titleColor, textColor)),
              const SizedBox(width: 32),
              Expanded(child: _buildColumn4(titleColor, textColor, context)),
            ],
          )
        : Column(
            children: [
              _buildColumn1(titleColor, textColor, context),
              const SizedBox(height: 32),
              _buildColumn2(titleColor, textColor),
              const SizedBox(height: 32),
              _buildColumn3(titleColor, textColor),
              const SizedBox(height: 32),
              _buildColumn4(titleColor, textColor, context),
            ],
          );

    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: content,
        ),
      ),
    );
  }

  Widget _buildColumn1(
    Color titleColor,
    Color textColor,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (menu.logo.isNotEmpty)
          Image.network(
            menu.logo,
            height: 40,
            errorBuilder: (_, _, _) =>
                Icon(Icons.broken_image, color: textColor),
          )
        else
          AppTextAtom.h2('UNASP', color: titleColor),
        const SizedBox(height: 16),
        AppTextAtom.body(description, color: textColor),
      ],
    );
  }

  Widget _buildColumn2(Color titleColor, Color textColor) {
    final links = column2Links ?? menu.items.take(3).toList();
    return _buildLinkColumn('Institucional', links, titleColor, textColor);
  }

  Widget _buildColumn3(Color titleColor, Color textColor) {
    final links = column3Links ?? menu.items.skip(3).toList();
    return _buildLinkColumn('Ministérios', links, titleColor, textColor);
  }

  Widget _buildLinkColumn(
    String title,
    List<MenuItemEntity> links,
    Color titleColor,
    Color textColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextAtom.h5(title, color: titleColor),
        const SizedBox(height: 16),
        ...links.map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: AppNavLinkAtom(
              label: link.text,
              isActive: false,
              // Theme override wrapping not implemented in Atom,
              // relying on parent contrast or modifications in future.
              onTap: () {},
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildColumn4(
    Color titleColor,
    Color textColor,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextAtom.h5('Contato', color: titleColor),
        const SizedBox(height: 16),
        AppTextAtom.body(email, color: textColor),
        const SizedBox(height: 16),
        Row(
          children: socialIcons
              .map(
                (btn) => IconButton(
                  // Use Centralized Mapper
                  icon: Icon(AppIconMapper.parse(btn.icon)),
                  color: titleColor,
                  onPressed: () {},
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
