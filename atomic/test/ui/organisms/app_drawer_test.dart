import 'package:atomic/ui/organisms/app_drawer.dart';
import 'package:entities/shared/menu.dart';
import 'package:entities/shared/visual_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppDrawer', () {
    final menu = MenuEntity(
      logo: 'https://example.com/logo.png',
      items: [
        MenuItemEntity(text: 'Home', url: '/'),
        MenuItemEntity(text: 'About', url: '/about'),
      ],
      // FIX: Use Enums instead of strings
      buttons: [
        ButtonEntity(
          text: 'Login',
          url: '/login',
          style: AppButtonStyle.filled,
          color: AppButtonColor.primary,
        ),
      ],
    );

    testWidgets('renders content correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppDrawer(menu: menu)),
        ),
      );

      // Check Header
      expect(find.byIcon(Icons.close), findsOneWidget);
      expect(find.byType(Image), findsOneWidget);

      // Check Links
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);

      // Check Buttons
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('uses full width on mobile (<768)', (tester) async {
      tester.view.physicalSize = const Size(375, 667);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppDrawer(menu: menu)),
        ),
      );

      // Measure width of the Sized Box wrapping the drawer
      final sizedBoxFinder = find.byType(SizedBox).first;
      final size = tester.getSize(sizedBoxFinder);

      expect(size.width, 375.0);

      tester.view.resetPhysicalSize();
    });

    testWidgets('uses fixed width on desktop (>=768)', (tester) async {
      tester.view.physicalSize = const Size(1024, 768);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: AppDrawer(menu: menu)),
        ),
      );

      final sizedBoxFinder = find.byType(SizedBox).first;
      final size = tester.getSize(sizedBoxFinder);

      expect(size.width, 350.0);

      tester.view.resetPhysicalSize();
    });
  });
}
