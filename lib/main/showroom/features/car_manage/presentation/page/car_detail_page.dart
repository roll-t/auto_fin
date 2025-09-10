import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/config/const/app_vectors.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/ui/widgets/app_bar/custom_appbar.dart';
import 'package:auto_find/core/ui/widgets/buttons/primary_button.dart';
import 'package:auto_find/core/ui/widgets/circle_icon_button%20_widget.dart';
import 'package:auto_find/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:auto_find/core/ui/widgets/expand/expand_section_widget.dart';
import 'package:auto_find/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:auto_find/core/ui/widgets/standard_layout_widget.dart';
import 'package:auto_find/core/utils/custom_framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/car_detail_controller.dart';

class CarDetailPage extends CustomState {
  const CarDetailPage({super.key});

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();
}

class _BodyBuilder extends StatelessWidget {
  const _BodyBuilder();
  @override
  Widget build(BuildContext context) {
    return StandardLayoutWidget(
      padding: const EdgeInsets.only(
        top: 10,
        left: 16,
        right: 16,
      ),
      appBar: CustomAppBar(
        title: "Chi tiết xe",
        actions: [
          GetBuilder<CarDetailController>(
            id: "EDIT_ICON_ID",
            builder: (controller) {
              return CircleIconButton(
                isActive: controller.isEditMode.value,
                svgUrl: AppVectors.icEditing,
                onTap: controller.toggleEditMode,
              );
            },
          ),
          const SizedBox(width: 16),
          CircleIconButton(
            svgUrl: AppVectors.icDelete,
            onTap: () {
              DialogUtils.showAlert(
                content: "Bạn có muốn xóa xe này!",
                alertType: AlertType.warning,
              );
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      bodyBuilder: GetBuilder<CarDetailController>(
        id: "FORM_ID",
        builder: (controller) {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return _BuildFormBody(
            controller: controller,
          );
        },
      ),
    );
  }
}

class _BuildFormBody extends StatelessWidget {
  final CarDetailController controller;

  const _BuildFormBody({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        margin: const EdgeInsets.only(bottom: 30),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thông tin cơ bản
            ExpandSectionWidget(
              title: "Thông tin cơ bản",
              controller: controller.expandInformation,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CustomTextField(
                    enabled: controller.isEditMode.value,
                    label: "Tên xe",
                    hintText: "Nhập tên xe",
                    height: 45,
                    textSize: 14,
                    type: CustomTextFieldType.text,
                    controller: controller.nameController,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          enabled: controller.isEditMode.value,
                          label: "Biển số xe",
                          hintText: "Nhập biển số xe",
                          backgroundColor: AppColors.white,
                          height: 45,
                          textSize: 14,
                          type: CustomTextFieldType.text,
                          controller: controller.plateController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          enabled: controller.isEditMode.value,
                          label: "Năm sản xuất",
                          controller: controller.releaseYearController,
                          startYear: 2000,
                          endYear: DateTime.now().year,
                          onYearSelected: (year) {
                            print("Năm được chọn: $year");
                          },
                          height: 45,
                          textSize: 14,
                          type: CustomTextFieldType.yearPicker,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// Hãng xe - Loại xe
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          enabled: controller.isEditMode.value,
                          label: "Hãng xe",
                          hintText: "Chọn hãng xe",
                          controller: controller.brandController,
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          backgroundColor: AppColors.white,
                          height: 45,
                          textSize: 14,
                          type: CustomTextFieldType.dropdown,
                          onTap: controller.showBrandBottomSheet,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          enabled: controller.isEditMode.value,
                          label: "Loại xe",
                          hintText: "Chọn loại xe",
                          controller: controller.typeCarController,
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          backgroundColor: AppColors.white,
                          height: 45,
                          textSize: 14,
                          type: CustomTextFieldType.dropdown,
                          onTap: controller.showTypeCarBottomSheet,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// Màu xe - Mẫu xe
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          enabled: controller.isEditMode.value,
                          label: "Màu xe",
                          hintText: "Chọn màu xe",
                          controller: controller.colorController,
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          backgroundColor: AppColors.white,
                          height: 45,
                          textSize: 14,
                          type: CustomTextFieldType.dropdown,
                          onTap: controller.showColorBottomSheet,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          enabled: controller.isEditMode.value,
                          label: "Mẫu xe",
                          hintText: "Chọn mẫu xe",
                          controller: controller.modelController,
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          backgroundColor: AppColors.white,
                          height: 45,
                          textSize: 14,
                          type: CustomTextFieldType.dropdown,
                          onTap: controller.showModelBottomSheet,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// Trạng thái xe
                  CustomTextField(
                    enabled: controller.isEditMode.value,
                    label: "Trạng thái xe",
                    hintText: "Chọn trạng thái xe",
                    controller: controller.statusController,
                    suffixIcon: const Icon(Icons.arrow_drop_down),
                    backgroundColor: AppColors.white,
                    height: 45,
                    textSize: 14,
                    type: CustomTextFieldType.dropdown,
                    onTap: controller.showStatusBottomSheet,
                  ),
                  if (controller.isEditMode.value) ...[
                    const SizedBox(height: 30),
                    PrimaryButton(
                      isMaxParent: true,
                      text: "Cập nhật Thông tin xe",
                      onPressed: controller.updateCarInfo,
                    ),
                  ]
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Thông tin mua bán
            ExpandSectionWidget(
              title: "Thông tin mua bán (ĐVTT/VND)",
              controller: controller.expandVehicle,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          enabled: controller.isEditMode.value,
                          label: "Ngày mua",
                          controller: controller.importDateController,
                          type: CustomTextFieldType.datePicker,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                          onDateSelected: (date) {
                            print("Ngày mua: ${date.toIso8601String()}");
                          },
                          height: 45,
                          textSize: 14,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: CustomTextField(
                          enabled: controller.isEditMode.value,
                          label: "Ngày bán",
                          controller: controller.soldDateController,
                          type: CustomTextFieldType.datePicker,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                          onDateSelected: (date) {
                            print("Ngày bán: ${date.toIso8601String()}");
                          },
                          height: 45,
                          textSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    enabled: controller.isEditMode.value,
                    label: "Giá niêm yết bán",
                    hintText: "",
                    backgroundColor: AppColors.white,
                    height: 45,
                    textSize: 14,
                    type: CustomTextFieldType.text,
                    controller: controller.priceController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    enabled: controller.isEditMode.value,
                    label: "Lợi nhuận",
                    hintText: "",
                    controller: controller.profitController,
                    height: 45,
                    textSize: 14,
                    type: CustomTextFieldType.text,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    enabled: controller.isEditMode.value,
                    label: "Giá mua",
                    hintText: "Giá mua",
                    backgroundColor: AppColors.white,
                    height: 45,
                    textSize: 14,
                    type: CustomTextFieldType.money,
                    controller: controller.importPriceController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    enabled: controller.isEditMode.value,
                    label: "Chi phí mua",
                    hintText: "",
                    backgroundColor: AppColors.white,
                    height: 45,
                    textSize: 14,
                    type: CustomTextFieldType.money,
                    controller: controller.importCostController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    enabled: controller.isEditMode.value,
                    label: "Giá bán",
                    hintText: "Nhập giá bán",
                    backgroundColor: AppColors.white,
                    height: 45,
                    textSize: 14,
                    type: CustomTextFieldType.money,
                    controller: controller.soldPriceController,
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    enabled: controller.isEditMode.value,
                    label: "Chi phí bán",
                    hintText: "",
                    backgroundColor: AppColors.white,
                    height: 45,
                    textSize: 14,
                    type: CustomTextFieldType.money,
                    controller: controller.soldCostController,
                  ),
                  if (controller.isEditMode.value) ...[
                    const SizedBox(height: 30),
                    PrimaryButton(
                      isMaxParent: true,
                      text: "Cập nhật mua bán",
                      onPressed: controller.updateTransactionInfo,
                    ),
                  ],
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
