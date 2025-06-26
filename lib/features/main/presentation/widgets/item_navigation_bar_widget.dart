import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

BottomNavigationBarItem buildNavItem({
  required String label,
  required String iconPath,
  bool withPadding = true,
}) {
  Widget buildIcon(
    Color color, {
    bool isActive = false,
  }) {
    final icon = Utils.iconSvg(
      svgUrl: iconPath,
      color: color,
      size: 20,
    );
    final offsetY = isActive ? -5.0 : 0.0;

    return AnimatedSlide(
      offset: Offset(0, offsetY / 20),
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      child: withPadding
          ? Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: icon,
            )
          : icon,
    );
  }

  return BottomNavigationBarItem(
    label: label.tr,
    icon: buildIcon(
      AppColors.neutralColor1,
      isActive: false,
    ),
    activeIcon: buildIcon(
      AppThemeColors.primary,
      isActive: true,
    ),
  );
}
