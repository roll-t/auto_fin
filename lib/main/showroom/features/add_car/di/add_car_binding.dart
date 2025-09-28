import 'package:auto_find/core/utils/controller/keyboard_controller.dart';
import 'package:auto_find/main/showroom/features/add_car/presentation/controller/add_car_controller.dart';
import 'package:get/get.dart';

class AddCarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCarController>(
      () => AddCarController(
        Get.find(),
        Get.find(),
      ),
    );

    Get.lazyPut(() => KeyboardController());
  }
}
