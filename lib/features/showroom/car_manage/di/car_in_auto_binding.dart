import 'package:auto_fin/features/showroom/car_manage/presentation/controller/car_in_auto_controller.dart';
import 'package:get/get.dart';

class CarInAutoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> CarInAutoController());
  }
}
