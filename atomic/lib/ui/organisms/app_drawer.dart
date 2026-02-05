import 'package:atomic/ui/atoms/app_button_atom.dart' as atom;
import 'package:atomic/ui/atoms/app_nav_link_atom.dart';
import 'package:atomic/ui/atoms/app_text_atom.dart';
import 'package:atomic/utils/entity_mapper.dart';
import 'package:atomic/utils/icon_mapper.dart'; // Import Mapper
import 'package:entities/shared/menu.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final MenuEntity menu;

  const AppDrawer({super.key, required this.menu});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 768;

    final drawerWidth = isMobile ? screenWidth : 350.0;

    return SizedBox(
      width: drawerWidth,
      child: Drawer(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // HEADER
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 16.0,
                ),
                child: Row(
                  children: [
                    if (menu.logo.isNotEmpty)
                      Image.network(
                        menu.logo,
                        height: 32,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                      )
                    else
                      AppTextAtom.h2('UNASP'),

                    const Spacer(),

                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).pop(),
                      tooltip: 'Close Menu',
                    ),
                  ],
                ),
              ),

              const Divider(),

              // BODY: LINKS
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  itemCount: menu.items.length,
                  itemBuilder: (context, index) {
                    final item = menu.items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: AppNavLinkAtom(
                        label: item.text,
                        icon: AppIconMapper.parse(item.icon),
                        isActive: false,
                        onTap: () {
                          debugPrint('Navigate to ${item.url}');
                          Navigator.of(context).pop();
                        },
                      ),
                    );
                  },
                ),
              ),

              // FOOTER: BUTTONS
              if (menu.buttons.isNotEmpty) ...[
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: menu.buttons.map((btn) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: atom.AppButtonAtom(
                          label: btn.text,
                          // Use Centralized Mapper
                          icon: AppIconMapper.parse(btn.icon),
                          style: EntityMapper.mapButtonStyle(btn.style),
                          color: EntityMapper.mapButtonColor(btn.color),
                          onPressed: () {
                            debugPrint('Action ${btn.url}');
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
