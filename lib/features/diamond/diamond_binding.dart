import 'package:auto_fin/features/diamond/diamond_controller.dart';
import 'package:get/get.dart';

class DiamondBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DiamondController());
  }
}