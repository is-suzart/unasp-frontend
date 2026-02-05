import 'package:atomic/ui/atoms/app_button_atom.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppButtonAtom', () {
    testWidgets('renders label and icon correctly', (tester) async {
      const label = 'Click Me';
      const icon = Icons.add;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButtonAtom(
              label: label,
              icon: icon,
              style: AppButtonStyle.filled,
              color: AppButtonColor.primary,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.text(label), findsOneWidget);
      expect(find.byIcon(icon), findsOneWidget);
    });

    testWidgets('uses filled style correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButtonAtom(
              label: 'Filled',
              style: AppButtonStyle.filled,
              color: AppButtonColor.primary,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(OutlinedButton), findsNothing);
    });

    testWidgets('uses outlined style correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButtonAtom(
              label: 'Outlined',
              style: AppButtonStyle.outlined,
              color: AppButtonColor.primary,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
      expect(find.byType(ElevatedButton), findsNothing);
    });

    testWidgets('triggers onPressed when clicked', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButtonAtom(
              label: 'Tap Me',
              style: AppButtonStyle.filled,
              color: AppButtonColor.primary,
              onPressed: () => pressed = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppButtonAtom));
      await tester.pump();

      expect(pressed, isTrue);
    });

    testWidgets('uses AppTextAtom.button inside', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButtonAtom(
              label: 'Inner Text',
              style: AppButtonStyle.filled,
              color: AppButtonColor.primary,
              onPressed: () {},
            ),
          ),
        ),
      );

      // We expect to find an AppTextAtom (which builds a Text widget)
      // Since AppTextAtom is a StatelessWidget, optimizing compilers might inline it in trees sometimes,
      // but find.byType(Text) should work and we can check style if we really want strictness.
      // But we can check if the Text widget has the correct "button" font size/weight implicitly.

      final textFinder = find.text('Inner Text');
      final textWidget = tester.widget<Text>(textFinder);

      expect(textWidget.style?.fontSize, 14);
      expect(textWidget.style?.fontWeight, FontWeight.bold);
    });
  });
}
