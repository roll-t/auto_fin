import 'package:auto_fin/core/config/theme/app_color_scheme.dart';
import 'package:auto_fin/features/theme/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_colors.dart';

class AppThemeColors {
  static final ThemeController _themeController = Get.find<ThemeController>();

  static bool get isDark => _themeController.themeMode.value == ThemeMode.dark;

  static AppColorScheme get primaryTheme =>
      _themeController.appColorScheme.value;

  static Color get background => primaryTheme.background;

  static Color get surface => primaryTheme.surface;

  static Color get card => primaryTheme.card;

  static Color get appBar => primaryTheme.appBar;

  static Color get text => primaryTheme.textPrimary;

  static Color get textSecondary => primaryTheme.textSecondary;

  static Color get textDisabled => primaryTheme.textDisabled;

  static Color get primary => primaryTheme.primary;

  static Color get secondary => primaryTheme.secondary;

  static Color get error => primaryTheme.error;

  static Color get icon => primaryTheme.icon;

  static Color get iconInactive => primaryTheme.iconInactive;

  static Color get divider => primaryTheme.divider;

  static Color get border => primaryTheme.border;

  static Color get highlight => primaryTheme.highlight;

  static Color get lightest => primaryTheme.lightest;

  static Color get lighter => primaryTheme.lighter;

  static Color get light => primaryTheme.light;

  static Color get dark => primaryTheme.dark;

  static Color get darker => primaryTheme.darker;

  static Color get darkest => primaryTheme.darkest;

  // Optional: giữ lại màu disabled text cứng nếu dùng ngoài theme
  static Color get disabledText => AppColors.disabledText;
}
