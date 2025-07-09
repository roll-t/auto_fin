import 'package:flutter/material.dart';

class KeyboardUtils {
  static void hiddenKeyboard() {
    print("phuoc truong");
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
