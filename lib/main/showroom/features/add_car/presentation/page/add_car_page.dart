import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/config/const/app_padding.dart';
import 'package:auto_find/core/config/const/app_text_styles.dart';
import 'package:auto_find/core/config/const/app_vectors.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:auto_find/core/ui/widgets/buttons/primary_button.dart';
import 'package:auto_find/core/ui/widgets/circle_icon_button_widget.dart';
import 'package:auto_find/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:auto_find/core/ui/widgets/keyboard/currency_quick_number_item.dart';
import 'package:auto_find/core/ui/widgets/texts/text_span_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/ui/widgets/wrap_body_widget.dart';
import 'package:auto_find/core/utils/custom_state.dart';
import 'package:auto_find/main/showroom/features/add_car/presentation/controller/add_car_controller.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/page/car_manage_page.dart';
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
  Widget get actionAppBar => _BuildActionAppBar(routeName: routeName);

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();

  @override
  Widget? get bottomNavigationBar => const _BuildBottomBar();
}

class _BuildActionAppBar extends StatelessWidget {
  const _BuildActionAppBar({
    required this.routeName,
  });

  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: CircleIconButton(
        isActive: true,
        svgUrl: AppVectors.icList,
        onTap: () {
          Get.toNamed(const CarManagePage().routeName);
        },
      ),
    );
  }
}

class _BuildBottomBar extends GetView<AddCarController> {
  const _BuildBottomBar();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.keyBoardController.isKeyboardOpen.value &&
          controller.isMoneyFieldFocused.value) {
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
          padding: EdgeInsets.only(
            top: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            left: 16,
            right: 16,
          ),
          child: controller.activeMoneyController.value != null
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CurrencyQuickNumberItem(
                      value: "00",
                      controller: controller.activeMoneyController.value!,
                    ),
                    CurrencyQuickNumberItem(
                      value: ".000",
                      controller: controller.activeMoneyController.value!,
                    ),
                    CurrencyQuickNumberItem(
                      value: ".000.000",
                      controller: controller.activeMoneyController.value!,
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        );
      }
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
          text: "Thêm xe",
          onPressed: controller.addCar,
        ),
      );
    });
  }
}

