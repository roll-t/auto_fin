import 'dart:developer';
import 'dart:io';

import 'package:auto_fin/core/services/network/api_enpoint.dart';
import 'package:auto_fin/core/services/network/api_intercepter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiClient extends GetxService {
  late final Dio _dio;
  final Connectivity _connectivity = Connectivity();
  late final RxBool isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();

    // Lắng nghe sự thay đổi mạng
    _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      if (results.isNotEmpty) {
        _handleConnectivityChange(results.first);
      }
    });

    // Kiểm tra mạng lần đầu
    Future.microtask(() async {
      final hasNetwork = await _checkNetwork();
      isConnected.value = hasNetwork;
      if (!hasNetwork) {
        _showNoInternetSnackbar();
      }

      _initDio(); // luôn khởi tạo Dio để không bị null
    });
  }

  Dio get client => _dio;

  void _initDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoint.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    )..interceptors.add(ApiInterceptor());

    log('[ApiClient] ✅ Dio initialized');
  }

  /// Kiểm tra trạng thái kết nối thực tế (chắc chắn hơn)
  Future<bool> _checkNetwork() async {
    log('[ApiClient] 🔍 Checking Internet...');
    try {
      final result = await InternetAddress.lookup('google.com');
      final isOnline = result.isNotEmpty && result.first.rawAddress.isNotEmpty;
      log('[ApiClient] 🌐 Network available: $isOnline');
      return isOnline;
    } on SocketException catch (_) {
      log('[ApiClient] ❌ No Internet');
      return false;
    }
  }

  /// Xử lý khi trạng thái mạng thay đổi
  void _handleConnectivityChange(ConnectivityResult result) async {
    final realConnection = await _checkNetwork();
    if (realConnection != isConnected.value) {
      isConnected.value = realConnection;
      if (!realConnection) {
        _showNoInternetSnackbar();
      } else {
        _showInternetRestoredSnackbar();
      }
    }
  }

  void _showNoInternetSnackbar() {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        'Không có kết nối',
        'Vui lòng kiểm tra lại kết nối mạng.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void _showInternetRestoredSnackbar() {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        'Đã kết nối mạng',
        'Kết nối internet đã được khôi phục.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }
}
