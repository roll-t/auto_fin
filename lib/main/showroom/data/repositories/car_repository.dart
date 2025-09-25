import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/config/const/app_logger.dart';
import 'package:auto_find/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:auto_find/main/showroom/data/model/car_chart_model.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/data/model/list_model.dart';
import 'package:auto_find/main/showroom/data/model/profit_matrix_response_model.dart';
import 'package:auto_find/main/showroom/data/model/showroom_cars_model.dart';
import 'package:auto_find/main/showroom/data/model/sold_cars_model.dart';
import 'package:auto_find/main/showroom/data/model/top_model.dart';
import 'package:auto_find/main/showroom/data/source/car_api.dart';
import 'package:get/get.dart';

class CarRepository {
  final CarApi _api = CarApi();

  /// Danh sách xe (có phân trang + filter status)
  Future<ListModel<CarModel>> getCars({
    String? status,
    int pageSize = 20,
    String? pageToken,
    SortType? sortType,
  }) async {
    final result = await _api.getCars(
      status: status,
      pageSize: pageSize,
      pageToken: pageToken,
      sortType: sortType,
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

  /// Lấy toàn bộ xe (không phân trang)
  Future<List<CarModel>> getAllCars({String? sort}) async {
    final result = await _api.getAllCars(sort: sort);
    if (result.isSuccess) {
      final list =
          (result.data as List).map((e) => CarModel.fromJson(e)).toList();
      return list;
    }
    throw Exception(result.message);
  }

  Future<CarModel> getCarDetail(int id) async {
    DialogUtils.showProgressDialog();
    final result = await _api.getCarDetail(id);
    Get.back();
    if (result.isSuccess) {
      return CarModel.fromJson(result.data);
    }
    throw Exception(result.message);
  }

  Future<void> createCar(CarModel car) async {
    DialogUtils.showProgressDialog();
    final result = await _api.createCar(car);
    Get.back();
    if (result.data is Map<String, dynamic>) {
      DialogUtils.showAlert(
        alertType: result.isSuccess ? AlertType.success : AlertType.error,
        content: result.data['message'] ?? "N/A",
      );
    }
  }

  Future<void> updateCar(CarModel car) async {
    DialogUtils.showProgressDialog();
    final result = await _api.updateCar(car.id ?? 0, car);
    Get.back();
    if (result.data is Map<String, dynamic>) {
      DialogUtils.showAlert(
        alertType: result.isSuccess ? AlertType.success : AlertType.error,
        content: result.data['message'] ?? "N/A",
      );
    }
  }

  Future<void> deleteCar(int id) async {
    final result = await _api.deleteCar(id);
    if (!result.isSuccess) throw Exception(result.message);
  }

  /// Danh sách xe đã bán
  Future<SoldCarsModel> getSoldCars({
    int? pageSize,
    String? pageToken,
  }) async {
    final result =
        await _api.getSoldCars(pageSize: pageSize, pageToken: pageToken);

    if (result.isSuccess) {
      return SoldCarsModel.fromJson(result.data);
    }

    throw Exception(result.message);
  }

  /// Xe trong showroom
  Future<ShowroomCarsModel> getShowroomCars() async {
    final result = await _api.getShowroomCars();
    if (result.isSuccess) {
      return ShowroomCarsModel.fromJson(result.data);
    }
    throw Exception(result.message);
  }

  /// Tìm kiếm xe
  Future<ListModel<CarModel>> searchCars({
    String? name,
    String? plate,
    String? status,
    bool? all,
    int? pageSize,
    String? pageToken,
  }) async {
    final result = await _api.searchCars(
      name: name,
      plate: plate,
      status: status,
      all: all,
      pageSize: pageSize,
      pageToken: pageToken,
    );
    if (result.isSuccess) {
      return ListModel<CarModel>.fromJson(
        result.data,
        (json) => CarModel.fromJson(json),
      );
    }
    throw Exception(result.message);
  }

  /// Biểu đồ line/bar
  Future<CarChartsModel?> getCharts({required int year}) async {
    final result = await _api.getCharts(year: year);

    if (result.isSuccess) {
      final data = result.data;
      if (data is Map<String, dynamic>) {
        return CarChartsModel.fromJson(data);
      } else {
        AppLogger.e("Invalid data format from API");
        return null;
      }
    } else {
      AppLogger.e(result.message);
      return null;
    }
  }

  /// Ma trận lợi nhuận
  Future<ProfitMatrixResponseModel> getProfitMatrix(
      {int? year, int? month}) async {
    final result = await _api.getProfitMatrix(year: year, month: month);

    if (result.isSuccess) {
      final data = result.data;
      if (data is Map<String, dynamic>) {
        return ProfitMatrixResponseModel.fromJson(data);
      } else {
        throw Exception("Dữ liệu trả về không hợp lệ: $data");
      }
    }

    throw Exception(result.message);
  }

  /// Top 5 thương hiệu lợi nhuận cao
  Future<List<TopModel>> getTopBrands() async {
    final result = await _api.getTopBrands();
    if (result.isSuccess) {
      return (result.data as List)
          .map((e) => TopModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception(result.message);
  }

  Future<List<TopModel>> getTopProducts() async {
    final result = await _api.getTopProducts();
    if (result.isSuccess) {
      return (result.data as List)
          .map((e) => TopModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    throw Exception(result.message);
  }

  Future<List<CarModel>> getTopProfit() async {
    final result = await _api.getTopProfit();
    if (result.isSuccess) {
      return (result.data as List).map((e) => CarModel.fromJson(e)).toList();
    }
    throw Exception(result.message);
  }

  Future<List<CarModel>> getTopValue() async {
    final result = await _api.getTopValue();
    if (result.isSuccess) {
      return (result.data as List).map((e) => CarModel.fromJson(e)).toList();
    }
    throw Exception(result.message);
  }

  Future<List<CarModel>> getTopRecent() async {
    final result = await _api.getTopRecent();
    if (result.isSuccess) {
      return (result.data as List).map((e) => CarModel.fromJson(e)).toList();
    }
    AppLogger.e(result.message);
    return [];
  }
}
