import 'package:atomic/ui/atoms/app_button_atom.dart' as atom;
import 'package:atomic/ui/atoms/app_text_atom.dart';
import 'package:atomic/utils/entity_mapper.dart';
import 'package:atomic/utils/icon_mapper.dart'; // Import Mapper
import 'package:entities/shared/visual_components.dart' as entity;
import 'package:flutter/material.dart';

class AppVisualComponent extends StatelessWidget {
  final entity.VisualComponent visual;
  final bool isFullWidth;

  const AppVisualComponent({
    super.key,
    required this.visual,
    this.isFullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    // Background Logic
    final decoration = _buildDecoration();

    return Container(
      width: isFullWidth ? double.infinity : null,
      constraints: isFullWidth ? const BoxConstraints(minHeight: 500) : null,
      decoration: decoration,
      clipBehavior: isFullWidth ? Clip.none : Clip.antiAlias,
      child: _buildContent(context),
    );
  }

  BoxDecoration _buildDecoration() {
    DecorationImage? image;
    if (visual.backgroundImage != null && visual.backgroundImage!.isNotEmpty) {
      image = DecorationImage(
        image: NetworkImage(visual.backgroundImage!),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withValues(alpha: 0.5),
          BlendMode.darken,
        ),
      );
    }

    final bgColor = visual.backgroundColor ?? Colors.white;
    final borderRadius = isFullWidth ? null : BorderRadius.circular(32);
    final boxShadow = isFullWidth
        ? null
        : [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ];

    return BoxDecoration(
      color: bgColor,
      image: image,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
    );
  }

  Widget _buildContent(BuildContext context) {
    TextAlign textAlign;
    CrossAxisAlignment crossAlign;

    switch (visual.alignment) {
      case entity.VisualAlignment.left:
        crossAlign = CrossAxisAlignment.start;
        textAlign = TextAlign.start;
        break;
      case entity.VisualAlignment.center:
        crossAlign = CrossAxisAlignment.center;
        textAlign = TextAlign.center;
        break;
      case entity.VisualAlignment.right:
        crossAlign = CrossAxisAlignment.end;
        textAlign = TextAlign.end;
        break;
    }

    final textColor = visual.backgroundImage != null
        ? Colors.white
        : Colors.black;
    final subtitleColor = visual.backgroundImage != null
        ? Colors.amber
        : Colors.grey;

    final contentColumn = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAlign,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (visual.subtitle.isNotEmpty) ...[
          AppTextAtom.script(
            visual.subtitle,
            color: subtitleColor,
            textAlign: textAlign,
            fontSize: 24,
          ),
          const SizedBox(height: 8),
        ],

        isFullWidth
            ? AppTextAtom.h1(
                visual.title,
                color: textColor,
                textAlign: textAlign,
              )
            : AppTextAtom.h2(
                visual.title,
                color: textColor,
                textAlign: textAlign,
              ),

        const SizedBox(height: 16),

        if (visual.text != null) ...[
          const SizedBox(height: 16),
          AppTextAtom.body(
            visual.text!,
            color: textColor.withValues(alpha: 0.9),
            textAlign: textAlign,
          ),
        ],
        if (visual.buttons.isNotEmpty) ...[
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: _wrapAlignment(visual.alignment),
            children: visual.buttons.map((btn) {
              return atom.AppButtonAtom(
                label: btn.text,
                // Use Centralized Mapper
                icon: AppIconMapper.parse(btn.icon),
                style: EntityMapper.mapButtonStyle(btn.style),
                color: EntityMapper.mapButtonColor(btn.color),
                onPressed: () {
                  debugPrint('Navigate to ${btn.url}');
                },
              );
            }).toList(),
          ),
        ],
      ],
    );

    const padding = EdgeInsets.all(32.0);

    if (visual.alignment == entity.VisualAlignment.center) {
      return Center(
        child: Padding(padding: padding, child: contentColumn),
      );
    } else {
      return Padding(
        padding: padding,
        child: Row(
          children: [
            if (visual.alignment == entity.VisualAlignment.right)
              const Spacer(),
            Expanded(flex: 2, child: contentColumn),
            if (visual.alignment == entity.VisualAlignment.left) const Spacer(),
          ],
        ),
      );
    }
  }

  WrapAlignment _wrapAlignment(entity.VisualAlignment align) {
    switch (align) {
      case entity.VisualAlignment.left:
        return WrapAlignment.start;
      case entity.VisualAlignment.center:
        return WrapAlignment.center;
      case entity.VisualAlignment.right:
        return WrapAlignment.end;
    }
  }
}
