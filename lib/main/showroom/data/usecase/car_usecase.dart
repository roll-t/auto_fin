import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/data/model/list_model.dart';
import 'package:auto_find/main/showroom/data/model/profit_matrix_response_model.dart';
import 'package:auto_find/main/showroom/data/model/showroom_cars_model.dart';
import 'package:auto_find/main/showroom/data/model/sold_cars_model.dart';
import 'package:auto_find/main/showroom/data/repositories/car_repository.dart';

class CarUsecase {
  final CarRepository _repo;
  CarUsecase(this._repo);

  /// Danh sách xe (có thể lọc theo [status], phân trang)
  Future<ListModel<CarModel>> getCars({
    String? status,
    int pageSize = 20,
    String? pageToken,
  }) {
    return _repo.getCars(
      status: status,
      pageSize: pageSize,
      pageToken: pageToken,
    );
  }

  /// Lấy toàn bộ xe (ẩn soft-delete)
  Future<List<CarModel>> getAllCars({String? sort}) {
    return _repo.getAllCars(sort: sort);
  }

  /// Lấy chi tiết xe
  Future<CarModel> getCarDetail(int id) {
    return _repo.getCarDetail(id);
  }

  /// Tạo xe mới
  Future<void> createCar(CarModel car) {
    return _repo.createCar(car);
  }

  /// Cập nhật xe
  Future<void> updateCar(CarModel car) {
    return _repo.updateCar(car);
  }

  /// Xoá mềm xe
  Future<void> deleteCar(int id) {
    return _repo.deleteCar(id);
  }

  /// Tìm kiếm xe
  Future<ListModel<CarModel>> searchCars({
    String? name,
    String? plate,
    String? status,
    bool all = false,
    int pageSize = 20,
    String? pageToken,
  }) {
    return _repo.searchCars(
      name: name,
      plate: plate,
      status: status,
      all: all,
      pageSize: pageSize,
      pageToken: pageToken,
    );
  }

  /// Danh sách xe trong showroom (không phân trang)
  Future<ShowroomCarsModel> getShowroomCars() {
    return _repo.getShowroomCars();
  }

  /// Trả về danh sách xe đã bán từ repo
  Future<SoldCarsModel> call({
    int? pageSize,
    String? pageToken,
  }) {
    return _repo.getSoldCars(
      pageSize: pageSize,
      pageToken: pageToken,
    );
  }

  /// Dữ liệu biểu đồ line/bar
  Future<Map<String, dynamic>> getCharts(int year) {
    return _repo.getCharts(year: year);
  }

  /// Ma trận lợi nhuận
  Future<ProfitMatrixResponseModel> getProfitMatrix({int? year, int? month}) {
    return _repo.getProfitMatrix(year: year, month: month);
  }

  /// Top 5 thương hiệu lợi nhuận cao nhất
  Future<List<dynamic>> getTopBrands() {
    return _repo.getTopBrands();
  }

  /// Top 5 sản phẩm lợi nhuận cao nhất
  Future<List<dynamic>> getTopProducts() {
    return _repo.getTopProducts();
  }

  /// Top 5 xe lợi nhuận cao nhất
  Future<List<dynamic>> getTopProfit() {
    return _repo.getTopProfit();
  }

  /// Top 5 xe có giá trị cao nhất
  Future<List<dynamic>> getTopValue() {
    return _repo.getTopValue();
  }

  /// Top 5 xe bán gần đây
  Future<List<dynamic>> getTopRecent() {
    return _repo.getTopRecent();
  }
}
