import 'package:auto_find/main/pawn_shop/features/statistic_pawnshop/presentation/controller/statistic_pawnshop_controller.dart';
import 'package:get/get.dart';

class StatisticPawnshopBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatisticPawnshopController());
  }
}
