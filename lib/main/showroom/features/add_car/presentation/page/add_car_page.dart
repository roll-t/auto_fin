import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/config/const/app_vectors.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/ui/styles/app_padding.dart';
import 'package:auto_find/core/ui/styles/app_text_styles.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:auto_find/core/ui/widgets/buttons/primary_button.dart';
import 'package:auto_find/core/ui/widgets/circle_icon_button%20_widget.dart';
import 'package:auto_find/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/ui/widgets/wrap_body_widget.dart';
import 'package:auto_find/core/utils/custom_framework.dart';
import 'package:auto_find/main/showroom/features/add_car/presentation/controller/add_car_controller.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/page/car_manage_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  List<Widget>? get actionAppBar => [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: CircleIconButton(
            isActive: true,
            svgUrl: AppVectors.icList,
            onTap: () {
              Get.toNamed(const CarManagePage().routeName);
            },
          ),
        ),
      ];

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();

  @override
  Widget? get bottomNavigationBar => const _BuildBottomNavigation();
}

class _BuildBottomNavigation extends StatelessWidget {
  const _BuildBottomNavigation();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddCarController>(
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.dark300.withOpacity(.1),
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
      },
    );
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
                                TextWidget(
                                  text: "Tên xe",
                                  size: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppThemeColors.text,
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
                  CustomBottomSheetWidget(
                    height: 45,
                    label: "Trạng thái xe",
                    hint: "Chọn trạng thái xe",
                    controller: controller.statusController, // 🆕
                    onSelectedItem: (item) =>
                        controller.selectedStatus.value = item,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            WrapBodyWidget(
              header: const TextWidget(
                text: "Thông tin mua",
                textStyle: AppTextStyle.medium14,
              ),
              child: Column(
                children: [
                  CustomTextField(
                    type: CustomTextFieldType.datePicker,
                    label: "Ngày mua",
                    hintText: "Chọn ngày mua",
                    controller: controller.buyDateController,
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
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
