import 'dart:ui';

import 'package:auto_fin/core/config/theme/app_colors.dart';

class AppColorScheme {
  final Color primary;
  final Color secondary;
  final Color error;

  final Color background;
  final Color surface;
  final Color card;
  final Color appBar;

  final Color textPrimary;
  final Color textSecondary;
  final Color textDisabled;

  final Color icon;
  final Color iconInactive;

  final Color divider;
  final Color border;
  final Color highlight;
  final Color lightest;
  final Color lighter;
  final Color light;
  final Color dark;
  final Color darker;
  final Color darkest;

  AppColorScheme({
    required this.primary,
    required this.secondary,
    required this.error,
    required this.background,
    required this.surface,
    required this.card,
    required this.appBar,
    required this.textPrimary,
    required this.textSecondary,
    required this.textDisabled,
    required this.icon,
    required this.iconInactive,
    required this.divider,
    required this.border,
    required this.highlight,
    required this.lighter,
    required this.lightest,
    required this.light,
    required this.dark,
    required this.darker,
    required this.darkest,
  });
}

enum AppColorTheme { theme1, theme2, theme3, theme4, theme5 }

class AppColorThemeScheme {
  static AppColorScheme getColorScheme(AppColorTheme theme) {
    switch (theme) {
      case AppColorTheme.theme1:
        return AppColorScheme(
          primary: AppColors.primary1,
          secondary: AppColors.lighter1,
          error: AppColors.error1,
          background: AppColors.lightest1,
          surface: AppColors.light1,
          card: AppColors.dark1,
          appBar: AppColors.primary1,
          textPrimary: AppColors.lightest1,
          textSecondary: AppColors.lighter1,
          textDisabled: AppColors.light1,
          icon: AppColors.lightest1,
          iconInactive: AppColors.lighter1,
          divider: AppColors.darker1,
          border: AppColors.dark1,
          highlight: AppColors.primary1,
          lightest: AppColors.lightest1,
          lighter: AppColors.lighter1,
          light: AppColors.light1,
          dark: AppColors.dark1,
          darker: AppColors.darker1,
          darkest: AppColors.darkest1,
        );

      case AppColorTheme.theme2:
        return AppColorScheme(
          primary: AppColors.primary2,
          secondary: AppColors.secondary2,
          error: AppColors.error2,
          background: AppColors.background1,
          surface: AppColors.surface1,
          card: AppColors.cardBackground2,
          appBar: AppColors.primary2,
          textPrimary: AppColors.textPrimary1,
          textSecondary: AppColors.textSecondary1,
          textDisabled: AppColors.textSecondary2,
          icon: AppColors.primary2,
          iconInactive: AppColors.textSecondary2,
          divider: AppColors.divider1,
          border: AppColors.border1,
          highlight: AppColors.primary2,
          lightest: AppColors.lightest1,
          lighter: AppColors.lighter1,
          light: AppColors.light1,
          dark: AppColors.dark1,
          darker: AppColors.darker1,
          darkest: AppColors.darkest1,
        );

      case AppColorTheme.theme3:
        return AppColorScheme(
          primary: AppColors.primary3,
          secondary: AppColors.secondary3,
          error: AppColors.error1,
          background: AppColors.background1,
          surface: AppColors.surface1,
          card: AppColors.cardBackground1,
          appBar: AppColors.primary3,
          textPrimary: AppColors.textPrimary1,
          textSecondary: AppColors.textSecondary1,
          textDisabled: AppColors.textSecondary2,
          icon: AppColors.primary3,
          iconInactive: AppColors.textSecondary2,
          divider: AppColors.divider1,
          border: AppColors.border1,
          highlight: AppColors.primary3,
          lightest: AppColors.lightest1,
          lighter: AppColors.lighter1,
          light: AppColors.light1,
          dark: AppColors.dark1,
          darker: AppColors.darker1,
          darkest: AppColors.darkest1,
        );

      case AppColorTheme.theme4:
        return AppColorScheme(
          primary: AppColors.primary4,
          secondary: AppColors.secondary4,
          error: AppColors.error1,
          background: AppColors.background1,
          surface: AppColors.surface1,
          card: AppColors.cardBackground1,
          appBar: AppColors.primary4,
          textPrimary: AppColors.textPrimary1,
          textSecondary: AppColors.textSecondary1,
          textDisabled: AppColors.textSecondary2,
          icon: AppColors.primary4,
          iconInactive: AppColors.textSecondary2,
          divider: AppColors.divider1,
          border: AppColors.border1,
          highlight: AppColors.primary4,
          lightest: AppColors.lightest1,
          lighter: AppColors.lighter1,
          light: AppColors.light1,
          dark: AppColors.dark1,
          darker: AppColors.darker1,
          darkest: AppColors.darkest1,
        );

      case AppColorTheme.theme5:
        return AppColorScheme(
          primary: AppColors.primary5,
          secondary: AppColors.secondary5,
          error: AppColors.error1,
          background: AppColors.background1,
          surface: AppColors.surface1,
          card: AppColors.cardBackground1,
          appBar: AppColors.primary5,
          textPrimary: AppColors.textPrimary1,
          textSecondary: AppColors.textSecondary1,
          textDisabled: AppColors.textSecondary2,
          icon: AppColors.primary5,
          iconInactive: AppColors.textSecondary2,
          divider: AppColors.divider1,
          border: AppColors.border1,
          highlight: AppColors.primary5,
          lightest: AppColors.lightest1,
          lighter: AppColors.lighter1,
          light: AppColors.light1,
          dark: AppColors.dark1,
          darker: AppColors.darker1,
          darkest: AppColors.darkest1,
        );
    }
  }
}
