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

  @override
  Widget build(BuildContext context) {
    // Dimensões do sidebar
    const double collapsedWidth = 72.0;
    const double expandedWidth = 250.0;

    final width = _isHovered ? expandedWidth : collapsedWidth;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: width,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(2, 0),
            ),
          ],
        ),
        child: Column(
          children: [
            // Logo Area
            SizedBox(
              height: 80,
              child: Center(
                child: Builder(
                  builder: (context) {
                    // Logic to choose which logo to show
                    final showIcon =
                        !_isHovered && widget.menu.logoIcon != null;
                    final logoPath = showIcon
                        ? widget.menu.logoIcon!
                        : widget.menu.logo;

                    if (logoPath.isEmpty) {
                      return _isHovered
                          ? AppTextAtom.h2('UNASP')
                          : AppTextAtom.h3('U');
                    }

                    // Handle Asset vs Network
                    if (logoPath.startsWith('assets/')) {
                      return Image.asset(
                        logoPath,
                        width: _isHovered ? 120 : 40,
                        height: 40,
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) =>
                            const Icon(Icons.broken_image),
                      );
                    } else {
                      return Image.network(
                        logoPath,
                        width: _isHovered ? 120 : 40,
                        height: 40,
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) =>
                            const Icon(Icons.broken_image),
                      );
                    }
                  },
                ),
              ),
            ),

            const Divider(height: 1),

            // Menu Items
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: widget.menu.items.length,
                itemBuilder: (context, index) {
                  final item = widget.menu.items[index];
                  final icon = AppIconMapper.parse(item.icon);

                  return _SidebarItem(
                    item: item,
                    icon: icon,
                    isExpanded: _isHovered,
                  );
                },
              ),
            ),

            // Footer Buttons (Logout, Configs, etc)
            if (widget.menu.buttons.isNotEmpty) ...[
              const Divider(height: 1),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: widget.menu.buttons.map((btn) {
                    // Simplificação: usando icones para sidebar também
                    return IconButton(
                      icon: Icon(AppIconMapper.parse(btn.icon)),
                      tooltip: _isHovered ? btn.text : null,
                      onPressed: () {},
                    );
                  }).toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final MenuItemEntity item;
  final IconData? icon;
  final bool isExpanded;

  const _SidebarItem({
    required this.item,
    required this.icon,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    // Quando colapsado, mostrar só Icone centralizado.
    // Quando expandido, mostrar Icone + Texto.

    return InkWell(
      onTap: () {
        debugPrint('Navigate to ${item.url}');
      },
      hoverColor: Colors.grey.withValues(alpha: 0.05),
      child: SizedBox(
        height: 56, // Altura fixa para consistência
        child: Row(
          mainAxisAlignment: isExpanded
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: [
            // Espaçamento esquerdo se expandido
            if (isExpanded) const SizedBox(width: 24),

            Icon(icon ?? Icons.circle, size: 24, color: Colors.grey[700]),

            if (isExpanded) ...[
              const SizedBox(width: 16),
              Flexible(
                child: AppTextAtom.body(
                  item.text,
                  fontWeight: FontWeight.w500,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 24),
            ],
          ],
        ),
      ),
    );
  }
}
