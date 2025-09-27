import 'package:auto_find/core/services/api_client.dart';
import 'package:auto_find/core/services/internet_service.dart';
import 'package:auto_find/main/splash/presentation/controller/splash_controller.dart';
import 'package:get/get.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());

    Get.put(InternetService());
    Get.put(ApiClient());
  }
}
