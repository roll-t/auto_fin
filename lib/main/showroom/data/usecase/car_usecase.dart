import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/data/model/list_model.dart';
import 'package:auto_find/main/showroom/data/repositories/car_repository.dart';

class CarUsecase {
  final CarRepository _repository;

  CarUsecase(this._repository);

  Future<ListModel<CarModel>> getCars({
    int pageSize = 20,
    String? startAfter,
  }) async {
    try {
      return await _repository.getCars(
        pageSize: pageSize,
        startAfter: startAfter,
      );
    } catch (e, stack) {
      print('❌ Lỗi khi getCars: $e');
      print(stack);
      return ListModel(items: [], nextPageToken: null);
    }
  }

  Future<CarModel> getCarDetail(int id) {
    return _repository.getCarDetail(id);
  }

  Future<void> createCar(CarModel car) {
    return _repository.createCar(car);
  }

  Future<void> updateCar(CarModel car) {
    return _repository.updateCar(car);
  }

  Future<void> deleteCar(int id) {
    return _repository.deleteCar(id);
  }
}
