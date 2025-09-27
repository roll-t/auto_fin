import 'package:auto_find/core/config/const/app_logger.dart';
import 'package:auto_find/core/local_storage/app_get_storage.dart';
import 'package:auto_find/main/nav/presentation/page/navigation_page.dart';
import 'package:auto_find/main/user/features/auth/login/presentation/page/login_page.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 1));
    if (AppGetStorage.isLoggedIn()) {
      Get.offAllNamed(const NavigationPage().routeName);
      AppLogger.i("Đã đăng nhập");
    } else {
      Get.offAllNamed(const LoginPage().routeName);
      AppLogger.i("Chưa đăng nhập");
    }
  }
}
