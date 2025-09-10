import 'package:auto_find/main/showroom/data/model/type_car_model.dart';
import 'package:auto_find/main/showroom/data/model/list_model.dart';
import 'package:auto_find/main/showroom/data/repositories/type_car_repository.dart';

class TypeCarUsecase {
  final TypeCarRepository _repository;

  TypeCarUsecase(this._repository);

  Future<ListModel<TypeCarModel>> getTypes({
    int pageSize = 20,
    String? startAfter,
  }) async {
    try {
      return await _repository.getTypes(
        pageSize: pageSize,
        startAfter: startAfter,
      );
    } catch (e, stack) {
      print("❌ Lỗi khi getTypes: $e");
      print(stack);
      return ListModel(items: [], nextPageToken: null);
    }
  }

  Future<List<TypeCarModel>> getAllTypes() async {
    try {
      return await _repository.getAllTypes();
    } catch (e, stack) {
      print("❌ Lỗi khi getAllTypes: $e");
      print(stack);
      return [];
    }
  }

  Future<TypeCarModel?> getTypeDetail(int id) async {
    try {
      return await _repository.getTypeDetail(id);
    } catch (e, stack) {
      print("❌ Lỗi khi getTypeDetail: $e");
      print(stack);
      return null;
    }
  }

  Future<void> createType(TypeCarModel type) async {
    try {
      return await _repository.createType(type);
    } catch (e, stack) {
      print("❌ Lỗi khi createType: $e");
      print(stack);
    }
  }

  Future<void> updateType(int typeId, TypeCarModel type) async {
    try {
      return await _repository.updateType(typeId, type);
    } catch (e, stack) {
      print("❌ Lỗi khi updateType: $e");
      print(stack);
    }
  }

  Future<void> deleteType(int typeId) async {
    try {
      return await _repository.deleteType(typeId);
    } catch (e, stack) {
      print("❌ Lỗi khi deleteType: $e");
      print(stack);
    }
  }
}
