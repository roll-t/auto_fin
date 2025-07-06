import 'package:auto_fin/core/data/model/item_model.dart';
import 'package:auto_fin/core/ui/widgets/expand/expand_controller.dart';
import 'package:auto_fin/core/ui/widgets/select_bottom_sheet_widget.dart';
import 'package:auto_fin/core/utils/time_utils.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class CarDetailController extends GetxController {
  final expandInformation = ExpandController();
  final expandVehicle = ExpandController();

  RxString selectedBrand = ''.obs;
  RxString selectedTypeCar = ''.obs;
  RxString selectedColor = ''.obs;
  RxString selectedModel = ''.obs;
  RxString selectedStatus = ''.obs;

  RxBool isEditMode = false.obs;

  final List<String> brandList = [
    "Toyota",
    "Honda",
    "Hyundai",
    "Ford",
    "Mazda",
    "VinFast",
  ];
  final List<String> typeCarList = [
    "Sedan",
    "SUV",
    "Hatchback",
    "Pickup",
    "MPV",
    "Coupe",
  ];
  final List<String> colorList = [
    "Đỏ",
    "Trắng",
    "Đen",
    "Xám",
    "Xanh",
    "Vàng",
  ];
  final List<String> modelList = [
    "Standard",
    "Luxury",
    "Premium",
    "Sport",
  ];
  final List<String> statusList = [
    "Xe mới",
    "Xe đã qua sử dụng",
    "Xe trưng bày",
  ];

  void selectBrand(String brand) => selectedBrand.value = brand;
  void selectTypeCar(String type) => selectedTypeCar.value = type;
  void selectColor(String color) => selectedColor.value = color;
  void selectModel(String model) => selectedModel.value = model;
  void selectStatus(String status) => selectedStatus.value = status;

  void showSelectBottomSheet({
    required String title,
    required List<String> list,
    required void Function(String) onSelected,
  }) {
    SelectBottomSheet.show(
      title: title,
      items: list.map((e) => ItemModel(title: e)).toList(),
      onSelected: onSelected,
    );
  }

  void toggleEditMode() {
    if (!TimeUtils.canPerformAction(cooldownMs: 500)) {
      return;
    }

    if (!isEditMode.value) {
      Fluttertoast.showToast(msg: "Bật chế độ chỉnh sửa");
    } else {
      Fluttertoast.showToast(msg: "Tắt chế độ chỉnh sửa");
    }
    isEditMode.value = !isEditMode.value;
  }

  void showBrandBottomSheet() => showSelectBottomSheet(
        title: "Chọn hãng xe",
        list: brandList,
        onSelected: selectBrand,
      );

  void showTypeCarBottomSheet() => showSelectBottomSheet(
        title: "Chọn loại xe",
        list: typeCarList,
        onSelected: selectTypeCar,
      );

  void showColorBottomSheet() => showSelectBottomSheet(
        title: "Chọn màu xe",
        list: colorList,
        onSelected: selectColor,
      );

  void showModelBottomSheet() => showSelectBottomSheet(
        title: "Chọn mẫu xe",
        list: modelList,
        onSelected: selectModel,
      );

  void showStatusBottomSheet() => showSelectBottomSheet(
        title: "Chọn trạng thái xe",
        list: statusList,
        onSelected: selectStatus,
      );

  @override
  void onClose() {
    expandInformation.dispose();
    expandVehicle.dispose();
    super.onClose();
  }
}
