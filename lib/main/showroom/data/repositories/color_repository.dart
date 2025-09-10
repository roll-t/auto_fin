import 'package:auto_find/main/showroom/data/model/color_model.dart';
import 'package:auto_find/main/showroom/data/model/list_model.dart';
import 'package:auto_find/main/showroom/data/source/color_api.dart';

class ColorRepository {
  final ColorApi _api = ColorApi();

  /// Lấy danh sách màu + phân trang
  Future<ListModel<ColorModel>> getColors({
    int pageSize = 20,
    String? startAfter,
  }) async {
    final result = await _api.getColors(
      pageSize: pageSize,
      startAfter: startAfter,
    );

    if (result.isSuccess) {
      if (result.data is Map<String, dynamic>) {
        return ListModel<ColorModel>.fromJson(
          result.data as Map<String, dynamic>,
          (json) => ColorModel.fromJson(json),
        );
      }
      return ListModel(items: [], nextPageToken: null);
    }
    throw Exception(result.message ?? "Lỗi khi gọi API getColors");
  }

  /// Lấy toàn bộ màu (ẩn soft-delete)
  Future<List<ColorModel>> getAllColors() async {
    final result = await _api.getAllColors();
    if (result.isSuccess) {
      if (result.data is List) {
        return (result.data as List)
            .map((e) => ColorModel.fromJson(e))
            .toList();
      }
      return [];
    }
    throw Exception(result.message ?? "Lỗi khi gọi API getAllColors");
  }
}
