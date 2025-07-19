import 'package:auto_fin/features/money/money_controller.dart';
import 'package:get/get.dart';

class MoneyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MoneyController());
  }
}
