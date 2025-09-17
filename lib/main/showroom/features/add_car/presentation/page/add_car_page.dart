import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/ui/styles/app_container_styles.dart';
import 'package:auto_find/core/ui/styles/app_padding.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:auto_find/core/ui/widgets/buttons/primary_button.dart';
import 'package:auto_find/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:auto_find/core/utils/custom_framework.dart';
import 'package:auto_find/main/showroom/features/add_car/presentation/controller/add_car_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCarPage extends CustomState {
  const AddCarPage({super.key});

  @override
  String? get title => "Thêm xe mới";

  @override
  bool get backgroundImage => true;

  @override
  bool get dismissKeyboard => true;

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();
}

class _BodyBuilder extends GetView<AddCarController> {
  const _BodyBuilder();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: AppPadding.h16,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        decoration: AppContainerStyles.card100(),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            bottom: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomBottomSheetWidget(
                      height: 45,
                      label: "Hãng xe",
                      titleBottomSheet: "Hãng xe",
                      hint: "Chọn hãng xe",
                      controller: controller.brandController, // 🆕
                      onSelectedItem: (item) =>
                          controller.selectedBrand.value = item,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomBottomSheetWidget(
                      height: 45,
                      label: "Loại xe",
                      hint: "Chọn loại xe",
                      controller: controller.typeController, // 🆕
                      onSelectedItem: (item) =>
                          controller.selectedType.value = item,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: CustomBottomSheetWidget(
                      height: 45,
                      label: "Mẫu xe",
                      titleBottomSheet: "Mẫu xe",
                      hint: "Chọn mẫu xe",
                      controller: controller.modelController, // 🆕
                      onSelectedItem: (item) =>
                          controller.selectedModel.value = item,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      type: CustomTextFieldType.yearPicker,
                      label: "Năm sản xuất",
                      hintText: "Chọn năm sản xuất",
                      controller:
                          controller.yearController, // 🆕 gắn controller
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: "Tên xe",
                      hintText: "Nhập tên xe",
                      controller: controller.nameController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: "Biển số",
                      hintText: "Nhập biển số xe",
                      controller:
                          controller.plateController, // 🆕 gắn controller
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomBottomSheetWidget(
                      height: 45,
                      label: "Màu xe",
                      titleBottomSheet: "Màu xe",
                      hint: "Chọn màu xe",
                      controller: controller.colorController, // 🆕
                      onSelectedItem: (item) =>
                          controller.selectedColor.value = item,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(
                    child: CustomBottomSheetWidget(
                      height: 45,
                      label: "Trạng thái xe",
                      hint: "Chọn trạng thái xe",
                      controller: controller.statusController, // 🆕
                      onSelectedItem: (item) =>
                          controller.selectedStatus.value = item,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      type: CustomTextFieldType.datePicker,
                      label: "Ngày mua",
                      hintText: "Chọn ngày mua",
                      controller: controller.buyDateController, // 🆕
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              CustomTextField(
                type: CustomTextFieldType.money,
                label: "Giá nêm yết bán",
                hintText: "Nhập giá nêm yết bán",
                controller: controller.sellPriceController,
              ),
              const SizedBox(height: 14),
              CustomTextField(
                type: CustomTextFieldType.money,
                label: "Giá mua",
                hintText: "Nhập giá mua",
                controller: controller.buyPriceController,
              ),
              const SizedBox(height: 14),
              CustomTextField(
                type: CustomTextFieldType.money,
                label: "Chi phí mua",
                hintText: "Nhập chi phí mua",
                controller: controller.buyCostController,
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                isMaxParent: true,
                text: "Thêm xe",
                onPressed: controller.addCar,
              )
            ],
          ),
        ),
      ),
    );
  }
}
