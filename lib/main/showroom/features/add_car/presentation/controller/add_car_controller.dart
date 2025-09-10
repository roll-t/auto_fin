import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/extension/datetime.dart';
import 'package:auto_find/core/extension/number_extensions.dart';
import 'package:auto_find/core/utils/keyboard_utils.dart';
import 'package:auto_find/main/showroom/controller/dropdown_data_car_feature_controller.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/data/usecase/car_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_find/core/model/ui/item_model.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:auto_find/core/ui/widgets/dialogs/dialog_utils.dart';

class AddCarController extends GetxController {
  final CarUsecase _carUsecase;
  final DropdownDataCarFeatureController _dropdownDataCarFeatureController;

  AddCarController(
    this._carUsecase,
    this._dropdownDataCarFeatureController,
  );

  /// 🏷 TextEditingController
  final nameController = TextEditingController();
  final plateController = TextEditingController();
  final yearController = TextEditingController();
  final buyDateController =
      TextEditingController(text: DateTime.now().toString().toVNDate());
  final buyPriceController = TextEditingController();
  final buyCostController = TextEditingController();
  final sellPriceController = TextEditingController();

  /// 🏷 BottomSheetController giữ nguyên
  final brandController = BottomSheetController(listItem: <ItemModel>[].obs);
  final typeController = BottomSheetController(listItem: <ItemModel>[].obs);
  final colorController = BottomSheetController(listItem: <ItemModel>[].obs);
  final modelController = BottomSheetController(listItem: <ItemModel>[].obs);
  final statusController = BottomSheetController(listItem: <ItemModel>[].obs);

  /// 🏷 Selected item
  final selectedBrand = Rxn<ItemModel>();
  final selectedType = Rxn<ItemModel>();
  final selectedColor = Rxn<ItemModel>();
  final selectedModel = Rxn<ItemModel>();
  final selectedStatus = Rxn<ItemModel>();

  @override
  Future<void> onReady() async {
    DialogUtils.showProgressDialog();
    await initDropdownData();
    Get.back();
  }

  /// 🏷 Load dropdown data từ controller chung
  Future<void> initDropdownData() async {
    if (_dropdownDataCarFeatureController.brandList.isEmpty ||
        _dropdownDataCarFeatureController.typeCarList.isEmpty ||
        _dropdownDataCarFeatureController.colorList.isEmpty) {
      // Lần đầu vào -> load API
      await _dropdownDataCarFeatureController.loadAllDropdown();
    }

    brandController.listItem
        .assignAll(_dropdownDataCarFeatureController.brandList);
    typeController.listItem
        .assignAll(_dropdownDataCarFeatureController.typeCarList);
    colorController.listItem
        .assignAll(_dropdownDataCarFeatureController.colorList);
    modelController.listItem
        .assignAll(_dropdownDataCarFeatureController.modelList);
    statusController.listItem
        .assignAll(_dropdownDataCarFeatureController.statusList);
  }

  /// 🧾 Validate dữ liệu trước khi thêm
  bool validateForm() {
    final currentYear = DateTime.now().year;

    if (nameController.text.trim().isEmpty) {
      DialogUtils.showAlert(
          alertType: AlertType.error, content: "Vui lòng nhập tên xe");
      return false;
    }
    if (plateController.text.trim().isEmpty) {
      DialogUtils.showAlert(
          alertType: AlertType.error, content: "Vui lòng nhập biển số");
      return false;
    }
    final year = int.tryParse(yearController.text);
    if (yearController.text.trim().isEmpty ||
        year == null ||
        year > currentYear) {
      DialogUtils.showAlert(
          alertType: AlertType.error,
          content: "Năm sản xuất phải là số và ≤ $currentYear");
      return false;
    }
    final buyPrice = buyPriceController.text.toCurrencyDouble();
    if (buyPriceController.text.trim().isEmpty || buyPrice <= 0) {
      DialogUtils.showAlert(
          alertType: AlertType.error, content: "Giá mua phải > 0");
      return false;
    }
    if (selectedBrand.value == null) {
      DialogUtils.showAlert(
          alertType: AlertType.error, content: "Vui lòng chọn hãng xe");
      return false;
    }
    if (selectedType.value == null) {
      DialogUtils.showAlert(
          alertType: AlertType.error, content: "Vui lòng chọn loại xe");
      return false;
    }
    return true;
  }

  /// 🏷 Thêm xe
  Future<void> addCar() async {
    KeyboardUtils.hiddenKeyboard();
    if (!validateForm()) return;

    try {
      final newCar = CarModel(
        name: nameController.text.trim(),
        plate: plateController.text.trim(),
        releaseYear: yearController.text,
        importDate: buyDateController.text.isNotEmpty
            ? DateTime.tryParse(buyDateController.text)
            : DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        deletedAt: null,
        isDeleted: false,
        brand: selectedBrand.value?.title ?? "",
        type: selectedType.value?.title ?? "",
        color: selectedColor.value?.title ?? "",
        status: selectedStatus.value?.title ?? "",
        // Giá & chi phí
        importPrice:
            double.tryParse(buyPriceController.text.replaceAll(',', '')) ?? 0,
        importCost:
            double.tryParse(buyCostController.text.replaceAll(',', '')) ?? 0,
        price:
            double.tryParse(sellPriceController.text.replaceAll(',', '')) ?? 0,

        // Optional
        product: selectedModel.value?.title ?? "",
        des: "", // bạn có thể thêm TextController mô tả xe
        profit: 0,
        soldCost: 0,
        soldDate: null,
        soldDes: "",
        soldPrice: 0,
      );

      await _carUsecase.createCar(newCar);

      clearForm();
    } catch (e) {
      Get.back();
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Không thể thêm xe: $e",
      );
    }
  }

  /// Clear form (nếu muốn dùng)
  void clearForm() {
    nameController.clear();
    plateController.clear();
    yearController.clear();
    buyDateController.clear();
    buyPriceController.clear();
    buyCostController.clear();
    sellPriceController.clear();

    selectedBrand.value = null;
    selectedType.value = null;
    selectedColor.value = null;
    selectedModel.value = null;
    selectedStatus.value = null;
  }

  @override
  void onClose() {
    nameController.dispose();
    plateController.dispose();
    yearController.dispose();
    buyDateController.dispose();
    buyPriceController.dispose();
    buyCostController.dispose();
    sellPriceController.dispose();
    brandController.dispose();
    typeController.dispose();
    colorController.dispose();
    modelController.dispose();
    statusController.dispose();
    super.onClose();
  }
}
