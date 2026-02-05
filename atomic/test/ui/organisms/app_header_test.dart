import 'package:atomic/ui/organisms/app_header.dart';
import 'package:entities/shared/menu.dart';
import 'package:entities/shared/visual_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:signals_flutter/signals_flutter.dart';

void main() {
  group('AppHeader', () {
    final menu = MenuEntity(
      logo: 'https://example.com/logo.png',
      items: [
        MenuItemEntity(text: 'Home', url: '/'),
        MenuItemEntity(text: 'About', url: '/about'),
      ],
      buttons: [
        ButtonEntity(
          text: 'Login',
          url: '/login',
          style: AppButtonStyle.filled,
          color: AppButtonColor.primary,
        ),
      ],
    );

    testWidgets('renders desktop layout correctly (>768)', (tester) async {
      final isScrolled = signal(false);
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppHeader(menu: menu, isScrolled: isScrolled),
          ),
        ),
      );

      // Check Nav Links & Buttons
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      // Check No Hamburger
      expect(find.byIcon(Icons.menu), findsNothing);

      tester.view.resetPhysicalSize();
    });

    testWidgets('renders mobile layout correctly (<768)', (tester) async {
      final isScrolled = signal(false);
      // Set small screen size
      tester.view.physicalSize = const Size(375, 667);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppHeader(
              menu: menu,
              isScrolled: isScrolled,
              onMenuPressed: () {},
            ),
          ),
        ),
      );

      // Nav Links & Buttons should be hidden
      expect(find.text('Home'), findsNothing);
      expect(find.text('Login'), findsNothing);

      // Hamburger should be visible
      expect(find.byIcon(Icons.menu), findsOneWidget);

      tester.view.resetPhysicalSize();
    });

    testWidgets('triggers onMenuPressed callback', (tester) async {
      final isScrolled = signal(false);
      var pressed = false;

      tester.view.physicalSize = const Size(375, 667);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppHeader(
              menu: menu,
              isScrolled: isScrolled,
              onMenuPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.menu));
      expect(pressed, isTrue);

      tester.view.resetPhysicalSize();
    });
  });
}
