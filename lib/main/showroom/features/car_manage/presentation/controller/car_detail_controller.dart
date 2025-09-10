import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/config/const/app_logger.dart';
import 'package:auto_find/core/extension/datetime.dart';
import 'package:auto_find/core/extension/empty_extension.dart';
import 'package:auto_find/core/extension/number_extensions.dart';
import 'package:auto_find/core/model/ui/item_model.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/select_bottom_sheet_widget.dart';
import 'package:auto_find/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:auto_find/core/ui/widgets/expand/expand_controller.dart';
import 'package:auto_find/core/utils/keyboard_utils.dart';
import 'package:auto_find/core/utils/mixin_controller/argument_handle_mixin_controller.dart';
import 'package:auto_find/core/utils/time_utils.dart';
import 'package:auto_find/main/showroom/controller/dropdown_data_car_feature_controller.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/data/usecase/car_usecase.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CarDetailController extends GetxController
    with ArgumentHandlerMixinController<CarModel> {
  final CarUsecase _carUsecase;
  final DropdownDataCarFeatureController _dropdownDataCarFeatureController;

  CarDetailController(
    this._dropdownDataCarFeatureController,
    this._carUsecase,
  );

  Rxn<CarModel> carDetail = Rxn<CarModel>();
  RxBool isLoading = true.obs;
  RxBool isEditMode = false.obs;

  /// UI expand controllers
  final expandInformation = ExpandController();
  final expandVehicle = ExpandController();

  /// --------- TextEditingController cho từng field trong UI ----------
  final nameController = TextEditingController(); // tên xe
  final plateController = TextEditingController(); // biển số
  final releaseYearController = TextEditingController(); // năm sx
  final priceController = TextEditingController(); // giá niêm yết bán
  final profitController = TextEditingController(); // lợi nhuận

  // mua
  final importDateController = TextEditingController();
  final importPriceController = TextEditingController();
  final importCostController = TextEditingController();

  // bán
  final soldDateController = TextEditingController();
  final soldPriceController = TextEditingController();
  final soldCostController = TextEditingController();

  // Dropdown (hãng xe, loại xe, màu xe, mẫu xe, trạng thái)
  Rx<ItemModel> selectedBrand = ItemModel().obs;
  Rx<ItemModel> selectedTypeCar = ItemModel().obs;
  Rx<ItemModel> selectedColor = ItemModel().obs;

  RxString selectedModel = ''.obs;
  RxString selectedStatus = ''.obs;

  // 🔽 Thêm controller cho dropdown
  final brandController = TextEditingController();
  final typeCarController = TextEditingController();
  final colorController = TextEditingController();
  final modelController = TextEditingController();
  final statusController = TextEditingController();

  @override
  void onReady() {
    initializedData();
  }

  void initializedData() {
    bool hasArg = handleArgumentFromGet();
    if (!hasArg) return;
    fetchCarDetail(argsData?.id ?? 0);
  }

  /// Gọi API lấy chi tiết xe
  Future<void> fetchCarDetail(int id) async {
    try {
      isLoading.value = true;
      final car = await _carUsecase.getCarDetail(id);
      carDetail.value = car;

      /// ---- Fill dữ liệu vào controller ----
      nameController.text = car.name.orEmpty();
      plateController.text = car.plate.orEmpty();
      releaseYearController.text = car.releaseYear.toString();

      priceController.text = (car.price ?? 0).toString().toCurrency();
      profitController.text = (car.profit ?? 0).toString().toCurrency();

      importDateController.text = car.importDate.toString().toVNDate();
      importPriceController.text =
          (car.importPrice ?? 0).toString().toCurrency();
      importCostController.text = (car.importCost ?? 0).toString().toCurrency();

      soldDateController.text = (car.soldDate ?? "").toString().toVNDate();
      soldPriceController.text = (car.soldPrice ?? 0).toString().toCurrency();
      soldCostController.text = (car.soldCost ?? 0).toString().toCurrency();

      // ---- Fill dropdown ----
      selectedBrand.value = ItemModel(title: car.brand);
      brandController.text = (selectedBrand.value.title).orEmpty();

      selectedColor.value = ItemModel(title: car.color);
      colorController.text = (selectedColor.value.title).orNA();

      selectedTypeCar.value = ItemModel(title: car.type.orNA());
      typeCarController.text = (selectedTypeCar.value.title).orNA();

      selectedModel.value = car.product.orNA();
      modelController.text = selectedModel.value;

      selectedStatus.value = car.status.orNA();
      statusController.text = selectedStatus.value;
    } catch (e) {
      AppLogger.e("❌ Lỗi khi fetchCarDetail: $e");
      Get.snackbar("Lỗi", "Không thể lấy thông tin xe");
    } finally {
      isLoading.value = false;
      update(["FORM_ID"]);
    }
  }

  void toggleEditMode() async {
    DialogUtils.showProgressDialog();
    await _dropdownDataCarFeatureController.loadAllDropdown();
    Get.back();

    if (!TimeUtils.canPerformAction(cooldownMs: 500)) return;
    Fluttertoast.showToast(
      msg: isEditMode.value ? "Tắt chế độ chỉnh sửa" : "Bật chế độ chỉnh sửa",
    );
    isEditMode.value = !isEditMode.value;
    update([
      "EDIT_ICON_ID",
      "FORM_ID",
    ]);
  }

  /// Chọn dropdown
  void showSelectBottomSheet({
    required String title,
    required List<ItemModel> list,
    required void Function(ItemModel item) onSelected,
  }) {
    SelectBottomSheet.show(
      title: title,
      items: list.map((e) => e).toList(),
      onSelected: onSelected,
    );
  }

  void showBrandBottomSheet() => showSelectBottomSheet(
        title: "Chọn hãng xe",
        list: _dropdownDataCarFeatureController.brandList,
        onSelected: (item) {
          selectedBrand.value = item;
          brandController.text = (selectedBrand.value.title).orNA();
        },
      );

  /// BottomSheet chọn loại xe
  void showTypeCarBottomSheet() => showSelectBottomSheet(
        title: "Chọn loại xe",
        list: _dropdownDataCarFeatureController
            .typeCarList, // 🔹 dùng list từ API
        onSelected: (item) {
          selectedTypeCar.value = item;
          typeCarController.text = (selectedTypeCar.value.title).orNA();
        },
      );

  void showColorBottomSheet() => showSelectBottomSheet(
        title: "Chọn màu xe",
        list: _dropdownDataCarFeatureController.colorList,
        onSelected: (item) {
          selectedColor.value = item;
          colorController.text = (selectedColor.value.title).orNA();
        },
      );

  void showModelBottomSheet() => showSelectBottomSheet(
        title: "Chọn mẫu xe",
        list: _dropdownDataCarFeatureController.modelList,
        onSelected: (item) {
          selectedModel.value = item.title.orNA();
          modelController.text = selectedModel.value;
        },
      );

  void showStatusBottomSheet() => showSelectBottomSheet(
        title: "Chọn trạng thái xe",
        list: _dropdownDataCarFeatureController.statusList,
        onSelected: (item) {
          selectedStatus.value = item.title.orNA();
          statusController.text = selectedStatus.value;
        },
      );

  /// Cập nhật thông tin cơ bản của xe
  Future<void> updateCarInfo() async {
    KeyboardUtils.hiddenKeyboard();

    // ✅ Thêm validate trước khi xử lý
    if (!validateCarInfo()) return;

    try {
      final currentCar = carDetail.value;
      if (currentCar == null) return;

      final updatedCar = currentCar.copyWith(
        name: nameController.text,
        plate: plateController.text,
        releaseYear: releaseYearController.text,
        brand: selectedBrand.value.title,
        type: selectedTypeCar.value.title,
        color: selectedColor.value.title,
        product: selectedModel.value,
        status: selectedStatus.value,
        price: double.tryParse(priceController.text),
        profit: double.tryParse(profitController.text),
        des: currentCar.des,
      );

      // 🔍 So sánh dữ liệu cũ và mới
      if (updatedCar.toJson().toString() == currentCar.toJson().toString()) {
        Fluttertoast.showToast(msg: "Nội dung không có gì thay đổi");
        return;
      }

      await _carUsecase.updateCar(updatedCar);
      carDetail.value = updatedCar;
      update(["FORM_ID"]);
    } catch (e) {
      AppLogger.e("❌ updateCarInfo error: $e");
    }
  }

  /// Cập nhật thông tin mua bán xe
  Future<void> updateTransactionInfo() async {
    KeyboardUtils.hiddenKeyboard();

    // ✅ Thêm validate trước khi xử lý
    if (!validateTransactionInfo()) return;

    try {
      final currentCar = carDetail.value;
      if (currentCar == null) return;

      final updatedCar = currentCar.copyWith(
        importDate: DateTime.tryParse(importDateController.text),
        importPrice: double.tryParse(importPriceController.text),
        importCost: double.tryParse(importCostController.text),
        soldDate: DateTime.tryParse(soldDateController.text),
        soldPrice: double.tryParse(soldPriceController.text),
        soldCost: double.tryParse(soldCostController.text),
        soldDes: currentCar.soldDes,
        profit: double.tryParse(profitController.text),
      );

      // 🔍 So sánh dữ liệu cũ và mới
      if (updatedCar.toJson().toString() == currentCar.toJson().toString()) {
        Fluttertoast.showToast(msg: "Nội dung không có gì thay đổi");
        return;
      }

      await _carUsecase.updateCar(updatedCar);
      carDetail.value = updatedCar;
      update(["FORM_ID"]);
    } catch (e) {
      AppLogger.e("❌ updateTransactionInfo error: $e");
    }
  }

  /// ---------------- VALIDATION ----------------
  /// ✅ Validate thông tin cơ bản xe
  bool validateCarInfo() {
    if (nameController.text.isEmpty) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Tên xe không được để trống",
      );
      return false;
    }

    if (plateController.text.isEmpty) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Biển số xe không được để trống",
      );
      return false;
    }

    if (releaseYearController.text.isEmpty ||
        int.tryParse(releaseYearController.text) == null) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Năm sản xuất không hợp lệ",
      );
      return false;
    }

    if (selectedBrand.value.title?.isEmpty ?? false) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Vui lòng chọn hãng xe",
      );
      return false;
    }

    if (selectedTypeCar.value.title?.isEmpty ?? false) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Vui lòng chọn loại xe",
      );
      return false;
    }

    if (priceController.text.isEmpty ||
        double.tryParse(priceController.text) == null) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Giá niêm yết không hợp lệ",
      );
      return false;
    }

    return true;
  }

  /// ✅ Validate thông tin mua bán xe
  bool validateTransactionInfo() {
    if (importDateController.text.isEmpty) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Ngày mua không được để trống",
      );
      return false;
    }

    if (importPriceController.text.isEmpty ||
        double.tryParse(importPriceController.text) == null) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Giá mua không hợp lệ",
      );
      return false;
    }

    if (importCostController.text.isEmpty ||
        double.tryParse(importCostController.text) == null) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: "Chi phí mua không hợp lệ",
      );
      return false;
    }

    // Nếu đã có ngày bán thì validate luôn giá bán & chi phí bán
    if (soldDateController.text.isNotEmpty) {
      if (soldPriceController.text.isEmpty ||
          double.tryParse(soldPriceController.text) == null) {
        DialogUtils.showAlert(
          alertType: AlertType.error,
          content: "Giá bán không hợp lệ",
        );
        return false;
      }

      if (soldCostController.text.isEmpty ||
          double.tryParse(soldCostController.text) == null) {
        DialogUtils.showAlert(
          alertType: AlertType.error,
          content: "Chi phí bán không hợp lệ",
        );
        return false;
      }
    }

    return true;
  }

  @override
  void onClose() {
    expandInformation.dispose();
    expandVehicle.dispose();
    nameController.dispose();
    plateController.dispose();
    releaseYearController.dispose();
    priceController.dispose();
    profitController.dispose();
    importDateController.dispose();
    importPriceController.dispose();
    importCostController.dispose();
    soldDateController.dispose();
    soldPriceController.dispose();
    soldCostController.dispose();

    brandController.dispose();
    typeCarController.dispose();
    colorController.dispose();
    modelController.dispose();
    statusController.dispose();

    super.onClose();
  }
}
