import 'package:auto_find/main/nav/di/manage_section_binding.dart';
import 'package:auto_find/main/nav/di/profile_section_binding%20.dart';
import 'package:auto_find/main/nav/presentation/section/manage_section.dart';
import 'package:auto_find/main/nav/presentation/section/profile_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class NavigationController extends GetxController {
  final RxInt currentPage = 1.obs;

  List<String> routeNames = [
    const TabManage().routeName,
    const ProfileSection().routeName,
  ];

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/tab-manage':
        return GetPageRoute(
          settings: settings,
          page: () => const TabManage(),
          transition: Transition.fadeIn,
          binding: ManageSectionBinding(),
        );
      case '/tab-profile':
        return GetPageRoute(
          settings: settings,
          page: () => const ProfileSection(),
          binding: ProfileSectionBinding(),
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