class _BodyBuilder extends GetView<AddCarController> {
  const _BodyBuilder();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 30,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Thông tin cơ bản
            WrapBodyWidget(
              header: const TextWidget(
                text: "Thông tin cơ bản",
                textStyle: AppTextStyle.medium14,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomBottomSheetWidget(
                          isRequired: true,
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
                          isRequired: true,
                          height: 45,
                          label: "Mẫu xe",
                          titleBottomSheet: "Mẫu xe",
                          hint: "Chọn mẫu xe",
                          controller: controller.modelController, // 🆕
                          onSelectedItem: (item) =>
                              controller.selectedModel.value = item,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          isRequired: true,
                          type: CustomTextFieldType.yearPicker,
                          label: "Năm sản xuất",
                          hintText: "Chọn năm sản xuất",
                          controller:
                              controller.yearController, // 🆕 gắn controller
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomBottomSheetWidget(
                          height: 45,
                          titleBottomSheet: "Loại xe",
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                TextSpanWidget(
                                  text1: "Tên xe",
                                  text2: "*",
                                  size: 14,
                                  fontWeight1: FontWeight.w600,
                                  fontWeight2: FontWeight.w600,
                                  textColor1: AppThemeColors.text,
                                  textColor2: AppColors.red,
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.green.withOpacity(.1),
                                  ),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: controller.onRecommendNameCar,
                                        child: const TextWidget(
                                          text: "Nhập tên gợi ý",
                                          textStyle: AppTextStyle.medium12,
                                          color: AppColors.green,
                                        ),
                                      ),
                                      const SizedBox(width: 2),
                                      const Icon(
                                        Icons.add,
                                        size: 14,
                                        color: AppColors.green,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6.0),
                            CustomTextField(
                              hasClear: true,
                              focusNode: controller.nameFocusNode,
                              hintText: "Nhập tên xe",
                              controller: controller.nameController,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          hasClear: true,
                          focusNode: controller.plateFocusNode,
                          label: "Biển số",
                          hintText: "Nhập biển số xe",
                          controller: controller.plateController,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: CustomBottomSheetWidget(
                          height: 45,
                          label: "Màu xe",
                          titleBottomSheet: "Màu xe",
                          hint: "Chọn màu xe",
                          controller: controller.colorController,
                          onSelectedItem: (item) =>
                              controller.selectedColor.value = item,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  CustomBottomSheetWidget(
                    isRequired: true,
                    height: 45,
                    label: "Trạng thái xe",
                    hint: "Chọn trạng thái xe",
                    controller: controller.statusController,
                    onSelectedItem: controller.onSelectedStatus,
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    isRequired: true,
                    type: CustomTextFieldType.money,
                    focusNode: controller.sellPriceFocusNode,
                    label: "Giá nêm yết bán",
                    hintText: "Nhập giá nêm yết bán",
                    controller: controller.sellPriceController,
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    height: 80,
                    type: CustomTextFieldType.textArea,
                    label: "Mô tả",
                    hintText: "Nhập mô tả xe",
                    controller: controller.desController,
                    maxLines: 6,
                    minLines: 3,
                  ),
                ],
              ),
            ),
            GetBuilder<AddCarController>(
              id: "SALES_INFO_ID",
              builder: (_) {
                if (controller.selectedStatus.value?.title != "Xe đã bán") {
                  return const SizedBox(height: 14);
                }
                return WrapBodyWidget(
                  margin: const EdgeInsets.only(
                    bottom: 14,
                    top: 14,
                  ),
                  header: const TextWidget(
                    text: "Thông tin bán",
                    textStyle: AppTextStyle.semiBold14,
                  ),
                  child: Column(
                    children: [
                      CustomTextField(
                        isRequired: true,
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
                        label: "Giá bán",
                        hintText: "Nhập giá bán",
                        focusNode: controller.soldPriceFocusNode,
                        backgroundColor: AppColors.white,
                        height: 45,
                        textSize: 14,
                        type: CustomTextFieldType.money,
                        controller: controller.soldPriceController,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        label: "Chi phí bán",
                        hintText: "Chi phí bán",
                        focusNode: controller.soldCostFocusNode,
                        backgroundColor: AppColors.white,
                        height: 45,
                        textSize: 14,
                        type: CustomTextFieldType.money,
                        controller: controller.soldCostController,
                      ),
                      const SizedBox(height: 14),
                      CustomTextField(
                        height: 80,
                        type: CustomTextFieldType.textArea,
                        label: "Mô tả bán",
                        hintText: "Nhập mô tả xe",
                        controller: controller.soldDesController,
                        maxLines: 6, // Cho phép nhập 6 dòng
                        minLines: 3, // Ít nhất 3 dòng
                      ),
                    ],
                  ),
                );
              },
            ),

            WrapBodyWidget(
              header: const TextWidget(
                text: "Thông tin mua",
                textStyle: AppTextStyle.medium14,
              ),
              child: Column(
                children: [
                  CustomTextField(
                    isRequired: true,
                    type: CustomTextFieldType.datePicker,
                    label: "Ngày mua",
                    hintText: "Chọn ngày mua",
                    controller: controller.buyDateController,
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    isRequired: true,
                    type: CustomTextFieldType.money,
                    label: "Giá mua",
                    hintText: "Nhập giá mua",
                    focusNode: controller.buyPriceFocusNode,
                    controller: controller.buyPriceController,
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    type: CustomTextFieldType.money,
                    label: "Chi phí mua",
                    hintText: "Nhập chi phí mua",
                    controller: controller.buyCostController,
                    focusNode: controller.buyCostFocusNode,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
