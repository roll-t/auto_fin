import 'package:auto_fin/features/showroom/all_card/presentation/controller/all_car_controller.dart';
import 'package:get/get.dart';

class AllCarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> AllCarController());
  }
}
