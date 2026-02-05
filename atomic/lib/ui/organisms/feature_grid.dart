import 'package:atomic/ui/molecules/app_visual_component.dart';
import 'package:entities/shared/visual_components.dart';
import 'package:flutter/material.dart';

class FeatureGrid extends StatelessWidget {
  final List<VisualComponent> items;

  const FeatureGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;

              int crossAxisCount;
              if (width > 900) {
                crossAxisCount = 3; // Desktop
              } else if (width > 600) {
                crossAxisCount = 2; // Tablet
              } else {
                crossAxisCount = 1; // Mobile
              }

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  // Adjust childAspectRatio as needed.
                  // 0.8 is a reasonable starting point for cards with image + title + text
                  childAspectRatio: 0.8,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return AppVisualComponent(
                    visual: items[index],
                    isFullWidth: false,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
