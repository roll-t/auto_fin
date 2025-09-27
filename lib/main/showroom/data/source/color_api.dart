import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/config/result.dart';
import 'package:auto_find/core/services/api_client.dart';
import 'package:auto_find/core/services/api_endpoint.dart';
import 'package:auto_find/main/showroom/data/model/color_model.dart';
import 'package:get/get.dart';

class ColorApi {
  final ApiClient _client = Get.find<ApiClient>();

  /// Lấy danh sách color có phân trang
  Future<Result> getColors({
    int pageSize = 20,
    String? startAfter,
  }) {
    final query = {
      'pageSize': pageSize,
      if (startAfter != null) 'startAfter': startAfter,
    };
    return _client.get(ApiEndpoint.colors, query: query);
  }

  /// Lấy toàn bộ colors (ẩn soft-delete)
  Future<Result> getAllColors() {
    return _client.get(ApiEndpoint.allColors);
  }

  /// Lấy danh sách color theo tên
  Future<Result> getColorsByName(String name) {
    return _client.get(ApiEndpoint.colorsByName(name));
  }

  /// Lấy chi tiết color theo ID
  Future<Result> getColorDetail(int colorId) {
    return _client.get(ApiEndpoint.colorDetail(colorId));
  }

  /// Tạo color mới
  Future<Result> createColor(ColorModel color) {
    return _client.post(
      ApiEndpoint.colors,
      data: color.toJson(),
    );
  }

  /// Cập nhật color (name/status)
  Future<Result> updateColor(int colorId, ColorModel color) async {
    final response = await _client.put(
      ApiEndpoint.colorDetail(colorId),
      data: color.toJson(),
    );

    if (response.data is Map<String, dynamic>) {
      return Result(
        status: Results.success,
        data: response.data["data"],
        message: response.data["message"]?.toString(),
      );
    }

    return Result(
      status: Results.error,
      data: null,
      message: "Phản hồi không hợp lệ",
    );
  }

  /// Xoá mềm color
  Future<Result> deleteColor(int colorId) {
    return _client.delete(ApiEndpoint.colorDetail(colorId));
  }
}
