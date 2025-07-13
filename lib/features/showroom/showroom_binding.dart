import 'package:auto_fin/features/showroom/showroom_controller.dart';
import 'package:get/get.dart';

class ShowroomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShowroomController(),fenix: true);
  }
}
