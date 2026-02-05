import 'package:atomic/ui/organisms/feature_grid.dart';
import 'package:entities/shared/visual_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FeatureGrid', () {
    final items = List.generate(
      6,
      (index) => CardEntity(
        title: 'Card $index',
        subtitle: 'Subtitle $index',
        text: 'Description for card $index to test grid layout.',
        // FIX: Use Enums
        buttons: const [
          ButtonEntity(
            text: 'Action',
            url: '/',
            style: AppButtonStyle.filled,
            color: AppButtonColor.primary,
          ),
        ],
      ),
    );

    testWidgets('renders correct number of columns on Desktop (>900)', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: FeatureGrid(items: items)),
          ),
        ),
      );

      final grid = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

      expect(delegate.crossAxisCount, 3);

      tester.view.resetPhysicalSize();
    });

    testWidgets('renders correct number of columns on Tablet (600-900)', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(800, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: FeatureGrid(items: items)),
          ),
        ),
      );

      final grid = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

      expect(delegate.crossAxisCount, 2);

      tester.view.resetPhysicalSize();
    });

    testWidgets('renders correct number of columns on Mobile (<600)', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(400, 800);
      tester.view.devicePixelRatio = 1.0;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(child: FeatureGrid(items: items)),
          ),
        ),
      );

      final grid = tester.widget<GridView>(find.byType(GridView));
      final delegate =
          grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

      expect(delegate.crossAxisCount, 1);

      tester.view.resetPhysicalSize();
    });
  });
}
