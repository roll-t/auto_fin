import 'dart:developer';
import 'dart:io';
import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/config/result.dart';
import 'package:auto_find/core/local_storage/app_get_storage.dart';
import 'package:auto_find/core/services/network/api_intercepter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ApiClient extends GetxService {
  late final Dio _dio;
  final Connectivity _connectivity = Connectivity();
  final RxBool isConnected = true.obs;
  final String baseUrl = dotenv.env["API_URL"] ?? "https://";

  @override
  void onInit() {
    super.onInit();
    _initDio();
    _listenNetworkChange();
  }

  Dio get client => _dio;

  void _initDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        validateStatus: (_) => true,
      ),
    ) // 🟢 Interceptor để gắn token vào request
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = AppGetStorage.getToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
            log('[ApiClient] 🟢 Attached token: $token');
          } else {
            log('[ApiClient] 🔴 No token found, sending request without auth');
          }
          handler.next(options);
        },
      ))
      // 🟢 Interceptor log + handle lỗi
      ..interceptors.add(ApiInterceptor());

    log('[ApiClient] ✅ Dio initialized');
  }

  void _listenNetworkChange() {
    _connectivity.onConnectivityChanged
        .listen((List<ConnectivityResult> results) async {
      if (results.isNotEmpty) {
        final online = await _checkNetwork();
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
      }
    });

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

  void _showSnackbar(
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

  /// Wrapper GET request
  Future<Result<dynamic>> get(
    String path, {
    Map<String, dynamic>? query,
  }) async {
    if (!isConnected.value) {
      _showSnackbar(
        'Không có kết nối',
        'Vui lòng kiểm tra lại kết nối mạng.',
        Colors.redAccent,
      );
      return Result(
        status: Results.error,
        message: 'Không có kết nối internet',
      );
    }
    try {
      final response = await _dio.get(path, queryParameters: query);
      if (response.statusCode == 200) {
        return Result(
          status: Results.success,
          data: response.data,
        );
      } else {
        return Result(
          status: Results.error,
          message: 'HTTP ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      return Result(
        status: Results.error,
        message: _handleError(e),
      );
    }
  }

  Future<Result<dynamic>> post(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    if (!isConnected.value) {
      return Result(
        status: Results.error,
        message: 'Không có kết nối internet',
      );
    }

    try {
      final response = await _dio.post(path, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      return Result(
        status: Results.error,
        message: e.message ?? 'Lỗi không xác định',
      );
    }
  }

  Future<Result<dynamic>> patch(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.patch(path, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      return Result(status: Results.error, message: _handleError(e));
    }
  }

  Future<Result<dynamic>> put(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.put(path, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      return Result(
        status: Results.error,
        message: _handleError(e),
      );
    }
  }

  Future<Result<dynamic>> delete(
    String path, {
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _dio.delete(path, data: data);
      return _handleResponse(response);
    } on DioException catch (e) {
      return Result(
        status: Results.error,
        message: _handleError(e),
      );
    }
  }

  Result _handleResponse(dynamic response) {
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return Result(
        status: Results.success,
        data: response.data,
      );
    } else {
      final message = (response.data is Map && response.data['error'] != null)
          ? response.data['error']
          : 'HTTP ${response.statusCode}';

      return Result(
        status: Results.error,
        message: message,
      );
    }
  }

  String _handleError(DioException e) {
    print(">>> RUN $e");
    if (e.type == DioExceptionType.connectionTimeout) {
      return 'Kết nối server quá thời gian cho phép';
    } else if (e.type == DioExceptionType.receiveTimeout) {
      return 'Server phản hồi quá chậm';
    } else if (e.type == DioExceptionType.badResponse) {
      return 'Lỗi server: ${e.response?.statusCode}';
    } else {
      return 'Có lỗi xảy ra: ${e.message}';
    }
  }
}
