import 'package:auto_fin/features/category/di/category_binding.dart';
import 'package:auto_fin/features/category/presentation/page/category_page.dart';
import 'package:auto_fin/features/dashboard/di/dashboard_binding.dart';
import 'package:auto_fin/features/dashboard/presentation/page/dashboard_page.dart';
import 'package:auto_fin/features/setting/di/setting_binding.dart';
import 'package:auto_fin/features/setting/presentation/page/setting_page.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final RxInt currentPage = 1.obs;

  List<String> routeNames = [
    CategoryPage.routeName,
    DashboardPage.routeName,
    SettingPage.routeName,
    SettingPage.routeName,
    SettingPage.routeName,
    SettingPage.routeName,
  ];

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/category":
        return GetPageRoute(
          settings: settings,
          page: () => const CategoryPage(),
          binding: CategoryBinding(),
          transition: Transition.fadeIn,
        );
      case '/DashboardPage':
        return GetPageRoute(
          settings: settings,
          page: () => const DashboardPage(),
          binding: DashboardBinding(),
          transition: Transition.fadeIn,
        );
      case '/settings':
        return GetPageRoute(
          settings: settings,
          page: () => const SettingPage(),
          binding: SettingBinding(),
          transition: Transition.fadeIn,
        );
    }
    return null;
  }

  void onChangeItemBottomBar(int index) {
    if (currentPage.value == index) return;
    currentPage.value = index;
    Get.offAndToNamed(routeNames[index], id: 10);
  }
}
