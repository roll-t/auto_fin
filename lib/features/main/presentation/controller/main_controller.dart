import 'package:auto_fin/features/credit/credit_page.dart';
import 'package:auto_fin/features/credit/credit_binding.dart';
import 'package:auto_fin/features/dashboard/dashboard_page.dart';
import 'package:auto_fin/features/dashboard/di_dashboard/dashboard_binding.dart';
import 'package:auto_fin/features/diamond/diamond_binding.dart';
import 'package:auto_fin/features/diamond/diamond_page.dart';
import 'package:auto_fin/features/money/money_binding.dart';
import 'package:auto_fin/features/money/money_page.dart';
import 'package:auto_fin/features/employee/employee_binding.dart';
import 'package:auto_fin/features/employee/employee_page.dart';
import 'package:auto_fin/features/showroom/showroom_binding.dart';
import 'package:auto_fin/features/showroom/showroom_page.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  final RxInt currentPage = 0.obs;
  final RxString currentTitle = "Dashboard".obs;

  List<String> routeNames = [
    DashboardPage.routeName,
    ShowroomPage.routeName,
    DiamondPage.routeName,
    CreditPage.routeName,
    MoneyPage.routeName,
    EmployeePage.routeName,
  ];

  List<String> titles = [
    "Dashboard",
    "Showroom ô tô",
    "Công ty vàng bạc",
    "Quản lý vay ngân hàng",
    "Dòng tiền tổng hợp",
    "Nhân sự",
  ];

  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/DashboardPage":
        return GetPageRoute(
          settings: settings,
          page: () => const DashboardPage(),
          binding: DashboardBinding(),
          transition: Transition.fadeIn,
        );
      case '/ShowroomPage':
        return GetPageRoute(
          settings: settings,
          page: () => const ShowroomPage(),
          binding: ShowroomBinding(),
          transition: Transition.fadeIn,
        );
      case '/DiamondPage':
        return GetPageRoute(
          settings: settings,
          page: () => const DiamondPage(),
          binding: DiamondBinding(),
          transition: Transition.fadeIn,
        );
      case '/CreditPage':
        return GetPageRoute(
          settings: settings,
          page: () => const CreditPage(),
          binding: CreditBinding(),
          transition: Transition.fadeIn,
        );
      case '/MoneyPage':
        return GetPageRoute(
          settings: settings,
          page: () => const MoneyPage(),
          binding: MoneyBinding(),
          transition: Transition.fadeIn,
        );
      case '/EmployeePage':
        return GetPageRoute(
          settings: settings,
          page: () => const EmployeePage(),
          binding: EmployeeBinding(),
          transition: Transition.fadeIn,
        );
    }
    return null;
  }

  void onChangeItemBottomBar(int index) {
    if (currentPage.value == index) return;
    currentPage.value = index;
    currentTitle.value = titles[index];
    Get.offAndToNamed(routeNames[index], id: 10);
  }
}
