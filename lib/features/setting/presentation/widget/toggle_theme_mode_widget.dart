import 'package:auto_fin/features/theme/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToggleThemeModeWidget extends GetView<ThemeController> {
  const ToggleThemeModeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Switch(
        value: controller.themeMode.value == ThemeMode.dark,
        onChanged: (value) => controller.toggleTheme(),
      ),
    );
  }
}
