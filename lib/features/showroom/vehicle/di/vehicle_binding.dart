import 'package:auto_fin/features/showroom/vehicle/presentation/controller/vehicle_controller.dart';
import 'package:get/get.dart';

class VehicleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(()=> VehicleController());
  }
}
