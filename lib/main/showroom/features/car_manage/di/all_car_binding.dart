import 'package:auto_find/main/showroom/features/car_manage/presentation/controller/all_car_controller.dart';
import 'package:get/get.dart';

class AllCarBinding extends Bindings {
  @override
  void dependencies() {
    ///---> [Controller]
    Get.lazyPut(
      () => AllCarController(
        Get.find(),
      ),
    );
  }
}
