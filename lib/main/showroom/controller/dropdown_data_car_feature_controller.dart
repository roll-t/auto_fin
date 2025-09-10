import 'package:auto_find/core/config/const/app_logger.dart';
import 'package:auto_find/core/model/ui/item_model.dart';
import 'package:auto_find/main/showroom/data/usecase/brand_product_usecase.dart';
import 'package:auto_find/main/showroom/data/usecase/color_uscase.dart';
import 'package:auto_find/main/showroom/data/usecase/type_car_usecase.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class DropdownDataCarFeatureController extends GetxController {
  final BrandProductUsecase _brandUsecase;
  final TypeCarUsecase _typeCarUsecase;
  final ColorUsecase _colorUsecase;

  DropdownDataCarFeatureController(
    this._brandUsecase,
    this._typeCarUsecase,
    this._colorUsecase,
  );

  final brandList = <ItemModel>[];
  final typeCarList = <ItemModel>[];
  final colorList = <ItemModel>[];

  final List<ItemModel> modelList = [
    ItemModel(id: "pickup_truck", title: "Pickup Truck"),
    ItemModel(id: "mpv", title: "MPV"),
    ItemModel(id: "hatchback", title: "Hatchback"),
    ItemModel(id: "sedan", title: "Sedan"),
    ItemModel(id: "suv", title: "SUV"),
  ];

  final List<ItemModel> statusList = [
    ItemModel(id: "new", title: "Xe mới nhập"),
    ItemModel(id: "cleaning", title: "Xe đem đi dọn"),
    ItemModel(id: "reserved", title: "Xe đã cọc"),
    ItemModel(id: "showroom", title: "Xe đang ở Auto"),
    ItemModel(id: "sold", title: "Xe đã bán"),
  ];

  final isLoading = false.obs;

  Future<void> loadAllDropdown() async {
    if (brandList.isNotEmpty ||
        typeCarList.isNotEmpty ||
        colorList.isNotEmpty) {
      return;
    }
    try {
      isLoading.value = true;
      await Future.wait([
        fetchBrands(),
        fetchTypes(),
        fetchColors(),
      ]);
    } catch (e) {
      AppLogger.e("❌ loadAllDropdown error: $e");
      Fluttertoast.showToast(msg: "Không thể tải dữ liệu dropdown");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchBrands() async {
    try {
      final list = await _brandUsecase.getAllBrands();
      brandList.assignAll(list.map((e) => e.toItemModel()));
    } catch (e) {
      AppLogger.e("❌ fetchBrands error: $e");
      Fluttertoast.showToast(msg: "Không thể tải danh sách hãng xe");
    }
  }

  Future<void> fetchTypes() async {
    try {
      final list = await _typeCarUsecase.getAllTypes();
      typeCarList.assignAll(list.map((e) => e.toItemModel()));
    } catch (e) {
      AppLogger.e("❌ fetchTypes error: $e");
      Fluttertoast.showToast(msg: "Không thể tải danh sách loại xe");
    }
  }

  Future<void> fetchColors() async {
    try {
      final list = await _colorUsecase.getAllColors();
      colorList.assignAll(list.map((e) => e.toItemModel()));
    } catch (e) {
      AppLogger.e("❌ fetchColors error: $e");
      Fluttertoast.showToast(msg: "Không thể tải danh sách màu");
    }
  }
}
