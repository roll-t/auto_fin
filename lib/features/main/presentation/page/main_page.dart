import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/ui/widgets/app_bar/main_appbar.dart';
import 'package:auto_fin/core/ui/widgets/standard_layout_widget.dart';
import 'package:auto_fin/features/dashboard/dashboard_page.dart';
import 'package:auto_fin/features/main/presentation/controller/main_controller.dart';
import 'package:auto_fin/features/main/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends GetView<MainController> {
  static String routeName = "/main";
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final String titlePage = controller.currentTitle.value;
        return StandardLayoutWidget(
          appBar: MainAppbar(title: titlePage),
          bodyBuilder: Navigator(
            key: Get.nestedKey(10),
            initialRoute: DashboardPage.routeName,
            onGenerateRoute: controller.onGenerateRoute,
          ),
          navigationBar: BottomNavigationBarWidget(
            currentIndex: controller.currentPage.value,
            selectedItemColor: AppThemeColors.primary,
            onChange: (int index) {
              controller.onChangeItemBottomBar(index);
            },
          ),
        );
      },
    );
  }
}
