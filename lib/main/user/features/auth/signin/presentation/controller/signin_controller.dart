import 'package:auto_find/core/utils/keyboard_utils.dart';
import 'package:auto_find/core/utils/validation_utils.dart';
import 'package:auto_find/main/nav/presentation/page/navigation_page.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SigninController extends GetxController {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  ///---> [Business Logic]
  bool _validation() {
    final fields = [
      {"value": userNameController.text, "label": "Tên đăng nhập"},
      {"value": firstNameController.text, "label": "Họ"},
      {"value": lastNameController.text, "label": "Tên"},
      {"value": phoneNumberController.text, "label": "Số điện thoại"},
      {"value": passwordController.text, "label": "Mật khẩu"},
    ];

    for (final field in fields) {
      final isValid = ValidationUtils.validateRequiredField(
        field["value"]!,
        field["label"]!,
      );
      if (!isValid) return false;
    }
    return true;
  }

  ///---> [Events]
  void onSignin() {
    KeyboardUtils.hiddenKeyboard();
    if (!_validation()) return; // ❌ không hợp lệ -> dừng
    Get.offAllNamed(const NavigationPage().routeName); // ✅ hợp lệ -> chuyển trang
  }
}
