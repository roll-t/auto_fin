import 'package:auto_find/core/utils/controller/internet_controller.dart';
import 'package:auto_find/core/utils/custom_binding.dart';
import 'package:get/get.dart';

class InternetBinding extends Bindings {
  @override
  void dependencies() {
    CustomBinding.put<InternetController>(InternetController());
  }
}
