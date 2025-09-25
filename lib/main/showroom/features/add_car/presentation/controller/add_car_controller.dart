import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/extension/datetime.dart';
import 'package:auto_find/core/extension/currency_extensions.dart';
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

  /// 🧾 Validate dữ liệu trước khi thêm xe
  bool validateForm() {
    final currentYear = DateTime.now().year;

    // 1️⃣ Hãng xe
    if (selectedBrand.value == null) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Vui lòng chọn hãng xe",
      );
      return false;
    }

    // 2️⃣ Loại xe
    if (selectedType.value == null) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Vui lòng chọn loại xe",
      );
      return false;
    }

    // 3️⃣ Mẫu xe (optional → bỏ qua nếu không bắt buộc)

    // 4️⃣ Năm sản xuất
    final yearText = yearController.text.trim();
    final year = int.tryParse(yearText);
    if (yearText.isEmpty || year == null || year > currentYear) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Năm sản xuất phải là số và ≤ $currentYear",
      );
      return false;
    }

    // 5️⃣ Tên xe
    if (nameController.text.trim().isEmpty) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Vui lòng nhập tên xe",
      );
      return false;
    }

    // 8️⃣ Trạng thái xe (nếu bắt buộc)
    if (selectedStatus.value == null) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Vui lòng chọn trạng thái xe",
      );
      return false;
    }

    // 9️⃣ Giá niêm yết bán (không bắt buộc → bỏ qua nếu rỗng)

    // 🔟 Giá mua
    final buyPrice = buyPriceController.text.toCurrencyNum();
    if (buyPriceController.text.trim().isEmpty || buyPrice <= 0) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Giá mua phải > 0",
      );
      return false;
    }

    // 1️⃣1️⃣ Chi phí mua (optional → không kiểm tra nếu không bắt buộc)

    return true;
  }

  void onRecommendNameCar() {
    final parts = <String>[
      selectedBrand.value?.title ?? '',
      selectedModel.value?.title ?? '',
      yearController.text,
      "test"
    ];

    // Lọc bỏ chuỗi rỗng rồi join lại
    final nameCar = parts.where((e) => e.isNotEmpty).join(' ');

    if (nameCar.isNotEmpty) {
      nameController.text = nameCar;
    }
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
        importDate: buyDateController.text.toIsoUtcDateTime(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        deletedAt: null,
        isDeleted: false,
        brand: selectedBrand.value?.title ?? "",
        type: selectedType.value?.title ?? "",
        color: selectedColor.value?.title ?? "",
        status: selectedStatus.value?.title ?? "",
        
        // Giá & chi phí
        importPrice: buyPriceController.text.toCurrencyNum().toDouble(),
        importCost: buyCostController.text.toCurrencyNum().toDouble(),
        price: sellPriceController.text.toCurrencyNum().toDouble(),

        // Optional
        product: selectedModel.value?.title ?? "",
        des: "",
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
