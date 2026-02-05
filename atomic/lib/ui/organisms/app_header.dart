import 'package:atomic/ui/atoms/app_button_atom.dart' as atom;
import 'package:atomic/ui/atoms/app_nav_link_atom.dart';
import 'package:atomic/utils/entity_mapper.dart';
import 'package:atomic/utils/icon_mapper.dart'; // Import Mapper
import 'package:entities/shared/menu.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final MenuEntity menu;
  final Signal<bool> isScrolled;
  final VoidCallback? onMenuPressed;

  const AppHeader({
    super.key,
    required this.menu,
    required this.isScrolled,
    this.onMenuPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    // Reactive state watch
    final scrolled = isScrolled.watch(context);
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width > 1024;

    final backgroundColor = scrolled
        ? theme.colorScheme.surface
        : Colors.transparent;

    final contentColor = scrolled ? theme.colorScheme.onSurface : Colors.white;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: preferredSize.height,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: scrolled
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: isDesktop
            ? Stack(
                alignment: Alignment.center,
                children: [
                  // LEFT: LOGO
                  Positioned(
                    left: 0,
                    child: menu.logo.isNotEmpty
                        ? Image.network(
                            menu.logo,
                            height: 40,
                            errorBuilder: (ctx, err, stack) =>
                                Icon(Icons.broken_image, color: contentColor),
                          )
                        : Text(
                            'UNASP',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: contentColor,
                            ),
                          ),
                  ),

                  // CENTER: LINKS
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: menu.items.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: AppNavLinkAtom(
                          label: item.text,
                          isActive: item.text == 'Ministérios', // Demo Active
                          onTap: () => debugPrint('Navigate to ${item.url}'),
                          textColor: contentColor,
                        ),
                      );
                    }).toList(),
                  ),

                  // RIGHT: BUTTONS
                  Positioned(
                    right: 0,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: menu.buttons.map((btn) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: atom.AppButtonAtom(
                            label: btn.text,
                            // Use Centralized Mapper
                            icon: AppIconMapper.parse(btn.icon),
                            style: EntityMapper.mapButtonStyle(btn.style),
                            color: EntityMapper.mapButtonColor(btn.color),
                            onPressed: () => debugPrint('Action ${btn.url}'),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  // Logo
                  if (menu.logo.isNotEmpty)
                    Image.network(
                      menu.logo,
                      height: 40,
                      errorBuilder: (ctx, err, stack) =>
                          Icon(Icons.broken_image, color: contentColor),
                    )
                  else
                    Text(
                      'UNASP',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: contentColor,
                      ),
                    ),
                  const Spacer(),
                  // Hamburger
                  IconButton(
                    onPressed: onMenuPressed,
                    icon: Icon(Icons.menu, color: contentColor),
                  ),
                ],
              ),
      ),
    );
  }
}
