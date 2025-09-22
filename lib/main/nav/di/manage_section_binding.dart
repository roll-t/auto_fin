import 'package:auto_find/main/nav/presentation/controller/manage_controller.dart';
import 'package:get/get.dart';

class ManageSectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageController());
  }
}
