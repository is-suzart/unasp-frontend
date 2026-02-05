import 'package:atomic/ui/organisms/app_drawer.dart';
import 'package:atomic/ui/organisms/app_header.dart';
import 'package:atomic/ui/organisms/app_sidebar.dart';
import 'package:entities/shared/menu.dart';
import 'package:entities/shared/visual_components.dart';
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

// Mock Menu Data
final mockMenu = MenuEntity(
  logo: 'assets/images/logo.png',
  logoIcon:
      'assets/images/logo_icon.png', // Assuming this asset exists or will serve as placeholder
  items: [
    const MenuItemEntity(text: 'Home', url: '/home', icon: 'home'),
    const MenuItemEntity(text: 'Academic', url: '/academic', icon: 'school'),
    const MenuItemEntity(
      text: 'Financial',
      url: '/financial',
      icon: 'attach_money',
    ),
    const MenuItemEntity(text: 'Settings', url: '/settings', icon: 'settings'),
  ],
  buttons: [
    const ButtonEntity(
      text: 'Logout',
      url: '/logout',
      style: AppButtonStyle.outlined,
      color: AppButtonColor.primary,
      icon: 'logout',
    ),
  ],
);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Usando LayoutBuilder para responsividade
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth > 1024;
        final scrollSignal = signal(
          false,
        ); // Local signal para header scroll effect

        if (isDesktop) {
          // Desktop Layout: Sidebar + Header (simplificado ou sem?) + Content
          return Scaffold(
            backgroundColor: Colors.grey[50],
            body: Row(
              children: [
                // Always visible Sidebar
                AppSidebar(menu: mockMenu),

                // Content Area
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.notifications),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 16),
                            const CircleAvatar(child: Icon(Icons.person)),
                          ],
                        ),
                      ),

                      // Page Content
                      Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Bem-vindo ao Portal UNASP',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text(
                                'Selecione uma opção no menu lateral.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          // Mobile Layout: Header + Drawer + Content
          return Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: AppHeader(
              menu: mockMenu,
              isScrolled: scrollSignal,
              onMenuPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
            drawer: AppDrawer(menu: mockMenu),
            body: const Center(child: Text('Mobile Content Placeholder')),
          );
        }
      },
    );
  }
}
