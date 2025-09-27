import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/extension/core/currency_extensions.dart';
import 'package:auto_find/core/extension/core/date_extensions.dart';
import 'package:auto_find/core/model/ui/item_model.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:auto_find/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:auto_find/core/utils/keyboard_utils.dart';

import 'package:auto_find/main/showroom/controller/dropdown_data_car_feature_controller.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/data/usecase/car_usecase.dart';

class AddCarController extends GetxController {
  final CarUsecase _carUsecase;
  final DropdownDataCarFeatureController _dropdownDataCarFeatureController;

  AddCarController(
    this._carUsecase,
    this._dropdownDataCarFeatureController,
  );

  // ----------------------------
  // 🏷 TextEditingController
  // ----------------------------
  final nameController = TextEditingController();
  final plateController = TextEditingController();
  final yearController = TextEditingController();
  final buyPriceController = TextEditingController();
  final buyCostController = TextEditingController();
  final sellPriceController = TextEditingController();
  final desController = TextEditingController();
  final buyDateController = TextEditingController(text: DateTime.now().toString().toVNDate());
  final soldDesController = TextEditingController();

  // Bán
  final soldDateController = TextEditingController();
  final soldPriceController = TextEditingController();
  final soldCostController = TextEditingController();

  // ----------------------------
  // 🏷 BottomSheetController
  // ----------------------------
  final brandController = BottomSheetController(listItem: <ItemModel>[].obs);
  final typeController = BottomSheetController(listItem: <ItemModel>[].obs);
  final colorController = BottomSheetController(listItem: <ItemModel>[].obs);
  final modelController = BottomSheetController(listItem: <ItemModel>[].obs);
  final statusController = BottomSheetController(listItem: <ItemModel>[].obs);

  // ----------------------------
  // 🏷 Selected item
  // ----------------------------
  final selectedBrand = Rxn<ItemModel>();
  final selectedType = Rxn<ItemModel>();
  final selectedColor = Rxn<ItemModel>();
  final selectedModel = Rxn<ItemModel>();
  final selectedStatus = Rxn<ItemModel>();

  // ----------------------------
  // Lifecycle
  // ----------------------------
  @override
  Future<void> onReady() async {
    DialogUtils.showProgressDialog();
    await initDropdownData();
    Get.back();
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
    soldDateController.dispose();
    soldPriceController.dispose();
    soldCostController.dispose();
    brandController.dispose();
    typeController.dispose();
    colorController.dispose();
    modelController.dispose();
    statusController.dispose();
    super.onClose();
  }

  // ----------------------------
  // Init dropdown
  // ----------------------------
  Future<void> initDropdownData() async {
    if (_dropdownDataCarFeatureController.brandList.isEmpty ||
        _dropdownDataCarFeatureController.typeCarList.isEmpty ||
        _dropdownDataCarFeatureController.colorList.isEmpty) {
      await _dropdownDataCarFeatureController.loadAllDropdown();
    }

    brandController.listItem.assignAll(_dropdownDataCarFeatureController.brandList);
    typeController.listItem.assignAll(_dropdownDataCarFeatureController.typeCarList);
    colorController.listItem.assignAll(_dropdownDataCarFeatureController.colorList);
    modelController.listItem.assignAll(_dropdownDataCarFeatureController.modelList);
    statusController.listItem.assignAll(_dropdownDataCarFeatureController.statusList);
  }

