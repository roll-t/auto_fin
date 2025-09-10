import 'package:auto_find/main/showroom/data/model/type_car_model.dart';
import 'package:auto_find/main/showroom/data/model/list_model.dart';
import 'package:auto_find/main/showroom/data/source/type_car_api.dart';

class TypeCarRepository {
  final TypeCarApi _api = TypeCarApi();

  Future<ListModel<TypeCarModel>> getTypes({
    int pageSize = 20,
    String? startAfter,
  }) async {
    final result = await _api.getTypes(
      pageSize: pageSize,
      startAfter: startAfter,
    );

    if (result.isSuccess) {
      if (result.data is Map<String, dynamic>) {
        return ListModel<TypeCarModel>.fromJson(
          result.data as Map<String, dynamic>,
          (json) => TypeCarModel.fromJson(json),
        );
      }
      return ListModel(items: [], nextPageToken: null);
    }
    throw Exception(result.message ?? "Lỗi không xác định");
  }

  Future<List<TypeCarModel>> getAllTypes() async {
    final result = await _api.getAllTypes();

    if (result.isSuccess) {
      if (result.data is List) {
        return (result.data as List)
            .map((e) => TypeCarModel.fromJson(e))
            .toList();
      }
      return [];
    }
    throw Exception(result.message ?? "Lỗi không xác định");
  }

  Future<TypeCarModel> getTypeDetail(int typeId) async {
    final result = await _api.getTypeDetail(typeId);
    if (result.isSuccess && result.data is Map<String, dynamic>) {
      return TypeCarModel.fromJson(result.data as Map<String, dynamic>);
    }
    throw Exception(result.message ?? "Không tìm thấy type");
  }

  Future<void> createType(TypeCarModel type) async {
    final result = await _api.createType(type);
    if (!result.isSuccess) {
      throw Exception(result.message ?? "Tạo type thất bại");
    }
  }

  Future<void> updateType(int typeId, TypeCarModel type) async {
    final result = await _api.updateType(typeId, type);
    if (!result.isSuccess) {
      throw Exception(result.message ?? "Cập nhật type thất bại");
    }
  }

  Future<void> deleteType(int typeId) async {
    final result = await _api.deleteType(typeId);
    if (!result.isSuccess) {
      throw Exception(result.message ?? "Xoá type thất bại");
    }
  }
}
