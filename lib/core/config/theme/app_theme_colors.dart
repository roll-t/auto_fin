import 'package:auto_fin/core/config/theme/app_color_scheme.dart';
import 'package:auto_fin/features/theme/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_colors.dart';

class AppThemeColors {
  // Thêm một kiểm tra để tránh tạo lại controller nếu nó đã tồn tại
  static final ThemeController _themeController = Get.find<ThemeController>();

  // Check if the current theme is dark
  static bool get isDark => _themeController.themeMode.value == ThemeMode.dark;

  // Get the current primary theme (AppColorScheme)
  static AppColorScheme get primaryTheme =>
      _themeController.appColorScheme.value;

  // Background color based on the theme (light or dark)
  static Color get background => primaryTheme.background;

  // Text primary color based on the theme
  static Color get text => primaryTheme.textPrimary;

  // Text secondary color (for less important text)
  static Color get textSecondary => primaryTheme.textSecondary;

  // Disabled text color
  static Color get disabledText => AppColors.disabledText;

  // Primary color for app elements like buttons, icons, etc.
  static Color get primary => primaryTheme.primary;

  // Secondary color for accenting elements in the app
  static Color get secondary => primaryTheme.secondary;

  // Error color used for error messages and indicators
  static Color get error => primaryTheme.error;

  // Surface color, usually used for cards or floating elements
  static Color get surface => primaryTheme.surface;

  // AppBar background color
  static Color get appBar => primaryTheme.appBar;

  // Icon color for active elements
  static Color get icon => primaryTheme.icon;

  // Inactive icon color (usually for disabled elements)
  static Color get iconInactive => primaryTheme.iconInactive;

  // Divider color used for dividing sections in the app
  // static Color get divider => AppColors.dividerColor;

  // Border color used for text fields, buttons, etc.
  // static Color get border => AppColors.border;

  // Highlight color for important elements like selected items
  static Color get highlight => primaryTheme.highlight;
}
