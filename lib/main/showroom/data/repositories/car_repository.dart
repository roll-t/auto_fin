import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/data/model/list_model.dart';
import 'package:auto_find/main/showroom/data/source/car_api.dart';
import 'package:get/get.dart';

class CarRepository {
  final CarApi _api = CarApi();

  Future<ListModel<CarModel>> getCars({
    int pageSize = 20,
    String? startAfter,
  }) async {
    final result = await _api.getCars(
      pageSize: pageSize,
      startAfter: startAfter,
    );

    if (result.isSuccess) {
      if (result.data is Map<String, dynamic>) {
        return ListModel<CarModel>.fromJson(
          result.data as Map<String, dynamic>,
          (json) => CarModel.fromJson(json),
        );
      }
      return ListModel<CarModel>(items: [], nextPageToken: null);
    }
    throw Exception(result.message);
  }

  Future<CarModel> getCarDetail(int id) async {
    final result = await _api.getCarDetail(id);
    if (result.isSuccess) {
      return CarModel.fromJson(result.data);
    }
    throw Exception(result.message);
  }

  Future<void> createCar(CarModel car) async {
    DialogUtils.showProgressDialog();
    final result = await _api.createCar(car);
    Get.back();
    if (result.isSuccess) {
      DialogUtils.showAlert(
        alertType: AlertType.success,
        content: result.message,
      );
    } else if (!result.isSuccess) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: result.message,
      );
    }
  }

  Future<void> updateCar(CarModel car) async {
    final result = await _api.updateCar(car.id ?? 0, car);
    DialogUtils.showAlert(
      alertType: result.isSuccess ? AlertType.success : AlertType.error,
      content: result.message,
    );
  }

  Future<void> deleteCar(int id) async {
    final result = await _api.deleteCar(id);
    if (!result.isSuccess) throw Exception(result.message);
  }
}
