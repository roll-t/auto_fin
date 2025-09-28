import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/config/const/app_padding.dart';
import 'package:auto_find/core/config/const/app_text_styles.dart';
import 'package:auto_find/core/config/const/app_vectors.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/ui/widgets/buttons/primary_button.dart';
import 'package:auto_find/core/ui/widgets/circle_icon_button%20_widget.dart';
import 'package:auto_find/core/ui/widgets/dialogs/dialog_utils.dart';
import 'package:auto_find/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:auto_find/core/ui/widgets/keyboard/currency_quick_number_item.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/ui/widgets/wrap_body_widget.dart';
import 'package:auto_find/core/utils/custom_state.dart';
import 'package:auto_find/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/car_detail_controller.dart';

class CarDetailPage extends CustomState {
  const CarDetailPage({super.key});

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();

  @override
  String? get title => "Chi tiết xe";

  @override
  bool get backgroundImage => true;

  @override
  bool get dismissKeyboard => true;

  @override
  Widget? get actionAppBar => _BuildActionAppBar();

  @override
  Widget? get leadingIconAppBar => const _BuildLeadingIconBack();

  @override
  Widget? get bottomNavigationBar => const _BuildBottomBar();
}

class _BuildActionAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
        GetBuilder<CarDetailController>(
          builder: (controller) {
            return CircleIconButton(
              svgUrl: AppVectors.icDelete,
              onTap: () {
                DialogUtils.showConfirm(
                  content: "Bạn có muốn xóa xe này!",
                  alertType: AlertType.warning,
                  onConfirm: () {
                    Get.back();
                    controller.onDeleteCar();
                  },
                  onCancel: () {
                    Get.back();
                  },
                );
              },
            );
          },
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}

class _BuildLeadingIconBack extends StatelessWidget {
  const _BuildLeadingIconBack();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarDetailController>(
      builder: (controller) {
        return GestureDetector(
          onTap: () {
            Get.back(result: controller.isUpdated);
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Utils.iconSvg(svgUrl: AppVectors.icArrowBack),
          ),
        );
      },
    );
  }
}

class _BuildBottomBar extends GetView<CarDetailController> {
  const _BuildBottomBar();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.keyBoardController.isKeyboardOpen.value &&
          controller.isMoneyFieldFocused.value) {
        return Padding(
          padding: EdgeInsets.only(
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            left: 16,
            right: 16,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CurrencyQuickNumberItem(
                value: "00",
                controller: controller.priceController,
              ),
              CurrencyQuickNumberItem(
                value: ".000",
                controller: controller.priceController,
              ),
              CurrencyQuickNumberItem(
                value: ".000.000",
                controller: controller.priceController,
              ),
            ],
          ),
        );
      }
      if (!controller.isEditMode.value) return const SizedBox.shrink();
      return Container(
        decoration: BoxDecoration(
          color: AppThemeColors.background100,
          boxShadow: [
            BoxShadow(
              color: AppColors.dark300.withValues(alpha: .1),
              offset: const Offset(0, -1),
              blurRadius: 6,
              spreadRadius: 1,
            )
          ],
        ),
        padding: AppPadding.v16h20,
        child: PrimaryButton(
          isMaxParent: true,
          text: "Cập nhật thông tin xe",
          onPressed: controller.updateCar,
        ),
      );
    });
  }
}

