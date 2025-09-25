import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetUtils {
  static final Connectivity _connectivity = Connectivity();
  static final RxBool isConnected = true.obs;
  static void listenNetworkChange() {
    _connectivity.onConnectivityChanged.listen((results) async {
      final online = await checkInternet();
      if (isConnected.value != online) {
        isConnected.value = online;
        if (!online) {
          _showSnackbar(
            'Không có kết nối',
            'Vui lòng kiểm tra lại kết nối mạng.',
            Colors.redAccent,
          );
        } else {
          _showSnackbar(
            'Đã kết nối mạng',
            'Kết nối internet đã được khôi phục.',
            Colors.green,
          );
        }
      }
    });
    Future.microtask(() async {
      isConnected.value = await checkInternet();
    });
  }

  static Future<bool> checkInternet() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  static void _showSnackbar(
    String title,
    String message,
    Color color,
  ) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        title,
        message,
        snackPosition: SnackPosition.TOP,
        backgroundColor: color,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
