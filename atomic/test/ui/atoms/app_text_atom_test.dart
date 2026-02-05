import 'package:atomic/ui/atoms/app_text_atom.dart';
import 'package:entities/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppTextAtom', () {
    testWidgets('renders correct text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: AppTextAtom.body('Hello World'))),
      );

      expect(find.text('Hello World'), findsOneWidget);
    });

    testWidgets('h1 constructor uses correct style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: AppTextAtom.h1('Title'))),
      );

      final textFinder = find.text('Title');
      final textWidget = tester.widget<Text>(textFinder);

      expect(textWidget.style?.fontFamily, UnaspFonts.title); // Poppins
      expect(textWidget.style?.fontWeight, FontWeight.bold);
      expect(textWidget.style?.fontSize, 32);
    });

    testWidgets('h2 constructor uses correct style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: AppTextAtom.h2('Subtitle'))),
      );

      final textFinder = find.text('Subtitle');
      final textWidget = tester.widget<Text>(textFinder);

      expect(textWidget.style?.fontFamily, UnaspFonts.title); // Poppins
      expect(textWidget.style?.fontWeight, FontWeight.w600);
      expect(textWidget.style?.fontSize, 24);
    });

    testWidgets('script constructor uses correct style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: AppTextAtom.script('Fancy Text'))),
      );

      final textFinder = find.text('Fancy Text');
      final textWidget = tester.widget<Text>(textFinder);

      expect(textWidget.style?.fontFamily, UnaspFonts.script); // Oleo Script
      expect(textWidget.style?.fontSize, 24);
    });

    testWidgets('body constructor uses correct style', (tester) async {
      await tester.pumpWidget(
        MaterialApp(home: Scaffold(body: AppTextAtom.body('Content'))),
      );

      final textFinder = find.text('Content');
      final textWidget = tester.widget<Text>(textFinder);

      expect(textWidget.style?.fontFamily, UnaspFonts.text); // Roboto Slab
      expect(textWidget.style?.fontSize, 16);
    });
  });
}
