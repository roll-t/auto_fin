import 'package:auto_fin/core/config/const/app_content.dart';
import 'package:auto_fin/core/config/enum.dart';
import 'package:auto_fin/core/config/theme/app_color_scheme.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_fin/features/theme/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectPrimaryThemeWidget extends GetView<ThemeController> {
  final double? width;
  const SelectPrimaryThemeWidget({super.key, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: DropdownButton<int>(
        value: controller.currentThemeIndex.value.index,
        items:
            AppColorTheme.values.map((theme) {
              return DropdownMenuItem(
                value: theme.index,
                child: TextWidget(
                  text: "${AppContent.theme.tr} ${theme.index + 1}",
                  transform: TextTransformType.capitalizeWords,
                ),
              );
            }).toList(),
        onChanged: (selectedIndex) {
          if (selectedIndex != null) {
            final selectedTheme = AppColorTheme.values[selectedIndex];
            controller.changePrimaryTheme(selectedTheme);
          }
        },
        hint: const TextWidget(text: AppContent.selectThem),
        isExpanded: width != null,
      ),
    );
  }
}
