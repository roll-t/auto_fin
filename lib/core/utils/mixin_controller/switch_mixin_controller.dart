import 'package:get/get.dart';

mixin SwitchMixinController {
  RxBool isSwitched = false.obs;

  void toggleSwitch(bool value) {
    isSwitched.value = value;
  }
}
