import 'package:auto_find/main/pawn_shop/features/capital_manage/presentation/controller/capital_manage_controller.dart';
import 'package:get/get.dart';

class CapitalManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CapitalManageController());
  }
}
