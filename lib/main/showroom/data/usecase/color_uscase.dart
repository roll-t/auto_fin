import 'package:auto_find/main/showroom/data/model/color_model.dart';
import 'package:auto_find/main/showroom/data/model/list_model.dart';
import 'package:auto_find/main/showroom/data/repositories/color_repository.dart';

class ColorUsecase {
  final ColorRepository _repository;

  ColorUsecase(this._repository);

  Future<ListModel<ColorModel>> getColors({
    int pageSize = 20,
    String? startAfter,
    bool activeOnly = false,
  }) async {
    try {
      return await _repository.getColors(
        pageSize: pageSize,
        startAfter: startAfter,
      );
    } catch (e, stack) {
      print('❌ Lỗi khi getColors: $e');
      print(stack);
      return ListModel<ColorModel>(
        items: [],
        nextPageToken: null,
      );
    }
  }

  Future<List<ColorModel>> getAllColors() async {
    try {
      return await _repository.getAllColors();
    } catch (e, stack) {
      print('❌ Lỗi khi getAllColors: $e');
      print(stack);
      return [];
    }
  }
}
