import 'package:auto_find/main/showroom/features/statistic/presentation/controller/statistic_vehicle_controller.dart';
import 'package:get/get.dart';

class StatisticVehicleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => StatisticVehicleController(
        Get.find(),
      ),
    );
  }
}
