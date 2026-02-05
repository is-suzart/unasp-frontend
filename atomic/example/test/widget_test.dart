import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart'; // Ensure this matches the package name in pubspec.yaml of example

void main() {
  testWidgets('ShowcaseApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ShowcaseApp());

    // Verify that the title text is present.
    expect(find.text('Bem-vindo à UNASP'), findsOneWidget);

    // Check for some other elements to ensure layout loaded
    expect(find.byIcon(Icons.school), findsOneWidget);
    expect(find.text('Nossos Destaques'), findsOneWidget);
  });
}
