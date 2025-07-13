import 'package:auto_fin/features/showroom/profit_manage/presentation/controller/profit_manage_controller.dart';
import 'package:auto_fin/features/showroom/profit_manage/presentation/controller/tabs_section/car_profit_section_controller.dart';
import 'package:auto_fin/features/showroom/profit_manage/presentation/controller/tabs_section/year_profit_car_section_controller.dart';
import 'package:get/get.dart';

class ProfitManageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfitManageController());
    Get.lazyPut(() => YearProfitCarSectionController());
    Get.lazyPut(() => CarProfitSectionController());
  }
}
