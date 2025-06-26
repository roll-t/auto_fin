import 'package:auto_fin/features/dashboard/presentation/page/dashboard_page.dart';
import 'package:auto_fin/features/main/presentation/controller/main_controller.dart';
import 'package:auto_fin/features/main/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends GetView<MainController> {
  static String routeName = "/main";
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildNav(),
    );
  }

  Navigator _buildBody() {
    return Navigator(
      key: Get.nestedKey(10),
      initialRoute: DashboardPage.routeName,
      onGenerateRoute: controller.onGenerateRoute,
    );
  }

  Obx _buildNav() {
    return Obx(
      () {
        return BottomNavigationBarWidget(
          currentIndex: controller.currentPage.value,
          onChange: (int index) {
            controller.onChangeItemBottomBar(index);
          },
        );
      },
    );
  }
}
