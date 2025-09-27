import 'package:auto_find/core/utils/controller/keyboard_controller.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/controller/car_detail_controller.dart';
import 'package:get/get.dart';

class CarDetailBinding extends Bindings {
  @override
  void dependencies() {
    ///[CONTROLLER]
    Get.lazyPut(
      () => CarDetailController(
        Get.find(),
        Get.find(),
      ),
    );

    Get.lazyPut(
      () => KeyboardController(),
    );
  }
}
