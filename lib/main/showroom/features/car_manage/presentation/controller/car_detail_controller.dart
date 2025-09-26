import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/config/const/app_logger.dart';
import 'package:auto_find/core/extension/datetime.dart';
import 'package:auto_find/core/extension/empty_extension.dart';
import 'package:auto_find/core/extension/currency_extensions.dart';
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

  Rx<ItemModel> selectedModel = ItemModel().obs;
  Rx<ItemModel> selectedStatus = ItemModel().obs;

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

      selectedModel.value = ItemModel(title: car.product.orNA());
      modelController.text = (selectedModel.value.title).orNA();

      selectedStatus.value = ItemModel(title: car.status.orNA());
      statusController.text = (selectedStatus.value.title).orNA();
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
      "BOTTOM_BAR_ID",
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

  void showTypeCarBottomSheet() => showSelectBottomSheet(
        title: "Chọn loại xe",
        list: _dropdownDataCarFeatureController.typeCarList,
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
          selectedModel.value = item;
          modelController.text = selectedModel.value.title.orEmpty();
        },
      );

  void showStatusBottomSheet() => showSelectBottomSheet(
        title: "Chọn trạng thái xe",
        list: _dropdownDataCarFeatureController.statusList,
        onSelected: (item) {
          selectedStatus.value = item;
          statusController.text = selectedStatus.value.title.orEmpty();
          if (selectedStatus.value.id == "sold") {
            soldDateController.text = DateTime.now().toString().toVNDate();
          } else {
            soldDateController.text = "";
          }
          update(["SALES_INFO_ID"]);
        },
      );

  /// Cập nhật thông tin cơ bản của xe
  /// Cập nhật thông tin xe (gồm cả thông tin cơ bản & giao dịch)
  Future<void> updateCar() async {
    KeyboardUtils.hiddenKeyboard();

    // Validate theo option
    if (!validateCar()) return;

    try {
      final currentCar = carDetail.value;
      if (currentCar == null) return;

      if (selectedStatus.value.id != "sold" &&
          selectedStatus.value.title?.trim() != "Xe đã bán") {
        soldDateController.text = "";
        soldPriceController.text = "0";
        soldCostController.text = "0";
      }

      final updatedCar = currentCar.copyWith(
        // --- Thông tin cơ bản ---
        name: nameController.text,
        plate: plateController.text, // Biển số xe
        releaseYear: releaseYearController.text,
        brand: selectedBrand.value.title, // Hãng xe
        type: selectedTypeCar.value.title, // Loại xe
        color: selectedColor.value.title,
        product: selectedModel.value.title, // Mẫu xe
        status: selectedStatus.value.title, // Trạng thái
        price: priceController.text.toCurrencyNum().toDouble(), // Giá nêm yết
        des: currentCar.des,

        // --- Thông tin giao dịch ---
        // --- Thông tin mua ---
        importDate: importDateController.text.toIsoUtcDateTime(),
        importPrice: importPriceController.text.toCurrencyNum().toDouble(),
        importCost: importCostController.text.toCurrencyNum().toDouble(),

        // --- Thông tin bán ---
        /**
         * Nếu trạng thái xe khác "Xe đã bán" thì dữ liệu các trường này tự reset về rỗng
         * **/
        soldDate: soldDateController.text.toIsoUtcDateTime(),
        soldPrice: soldPriceController.text.toCurrencyNum().toDouble(),
        soldCost: soldCostController.text.toCurrencyNum().toDouble(),
        soldDes: currentCar.soldDes,
      );

      await _carUsecase.updateCar(updatedCar);
      carDetail.value = updatedCar;
      update(["FORM_ID"]);
      refreshData();
    } catch (e) {
      AppLogger.e("❌ updateCar error: $e");
    }
  }

  void onDeleteCar() async {
    try {
      bool isSuccess = await _carUsecase.deleteCar(carDetail.value?.id ?? -1);
      if (isSuccess) {
        Get.back(result: true);
      }
    } catch (e) {
      AppLogger.e(e);
      Get.back(result: false);
    }
  }

  /// ---------------- VALIDATION ----------------
  /// ✅ Validate thông tin cơ bản xe
  /// Validate thông tin xe
  bool validateCar() {
    RxString messErrorValidate = "".obs;
    // --- Validate thông tin cơ bản ---
    if (nameController.text.isEmpty) {
      messErrorValidate.value = "Tên xe không được để trống";
    } else if (releaseYearController.text.isEmpty ||
        int.tryParse(releaseYearController.text) == null) {
      messErrorValidate.value = "Năm sản xuất không hợp lệ";
    } else if (selectedBrand.value.title?.isEmpty ?? true) {
      messErrorValidate.value = "Vui lòng chọn hãng xe";
    } else if (selectedTypeCar.value.title?.isEmpty ?? true) {
      messErrorValidate.value = "Vui lòng chọn loại xe";
    } else if (statusController.text.isEmpty) {
      messErrorValidate.value = "Trạng thái xe không được để trống";
    }

    // --- Validate thông tin giao dịch ---
    if (importDateController.text.isEmpty) {
      messErrorValidate.value = "Ngày mua không được để trống";
    } else if (importPriceController.text.isEmpty) {
      messErrorValidate.value = "Giá mua không hợp lệ";
    }

    if (selectedStatus.value.id == "sold") {
      if (soldDateController.text.isEmpty) {
        messErrorValidate.value = "Không được bỏ trống ngày bán";
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
        messErrorValidate.value = "Giá bán không hợp lệ";
      }
    }

    if (messErrorValidate.value.isNotEmpty) {
      DialogUtils.showAlert(
        alertType: AlertType.error,
        content: messErrorValidate.value,
      );
      return false;
    }

    return true;
  }

  /// Refresh lại dữ liệu chi tiết xe
  Future<void> refreshData() async {
    final id = argsData?.id;
    if (id == null || id == 0) {
      AppLogger.e("❌ refreshData: Không tìm thấy id xe");
      return;
    }
    try {
      isLoading.value = true;
      update(["FORM_ID"]);

      final car = await _carUsecase.getCarDetail(id);
      carDetail.value = car;

      // Gọi fill lại dữ liệu vào controller
      _fillDataToControllers(car);

      Fluttertoast.showToast(msg: "Dữ liệu đã được làm mới");
    } catch (e) {
      AppLogger.e("❌ Lỗi khi refreshData: $e");
      Get.snackbar("Lỗi", "Không thể làm mới dữ liệu xe");
    } finally {
      isLoading.value = false;
      update(["FORM_ID"]);
    }
  }

  /// Đoạn fill dữ liệu mình tách riêng ra để dùng chung
  void _fillDataToControllers(CarModel car) {
    // ---- Fill dữ liệu vào controller ----
    nameController.text = car.name.orEmpty();
    plateController.text = car.plate.orEmpty();
    releaseYearController.text = car.releaseYear.toString();

    priceController.text = (car.price ?? 0).toString().toCurrency();
    profitController.text = (car.profit ?? 0).toString().toCurrency();

    importDateController.text = car.importDate.toString().toVNDate();
    importPriceController.text = (car.importPrice ?? 0).toString().toCurrency();
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

    selectedModel.value = ItemModel(title: car.product.orNA());
    modelController.text = (selectedModel.value.title).orNA();

    selectedStatus.value = ItemModel(title: car.status.orNA());
    statusController.text = (selectedStatus.value.title).orNA();
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
