import 'package:auto_fin/core/ui/widgets/expand/expand_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarDetailController extends GetxController {
  ExpandController expandInformation = ExpandController();
  ExpandController expandVehicle = ExpandController();

  /// Hãng xe được chọn
  RxString selectedBrand = ''.obs;

  /// Loại xe được chọn
  RxString selectedTypeCar = ''.obs;

  /// Màu xe được chọn
  RxString selectedColor = ''.obs;

  /// Mẫu xe được chọn
  RxString selectedModel = ''.obs;

  /// Trạng thái xe được chọn
  RxString selectedStatus = ''.obs;

  /// Danh sách hãng xe
  final List<String> brandList = [
    "Toyota",
    "Honda",
    "Hyundai",
    "Ford",
    "Mazda",
    "VinFast",
  ];

  /// Danh sách loại xe
  final List<String> typeCarList = [
    "Sedan",
    "SUV",
    "Hatchback",
    "Pickup",
    "MPV",
    "Coupe",
  ];

  /// Danh sách màu xe
  final List<String> colorList = [
    "Đỏ",
    "Trắng",
    "Đen",
    "Xám",
    "Xanh",
    "Vàng",
  ];

  /// Danh sách mẫu xe
  final List<String> modelList = [
    "Standard",
    "Luxury",
    "Premium",
    "Sport",
  ];

  /// Danh sách trạng thái xe
  final List<String> statusList = [
    "Xe mới",
    "Xe đã qua sử dụng",
    "Xe trưng bày",
  ];

  /// Chọn hãng xe
  void selectBrand(String brand) {
    selectedBrand.value = brand;
    Get.back();
  }

  /// Chọn loại xe
  void selectTypeCar(String type) {
    selectedTypeCar.value = type;
    Get.back();
  }

  /// Chọn màu xe
  void selectColor(String color) {
    selectedColor.value = color;
    Get.back();
  }

  /// Chọn mẫu xe
  void selectModel(String model) {
    selectedModel.value = model;
    Get.back();
  }

  /// Chọn trạng thái xe
  void selectStatus(String status) {
    selectedStatus.value = status;
    Get.back();
  }

  /// Hàm gọi bottom sheet tái sử dụng
  void showSelectBottomSheet({
    required String title,
    required List<String> items,
    required void Function(String) onSelected,
  }) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Wrap(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...items.map((item) {
              return ListTile(
                title: Text(item),
                onTap: () => onSelected(item),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  /// Show từng bottom sheet
  void showBrandBottomSheet() {
    showSelectBottomSheet(
      title: "Chọn hãng xe",
      items: brandList,
      onSelected: selectBrand,
    );
  }

  void showTypeCarBottomSheet() {
    showSelectBottomSheet(
      title: "Chọn loại xe",
      items: typeCarList,
      onSelected: selectTypeCar,
    );
  }

  void showColorBottomSheet() {
    showSelectBottomSheet(
      title: "Chọn màu xe",
      items: colorList,
      onSelected: selectColor,
    );
  }

  void showModelBottomSheet() {
    showSelectBottomSheet(
      title: "Chọn mẫu xe",
      items: modelList,
      onSelected: selectModel,
    );
  }

  void showStatusBottomSheet() {
    showSelectBottomSheet(
      title: "Chọn trạng thái xe",
      items: statusList,
      onSelected: selectStatus,
    );
  }

  @override
  void onClose() {
    expandInformation.dispose();
    expandVehicle.dispose();
    super.onClose();
  }
}
