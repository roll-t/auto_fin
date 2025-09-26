import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/extension/core/rx_extensions.dart';
import 'package:auto_find/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:auto_find/core/utils/custom_framework.dart';
import 'package:auto_find/main/nav/presentation/controller/navigation_controller.dart';
import 'package:auto_find/main/nav/presentation/section/manage_section.dart';
import 'package:auto_find/main/nav/presentation/widgets/bottom_navigation_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NavigationPage extends CustomState {
  const NavigationPage({super.key});

  ///---> [Build-bottom-navigation]
  @override
  Widget? get bottomNavigationBar => _buildBottomNavigationBar();

  ///---> [Build-body]
  @override
  Widget buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final nestedNavigator = Get.nestedKey(10)?.currentState;
        if (nestedNavigator != null && nestedNavigator.canPop()) {
          nestedNavigator.pop();
          return false;
        }

        // Nếu không còn route nào => show confirm exit
        final bool shouldExit = await DialogUtils.showCustomExitConfirm();
        return shouldExit;
      },
      child: const BodyBuilder(),
    );
  }

  ///---> [Bottom-navigation-bar]
  GetBuilder<NavigationController> _buildBottomNavigationBar() {
    return GetBuilder<NavigationController>(
      builder: (controller) => controller.currentPage.obx(
        onData: (index) => BottomNavigationBarWidget(
          currentIndex: index,
          selectedItemColor: AppThemeColors.iconActive,
          onChange: (int index) {
            controller.onChangeItemBottomBar(index);
          },
        ),
      ),
    );
  }
}

///---> [Body-builder]
class BodyBuilder extends GetView<NavigationController> {
  const BodyBuilder({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: Get.nestedKey(10),
      initialRoute: const ManageSection().routeName,
      onGenerateRoute: (settings) => controller.onGenerateRoute(settings),
    );
  }
}
