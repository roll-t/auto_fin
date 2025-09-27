import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/config/result.dart';
import 'package:auto_find/core/services/api_client.dart';
import 'package:auto_find/core/services/api_endpoint.dart';
import 'package:auto_find/main/showroom/data/model/type_car_model.dart';
import 'package:get/get.dart';

class TypeCarApi {
  final ApiClient _client = Get.find<ApiClient>();

  /// Danh sách type (ẩn soft-delete) + phân trang
  Future<Result> getTypes({
    int pageSize = 20,
    String? startAfter,
  }) {
    final query = {
      'pageSize': pageSize,
      if (startAfter != null) 'startAfter': startAfter,
    };
    return _client.get(ApiEndpoint.types, query: query);
  }

  /// Lấy toàn bộ types (ẩn soft-delete)
  Future<Result> getAllTypes() {
    return _client.get(ApiEndpoint.typesAll);
  }

  /// Lấy chi tiết type theo ID
  Future<Result> getTypeDetail(int typeId) {
    return _client.get(ApiEndpoint.typeDetail(typeId));
  }

  /// Lấy danh sách type theo tên
  Future<Result> getTypeByName(String name) {
    return _client.get(ApiEndpoint.typeByName(name));
  }

  /// Tạo type mới
  Future<Result> createType(TypeCarModel type) {
    return _client.post(
      ApiEndpoint.types,
      data: type.toJson(),
    );
  }

  /// Cập nhật type
  Future<Result> updateType(int typeId, TypeCarModel type) async {
    final response = await _client.put(
      ApiEndpoint.typeDetail(typeId),
      data: {
        'name': type.name,
        'status': type.status,
      },
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

  /// Xoá mềm type
  Future<Result> deleteType(int typeId) {
    return _client.delete(ApiEndpoint.typeDetail(typeId));
  }
}