class _BodyBuilder extends StatelessWidget {
  const _BodyBuilder();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CarDetailController>(
      id: "FORM_ID",
      builder: (controller) {
        return SingleChildScrollView(
          padding: AppPadding.h16,
          child: Column(
            children: [
              WrapBodyWidget(
                header: const TextWidget(
                  text: "Thông tin cơ bản",
                  textStyle: AppTextStyle.semiBold14,
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      isRequired: true,
                      hasClear: true,
                      enabled: controller.isEditMode.value,
                      label: "Tên xe",
                      hintText: "Nhập tên xe",
                      height: 45,
                      textSize: 14,
                      type: CustomTextFieldType.text,
                      controller: controller.nameController,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            hasClear: true,
                            enabled: controller.isEditMode.value,
                            label: "Biển số xe",
                            hintText: "Nhập biển số xe",
                            height: 45,
                            textSize: 14,
                            type: CustomTextFieldType.text,
                            controller: controller.plateController,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextField(
                            isRequired: true,
                            enabled: controller.isEditMode.value,
                            label: "Năm sản xuất",
                            controller: controller.releaseYearController,
                            startYear: 2000,
                            endYear: DateTime.now().year,
                            height: 45,
                            textSize: 14,
                            type: CustomTextFieldType.yearPicker,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    /// Hãng xe - Loại xe
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            isRequired: true,
                            enabled: controller.isEditMode.value,
                            label: "Hãng xe",
                            hintText: "Chọn hãng xe",
                            controller: controller.brandController,
                            suffixIcon: const Icon(Icons.arrow_drop_down),
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
                            height: 45,
                            textSize: 14,
                            type: CustomTextFieldType.dropdown,
                            onTap: controller.showTypeCarBottomSheet,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

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
                            height: 45,
                            textSize: 14,
                            type: CustomTextFieldType.dropdown,
                            onTap: controller.showColorBottomSheet,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CustomTextField(
                            isRequired: true,
                            enabled: controller.isEditMode.value,
                            label: "Mẫu xe",
                            hintText: "Chọn mẫu xe",
                            controller: controller.modelController,
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            height: 45,
                            textSize: 14,
                            type: CustomTextFieldType.dropdown,
                            onTap: controller.showModelBottomSheet,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    /// Trạng thái xe
                    CustomTextField(
                      isRequired: true,
                      enabled: controller.isEditMode.value,
                      label: "Trạng thái xe",
                      hintText: "Chọn trạng thái xe",
                      controller: controller.statusController,
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      height: 45,
                      textSize: 14,
                      type: CustomTextFieldType.dropdown,
                      onTap: controller.showStatusBottomSheet,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      focusNode: controller.priceFocusNode,
                      isRequired: true,
                      enabled: controller.isEditMode.value,
                      label: "Giá nêm yết bán",
                      hintText: "Giá nêm yết bán",
                      height: 45,
                      textSize: 14,
                      type: CustomTextFieldType.money,
                      controller: controller.priceController,
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              WrapBodyWidget(
                child: CustomTextField(
                  enabled: false,
                  label: "Lợi nhuận",
                  hintText: "Lợi nhuận",
                  controller: controller.profitController,
                  height: 45,
                  textSize: 14,
                  type: CustomTextFieldType.money,
                ),
              ),
              const SizedBox(height: 20),
              GetBuilder<CarDetailController>(
                id: "SALES_INFO_ID",
                builder: (_) {
                  if (controller.statusController.text != "Xe đã bán") {
                    return const SizedBox.shrink();
                  }
                  return WrapBodyWidget(
                    margin: const EdgeInsets.only(bottom: 20),
                    header: const TextWidget(
                      text: "Thông tin bán",
                      textStyle: AppTextStyle.semiBold14,
                    ),
                    child: Column(
                      children: [
                        CustomTextField(
                          isRequired: true,
                          enabled: controller.isEditMode.value,
                          label: "Ngày bán",
                          controller: controller.soldDateController,
                          type: CustomTextFieldType.datePicker,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                          height: 45,
                          textSize: 14,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          isRequired: true,
                          enabled: controller.isEditMode.value,
                          label: "Giá bán",
                          hintText: "Nhập giá bán",
                          height: 45,
                          textSize: 14,
                          type: CustomTextFieldType.money,
                          controller: controller.soldPriceController,
                        ),
                        const SizedBox(height: 16),
                        CustomTextField(
                          enabled: controller.isEditMode.value,
                          label: "Chi phí bán",
                          hintText: "Chi phí bán",
                          height: 45,
                          textSize: 14,
                          type: CustomTextFieldType.money,
                          controller: controller.soldCostController,
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  );
                },
              ),
              WrapBodyWidget(
                header: const TextWidget(
                  text: "Thông tin mua",
                  textStyle: AppTextStyle.semiBold14,
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      isRequired: true,
                      enabled: controller.isEditMode.value,
                      label: "Ngày mua",
                      controller: controller.importDateController,
                      type: CustomTextFieldType.datePicker,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                      height: 45,
                      textSize: 14,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      focusNode: controller.importPriceFocusNode,
                      isRequired: true,
                      enabled: controller.isEditMode.value,
                      label: "Giá mua",
                      hintText: "Giá mua",
                      height: 45,
                      textSize: 14,
                      type: CustomTextFieldType.money,
                      controller: controller.importPriceController,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      focusNode: controller.importCostFocusNode,
                      enabled: controller.isEditMode.value,
                      label: "Chi phí mua",
                      hintText: "Chi phí mua",
                      height: 45,
                      textSize: 14,
                      type: CustomTextFieldType.money,
                      controller: controller.importCostController,
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
