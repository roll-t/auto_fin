import 'package:auto_find/main/showroom/features/profit_manage/presentation/controller/profit_manage_controller.dart';
import 'package:get/get.dart';

class ProfitManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ProfitManageController(
        Get.find(),
      ),
    );
  }
}
