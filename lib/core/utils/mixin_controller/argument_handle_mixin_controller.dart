import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

mixin ArgumentHandlerMixinControlller<T> on GetxController {
  late T argsData;

  ///---> Hàm xử lý khi nhận argument [Handle][Get]
  bool handleArgument(Object? args) {
    if (args is T) {
      argsData = args;
      return true;
    }
    return false;
  }

  /// Hàm lấy trực tiếp Get.argument trong page r xử lý [Handle][Get.arguments]
  bool handleArgumentFromGet() {
    return handleArgument(Get.arguments);
  }

  /// Truyền argument đi trang khác
  void navigateWithArgument(String routeName, Object argument) {
    Get.toNamed(routeName, arguments: argument);
  }

  /// Giải phóng tài nguyên trong mixin (nếu cần)
  @mustCallSuper
  void disposeArgumentHandler() {
    // Nếu cần dọn dẹp thêm thì thêm vào đây
    // Ví dụ: reset args nếu cần
    // args = null; // nếu để nullable
    log("🧹 [ArgumentHandlerMixin] Disposed");
  }
}
