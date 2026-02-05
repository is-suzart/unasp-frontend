import 'package:atomic/ui/organisms/app_footer.dart';
import 'package:entities/shared/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppFooter', () {
    final menu = MenuEntity(
      logo: 'https://example.com/logo.png',
      items: [
        MenuItemEntity(text: 'Inst', url: '/inst'),
        MenuItemEntity(text: 'Min', url: '/min'),
        MenuItemEntity(text: 'Sobre', url: '/sobre'),
        MenuItemEntity(text: 'Enc', url: '/enc'),
      ],
      buttons: [],
    );

    testWidgets('renders 4 columns on desktop (>900)', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: AppFooter(menu: menu)),
          ),
        ),
      );

      // Check content
      expect(find.text('UNASP'), findsOneWidget); // Fallback title or image
      expect(find.text('Institucional'), findsOneWidget);
      expect(find.text('Ministérios'), findsOneWidget);
      expect(find.text('Contato'), findsOneWidget);

      // Verify Row layout by checking position
      // Simple check: Columns should be roughly horizontal.
      // Detailed: Check if "Institucional" is to the right of "UNASP".
      final center1 = tester.getCenter(find.text('Institucional'));
      final centerContact = tester.getCenter(find.text('Contato'));

      expect(centerContact.dx > center1.dx, isTrue);

      tester.view.resetPhysicalSize();
    });

    testWidgets('renders stacked columns on mobile (<900)', (tester) async {
      tester.view.physicalSize = const Size(600, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: AppFooter(menu: menu)),
          ),
        ),
      );

      // Check content
      expect(find.text('Contato'), findsOneWidget);

      // Verify Column layout
      // "Contato" should be below "Institucional"
      final center1 = tester.getCenter(find.text('Institucional'));
      final centerContact = tester.getCenter(find.text('Contato'));

      expect(centerContact.dy > center1.dy, isTrue);

      tester.view.resetPhysicalSize();
    });
  });
}
