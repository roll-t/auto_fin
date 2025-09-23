import 'package:auto_find/core/config/const/app_vectors.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/main/nav/presentation/widgets/item_navigation_bar_widget.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int index) onChange;
  final Color selectedItemColor;

  const BottomNavigationBarWidget({
    super.key,
    required this.currentIndex,
    required this.onChange,
    required this.selectedItemColor,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppThemeColors.background100,
      currentIndex: currentIndex,
      onTap: onChange,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: selectedItemColor,
      showUnselectedLabels: true,
      items: [
        buildNavItem(label: 'Quản lý', iconPath: AppVectors.icManage),
        buildNavItem(label: 'Cá nhân', iconPath: AppVectors.icPerson),
      ],
    );
  }
}
