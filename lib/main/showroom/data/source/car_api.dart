import 'package:auto_find/core/config/result.dart';
import 'package:auto_find/core/services/network/api_client.dart';
import 'package:auto_find/core/services/network/api_endpoint.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:get/get.dart';

class CarApi {
  final ApiClient _client = Get.find<ApiClient>();

  /// Danh sách xe (có thể lọc theo status + phân trang)
  Future<Result> getCars({
    String? status,
    int? pageSize,
    String? pageToken,
  }) {
    final query = {
      if (status != null) 'status': status,
      if (pageSize != null) 'pageSize': pageSize,
      if (pageToken != null) 'pageToken': pageToken,
    };
    return _client.get(ApiEndpoint.cars, query: query);
  }

  /// Lấy toàn bộ xe (ẩn soft-delete)
  Future<Result> getAllCars({String? sort}) {
    final query = {if (sort != null) 'sort': sort};
    return _client.get(ApiEndpoint.allCars, query: query);
  }

  /// Lấy chi tiết xe
  Future<Result> getCarDetail(int carId) {
    return _client.get(ApiEndpoint.carDetail(carId));
  }

  /// Tạo xe mới
  Future<Result> createCar(CarModel car) {
    return _client.post(
      ApiEndpoint.cars,
      data: car.toJson(),
    );
  }

  /// Cập nhật xe
  Future<Result> updateCar(int carId, CarModel car) {
    return _client.put(
      ApiEndpoint.carDetail(carId),
      data: car.toJson(),
    );
  }

  /// Xoá mềm xe
  Future<Result> deleteCar(int carId) {
    return _client.delete(ApiEndpoint.carDetail(carId));
  }

  /// Danh sách xe đã bán (+ tổng giá trị, lợi nhuận)
  Future<Result> getSoldCars({int? pageSize, String? pageToken}) {
    final query = {
      if (pageSize != null) 'pageSize': pageSize,
      if (pageToken != null) 'pageToken': pageToken,
    };
    return _client.get(ApiEndpoint.carsSold, query: query);
  }

  /// Danh sách xe đang ở showroom
  Future<Result> getShowroomCars() {
    return _client.get(ApiEndpoint.carsShowroom);
  }

  /// Tìm kiếm xe theo name / plate / status
  /// - Nếu [all] = true -> trả toàn bộ (bỏ phân trang)
  Future<Result> searchCars({
    String? name,
    String? plate,
    String? status,
    bool? all,
    int? pageSize,
    String? pageToken,
  }) {
    final query = {
      if (name != null) 'name': name,
      if (plate != null) 'plate': plate,
      if (status != null) 'status': status,
      if (all != null) 'all': all,
      if (pageSize != null) 'pageSize': pageSize,
      if (pageToken != null) 'pageToken': pageToken,
    };
    return _client.get(ApiEndpoint.carsSearch, query: query);
  }

  /// Lấy dữ liệu biểu đồ (line/bar) – bắt buộc phải truyền [year]
  Future<Result> getCharts({required int year}) {
    return _client.get(
      ApiEndpoint.carsCharts,
      query: {'year': year},
    );
  }
  

  /// Bảng lợi nhuận dạng ma trận
  Future<Result> getProfitMatrix({int? year, int? month}) {
    final query = {
      if (year != null) 'year': year,
      if (month != null) 'month': month,
    };
    return _client.get(ApiEndpoint.carsProfitMatrix, query: query);
  }

  /// Top 5 thương hiệu lợi nhuận cao nhất
  Future<Result> getTopBrands() {
    return _client.get(ApiEndpoint.carsTopBrands);
  }

  /// Top 5 sản phẩm lợi nhuận cao nhất
  Future<Result> getTopProducts() {
    return _client.get(ApiEndpoint.carsTopProducts);
  }

  /// Top 5 xe lợi nhuận cao nhất
  Future<Result> getTopProfit() {
    return _client.get(ApiEndpoint.carsTopProfit);
  }

  /// Top 5 xe giá trị cao nhất
  Future<Result> getTopValue() {
    return _client.get(ApiEndpoint.carsTopValue);
  }

  /// Top 5 xe bán gần đây
  Future<Result> getTopRecent() {
    return _client.get(ApiEndpoint.carsTopRecent);
  }
}
