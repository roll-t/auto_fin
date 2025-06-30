import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/features/main/presentation/widgets/item_navigation_bar_widget.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int index) onChange;
  final Color selectedItemColor;
  const BottomNavigationBarWidget({
    super.key,
    required this.currentIndex,
    required this.onChange,
    required this.selectedItemColor
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onChange,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: selectedItemColor,
      unselectedItemColor: AppColors.border2,
      showUnselectedLabels: true,
      items: [
        buildNavItem(label: 'Dashboard', iconPath: AppIcons.icDashboard),
        buildNavItem(label: 'Showroom', iconPath: AppIcons.icCar),
        buildNavItem(label: 'Vàng bạc', iconPath: AppIcons.icDiamond),
        buildNavItem(label: 'Khoản vay', iconPath: AppIcons.icCredit),
        buildNavItem(label: 'Dòng tiền', iconPath: AppIcons.icMoney),
        buildNavItem(label: 'Nhân sự', iconPath: AppIcons.icPeople),
      ],
    );
  }
}
