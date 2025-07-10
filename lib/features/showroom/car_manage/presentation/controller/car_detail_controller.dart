import 'package:auto_fin/core/data/model/item_model.dart';
import 'package:auto_fin/core/extension/empty_extension.dart';
import 'package:auto_fin/core/ui/widgets/expand/expand_controller.dart';
import 'package:auto_fin/core/ui/widgets/bottom_sheet/select_bottom_sheet_widget.dart';
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

  void selectBrand(ItemModel brand) => selectedBrand.value = brand.title.orNA();

  void selectTypeCar(ItemModel type) =>
      selectedTypeCar.value = type.title.orNA();
  void selectColor(ItemModel color) => selectedColor.value = color.title.orNA();
  void selectModel(ItemModel model) => selectedModel.value = model.title.orNA();
  void selectStatus(ItemModel status) =>
      selectedStatus.value = status.title.orNA();

  void showSelectBottomSheet({
    required String title,
    required List<String> list,
    required void Function(ItemModel item) onSelected,
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
