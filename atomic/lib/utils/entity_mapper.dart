import 'package:atomic/ui/atoms/app_button_atom.dart' as atom;
import 'package:entities/shared/visual_components.dart' as entity;

class EntityMapper {
  static atom.AppButtonStyle mapButtonStyle(entity.AppButtonStyle style) {
    switch (style) {
      case entity.AppButtonStyle.filled:
        return atom.AppButtonStyle.filled;
      case entity.AppButtonStyle.outlined:
        return atom.AppButtonStyle.outlined;
    }
  }

  static atom.AppButtonColor mapButtonColor(entity.AppButtonColor color) {
    switch (color) {
      case entity.AppButtonColor.primary:
        return atom.AppButtonColor.primary;
      case entity.AppButtonColor.secondary:
        return atom.AppButtonColor.secondary;
      case entity.AppButtonColor.danger:
        return atom.AppButtonColor.danger;
      case entity.AppButtonColor.warning:
        return atom.AppButtonColor.warning;
      case entity.AppButtonColor.neutral:
        return atom.AppButtonColor.neutral;
      case entity.AppButtonColor.mint:
        return atom.AppButtonColor.mint;
      case entity.AppButtonColor.sunflower:
        return atom.AppButtonColor.sunflower;
      case entity.AppButtonColor.periwinkle:
        return atom.AppButtonColor.periwinkle;
      case entity.AppButtonColor.coral:
        return atom.AppButtonColor.coral;
    }
  }
}