  // ----------------------------
  // Validate
  // ----------------------------
  bool validateForm() {
    final currentYear = DateTime.now().year;
    String messErrorValidate = "";

    if (selectedBrand.value == null) {
      messErrorValidate = "Vui lòng chọn hãng xe";
      return _showError(messErrorValidate);
    }

    if (selectedModel.value == null) {
      messErrorValidate = "Vui lòng chọn mẫu xe";
      return _showError(messErrorValidate);
    }

    final yearText = yearController.text.trim();
    final year = int.tryParse(yearText);

    if (yearText.isEmpty || year == null || year > currentYear) {
      messErrorValidate = "Năm sản xuất phải là số và ≤ $currentYear";
      return _showError(messErrorValidate);
    }

    if (nameController.text.trim().isEmpty) {
      messErrorValidate = "Vui lòng nhập tên xe";
      return _showError(messErrorValidate);
    }

    if (selectedStatus.value == null) {
      messErrorValidate = "Vui lòng chọn trạng thái xe";
      return _showError(messErrorValidate);
    } 

    if (selectedStatus.value?.id == "sold") {
      if (soldDateController.text.isEmpty) {
        messErrorValidate = "Không được bỏ trống ngày bán";
        return _showError(messErrorValidate);
      }

      final soldPrice = double.tryParse(
            soldPriceController.text
                .toCurrencyNum()
                .toString()
                .replaceAll(",", "")
                .trim(),
          ) ??
          0;

      if (soldPrice <= 0) {
        messErrorValidate = "Giá bán không hợp lệ";
        return _showError(messErrorValidate);
      }
    }

    final sellPrice = sellPriceController.text.toCurrencyNum();
    if (sellPriceController.text.trim().isEmpty || sellPrice <= 0) {
      messErrorValidate = "Giá nêm yết phải > 0";
      return _showError(messErrorValidate);
    }
    final buyPrice = buyPriceController.text.toCurrencyNum();
    if (buyPriceController.text.trim().isEmpty || buyPrice <= 0) {
      messErrorValidate = "Giá mua phải > 0";
      return _showError(messErrorValidate);
    }

    return true;
  }

  bool _showError(String message) {
    if (message.isNotEmpty) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: message,
      );
    }
    return false;
  }

  // ----------------------------
  // Actions
  // ----------------------------
  void onSelectedStatus(ItemModel item) {
    selectedStatus.value = item;
    soldDateController.text = DateTime.now().toString().toVNDate();
    update(['SALES_INFO_ID']);
  }

  void onRecommendNameCar() {
    final parts = <String>[
      selectedBrand.value?.title ?? '',
      selectedModel.value?.title ?? '',
      yearController.text,
      "test"
    ];

    final nameCar = parts.where((e) => e.isNotEmpty).join(' ');
    if (nameCar.isNotEmpty) {
      nameController.text = nameCar;
    }
  }

  Future<void> addCar() async {
    KeyboardUtils.hiddenKeyboard();
    if (!validateForm()) return;

    if (selectedStatus.value?.id != "sold" &&
        selectedStatus.value?.title?.trim() != "Xe đã bán") {
      soldDateController.text = "";
      soldPriceController.text = "0";
      soldCostController.text = "0";
    }

    try {
      final newCar = CarModel(
        name: nameController.text.trim(),
        plate: plateController.text.trim(),
        releaseYear: yearController.text,
        importDate: buyDateController.text.toIsoUtcDateTime(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        brand: selectedBrand.value?.title ?? "",
        type: selectedType.value?.title ?? "",
        color: selectedColor.value?.title ?? "",
        status: selectedStatus.value?.title ?? "",
        importPrice: buyPriceController.text.toCurrencyNum().toDouble(),
        importCost: buyCostController.text.toCurrencyNum().toDouble(),
        price: sellPriceController.text.toCurrencyNum().toDouble(),
        product: selectedModel.value?.title ?? "",
        des: desController.text.trim(),
        soldDate: soldDateController.text.toIsoUtcDateTime(),
        soldPrice: soldPriceController.text.toCurrencyNum().toDouble(),
        soldCost: soldCostController.text.toCurrencyNum().toDouble(),
        soldDes: soldDesController.text.trim(),
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

  void clearForm() {
    nameController.clear();
    plateController.clear();
    yearController.clear();
    buyPriceController.clear();
    buyCostController.clear();
    sellPriceController.clear();
    soldPriceController.clear();
    soldCostController.clear();
    desController.clear();
    soldDesController.clear();
    soldDateController.text = DateTime.now().toString().toVNDate();
    buyDateController.text = DateTime.now().toString().toVNDate();

    brandController.itemSelected.value = ItemModel(title: "");
    typeController.itemSelected.value = ItemModel(title: "");
    modelController.itemSelected.value = ItemModel(title: "");
    colorController.itemSelected.value = ItemModel(title: "");
    statusController.itemSelected.value = ItemModel(title: "");

    selectedBrand.value = null;
    selectedType.value = null;
    selectedColor.value = null;
    selectedModel.value = null;
    selectedStatus.value = null;
  }
}
