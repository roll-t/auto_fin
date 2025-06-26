import 'package:auto_fin/features/main/presentation/page/main_page.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    print("=====================================");
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(MainPage.routeName);
    });
  }
}
