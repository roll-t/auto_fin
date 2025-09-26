import 'package:auto_find/core/services/network/api_client.dart';
import 'package:auto_find/main/splash/presentation/controller/splash_controller.dart';
import 'package:auto_find/core/config/theme/theme_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiClient());
    Get.lazyPut(() => ThemeController(), fenix: true);
    Get.put(SplashController());
  }
}
