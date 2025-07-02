import 'package:auto_fin/core/services/network/api_client.dart';
import 'package:auto_fin/core/services/notification/notification_service.dart';
import 'package:auto_fin/features/splash/presentation/controller/splash_controller.dart';
import 'package:auto_fin/features/theme/controller/theme_controller.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiClient());
    Get.lazyPut(() => ThemeController(), fenix: true);
    Get.lazyPut(() => NotificationService(), fenix: true);
    Get.put(SplashController());
  }
}
