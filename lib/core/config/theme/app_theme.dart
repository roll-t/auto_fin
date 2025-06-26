// app_theme.dart
import 'package:auto_fin/core/config/theme/app_color_scheme.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light(AppColorScheme colors) {
    return ThemeData(
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(fontSize: 10),
        selectedIconTheme: IconThemeData(size: 24),
        unselectedIconTheme: IconThemeData(size: 20),
      ),
      brightness: Brightness.light,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppThemeColors.primary,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(color: colors.textPrimary),
        bodyMedium: TextStyle(color: colors.textSecondary),
      ),
      colorScheme: ColorScheme.light(
        primary: colors.primary,
        secondary: colors.secondary,
        error: colors.error,
      ),
    );
  }

  static ThemeData dark(AppColorScheme colors) {
    return ThemeData(
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedLabelStyle: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: TextStyle(fontSize: 10),
        selectedIconTheme: IconThemeData(size: 24),
        unselectedIconTheme: IconThemeData(size: 20),
      ),
      brightness: Brightness.dark,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: AppBarTheme(
        backgroundColor: AppThemeColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppThemeColors.primary,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.grey),
      ),
      colorScheme: ColorScheme.dark(
        primary: colors.primary,
        secondary: colors.secondary,
        error: colors.error,
      ),
    );
  }
}
