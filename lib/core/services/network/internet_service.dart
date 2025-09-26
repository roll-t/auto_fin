import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InternetService extends GetxService {
  final Connectivity _connectivity = Connectivity();
  final RxBool isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    _listenNetworkChange();
  }

  void _listenNetworkChange() {
    _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) async {
        if (results.isNotEmpty) {
          final online = await _checkNetwork();
          if (isConnected.value != online) {
            isConnected.value = online;
            _showSnackbar(online);
          }
        }
      },
    );

    // check initial state
    Future.microtask(() async {
      isConnected.value = await _checkNetwork();
    });
  }

  Future<bool> _checkNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  void _showSnackbar(bool online) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        online ? 'Đã kết nối mạng' : 'Không có kết nối',
        online
            ? 'Kết nối internet đã được khôi phục.'
            : 'Vui lòng kiểm tra lại kết nối mạng.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: online ? Colors.green : Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
