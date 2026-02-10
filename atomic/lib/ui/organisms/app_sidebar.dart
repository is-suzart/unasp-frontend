import 'package:atomic/ui/atoms/app_text_atom.dart';
import 'package:atomic/utils/icon_mapper.dart';
import 'package:entities/shared/menu.dart';
import 'package:flutter/material.dart';

class AppSidebar extends StatefulWidget {
  final MenuEntity menu;

  const AppSidebar({super.key, required this.menu});

  @override
  State<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar> {
  bool _isHovered = false;
  int _selectedIndex = 0; // Estado visual local para demonstração

  @override
  Widget build(BuildContext context) {
    // Dimensões refinadas para um look mais premium
    const double collapsedWidth = 88.0;
    const double expandedWidth = 280.0;

    final width = _isHovered ? expandedWidth : collapsedWidth;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        width: width,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            right: BorderSide(
              color: Colors.grey.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 20,
              offset: const Offset(4, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            // Logo Branding Area
            Container(
              height: 100,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: _isHovered ? 24 : 0),
              child: _LogoWidget(menu: widget.menu, showIconOnly: !_isHovered),
            ),

            const SizedBox(height: 16),

            // Navigation Items
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets
                    .zero, // Removed padding to prevent overflow during resize
                itemCount: widget.menu.items.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final item = widget.menu.items[index];
                  final isSelected = index == _selectedIndex;
                  final icon = AppIconMapper.parse(item.icon);

                  return _SidebarItem(
                    text: item.text,
                    icon: icon,
                    isSelected: isSelected,
                    isExpanded: _isHovered,
                    onTap: () => setState(() => _selectedIndex = index),
                  );
                },
              ),
            ),

            // Footer Actions
            if (widget.menu.buttons.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: widget.menu.buttons.map((btn) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: _SidebarItem(
                        text: btn.text,
                        icon: AppIconMapper.parse(btn.icon),
                        isExpanded: _isHovered,
                        isSelected: false,
                        isDestructive: true,
                        onTap: () {},
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _LogoWidget extends StatelessWidget {
  final MenuEntity menu;
  final bool showIconOnly;

  const _LogoWidget({required this.menu, required this.showIconOnly});

  @override
  Widget build(BuildContext context) {
    // Smooth transition for logo alignment/padding
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      // Only apply padding when we have space to breathe
      padding: EdgeInsets.symmetric(horizontal: showIconOnly ? 0 : 24),
      curve: Curves.easeInOut,
      alignment: Alignment.center,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    if (showIconOnly && menu.logoIcon != null) {
      return _buildImage(menu.logoIcon!, 40);
    }

    if (menu.logo.isNotEmpty) {
      // Use OverflowBox to prevent crash if width is temporarily too small during animation
      return OverflowBox(
        maxWidth: 160,
        maxHeight: 50,
        alignment: Alignment.centerLeft,
        child: _buildImage(menu.logo, showIconOnly ? 40 : 140),
      );
    }

    return AppTextAtom.h3(showIconOnly ? 'U' : 'UNASP');
  }

  Widget _buildImage(String path, double width) {
    if (path.startsWith('assets/')) {
      return Image.asset(
        path,
        width: width,
        height: 40,
        fit: BoxFit.contain,
        errorBuilder: (_, _, _) => const Icon(Icons.broken_image),
      );
    }
    return Image.network(
      path,
      width: width,
      height: 40,
      fit: BoxFit.contain,
      errorBuilder: (_, _, _) => const Icon(Icons.broken_image),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String text;
  final IconData? icon;
  final bool isSelected;
  final bool isExpanded;
  final bool isDestructive;
  final VoidCallback onTap;

  const _SidebarItem({
    required this.text,
    required this.icon,
    required this.isSelected,
    required this.isExpanded,
    this.isDestructive = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Cores baseadas no estilo 'Premium'
    // Usando a cor primária do tema Atomic
    final theme = Theme.of(context);
    final brandColor = theme.colorScheme.primary;

    final activeBg = brandColor.withValues(alpha: 0.1);
    final activeContent = brandColor;

    // Fallback para conteúdo inativo se não definido no tema
    // Usando onSurface com opacidade para consistência com o tema
    final inactiveContent = theme.colorScheme.onSurface.withValues(alpha: 0.6);
    final destructiveColor = theme.colorScheme.error;

    final contentColor = isDestructive
        ? destructiveColor
        : (isSelected ? activeContent : inactiveContent);

    // Padding dinâmico: menor quando colapsado para maximizar espaço
    // maior quando expandido para estética.
    // Usamos margin horizontal para criar o efeito "flutuante" do item.
    final horizontalMargin = 12.0;

    // Padding interno do item
    final internalPadding = isExpanded ? 16.0 : 0.0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 52,
        margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
        padding: EdgeInsets.symmetric(horizontal: internalPadding),
        decoration: BoxDecoration(
          color: isSelected ? activeBg : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics:
              const NeverScrollableScrollPhysics(), // Prevent user scrolling
          child: SizedBox(
            // Força a largura mínima para centralização quando colapsado
            width: isExpanded ? null : (88.0 - (horizontalMargin * 2)),
            height: 52,
            child: Row(
              mainAxisSize: MainAxisSize.min, // Shrink to fit content
              mainAxisAlignment: isExpanded
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                Icon(
                  icon ?? Icons.circle_outlined,
                  size: 24,
                  color: contentColor,
                ),

                if (isExpanded) ...[
                  const SizedBox(width: 12),
                  // Text inside constrained container
                  AppTextAtom.nav(
                    text,
                    color: contentColor,
                    isActive: isSelected,
                    textAlign: TextAlign.left,
                  ),
                  if (isSelected)
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: activeContent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
