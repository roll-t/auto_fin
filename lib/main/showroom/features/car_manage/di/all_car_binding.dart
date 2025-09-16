import 'package:auto_find/main/showroom/features/car_manage/presentation/controller/car_manage_controller.dart';
import 'package:get/get.dart';

class AllCarBinding extends Bindings {
  @override
  void dependencies() {
    ///---> [Controller]
    Get.lazyPut(
      () => CarManageController(
        Get.find(),
      ),
    );
  }
}
