import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/core/config/const/enum.dart';
import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/ui/widgets/app_bar/custom_appbar.dart';
import 'package:auto_fin/core/ui/widgets/circle_icon_button%20_widget.dart';
import 'package:auto_fin/core/ui/widgets/expand/expand_section_widget.dart';
import 'package:auto_fin/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:auto_fin/core/ui/widgets/standard_layout_widget.dart';
import 'package:auto_fin/features/setting/presentation/page/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/car_detail_controller.dart';

class CarDetailPage extends GetView<CarDetailController> {
  static String routeName = "/CarDetailPage";

  const CarDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardLayoutWidget(
      padding: const EdgeInsets.only(top: 20),
      appBar: CustomAppBar(
        title: "Chi tiết xe",
        menuItem: [
          CircleIconButton(
            svgUrl: AppIcons.icEditing,
            onTap: () {
              Get.toNamed(SettingPage.routeName);
            },
          ),
          const SizedBox(width: 16),
          CircleIconButton(
            svgUrl: AppIcons.icDelete,
            onTap: () {
              Get.toNamed(SettingPage.routeName);
            },
          ),
        ],
      ),
      bodyBuilder: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpandSectionWidget(
              title: "Thông tin cơ ",
              controller: controller.expandInformation,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  CustomTextField(
                    label: "Tên xe",
                    enabled: false,
                    hintText: "Nhập tên xe",
                    height: 45,
                    textSize: 14,
                    type: CustomTextFieldType.text,
                    controller: TextEditingController(),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          label: "Biển số xe",
                          hintText: "Nhập biển số xe",
                          backgroundColor: AppColors.white,
                          height: 45,
                          textSize: 14,
                          type: CustomTextFieldType.text,
                          controller: TextEditingController(),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          label: "Năm sản xuất",
                          controller: TextEditingController(),
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

                  /// Row 1: Hãng xe - Loại xe
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Obx(
                          () => CustomTextField(
                            label: "Hãng xe",
                            hintText: "Chọn hãng xe",
                            controller: TextEditingController(
                              text: controller.selectedBrand.value,
                            ),
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            backgroundColor: AppColors.white,
                            height: 45,
                            textSize: 14,
                            type: CustomTextFieldType.dropdown,
                            onTap: () => controller.showBrandBottomSheet(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: Obx(
                          () => CustomTextField(
                            label: "Loại xe",
                            hintText: "Chọn loại xe",
                            controller: TextEditingController(
                              text: controller.selectedTypeCar.value,
                            ),
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            backgroundColor: AppColors.white,
                            height: 45,
                            textSize: 14,
                            type: CustomTextFieldType.dropdown,
                            onTap: () => controller.showTypeCarBottomSheet(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// Row 2: Màu xe - Mẫu xe
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Obx(
                          () => CustomTextField(
                            label: "Màu xe",
                            hintText: "Chọn màu xe",
                            controller: TextEditingController(
                              text: controller.selectedColor.value,
                            ),
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            backgroundColor: AppColors.white,
                            height: 45,
                            textSize: 14,
                            type: CustomTextFieldType.dropdown,
                            onTap: () => controller.showColorBottomSheet(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: Obx(
                          () => CustomTextField(
                            label: "Mẫu xe",
                            hintText: "Chọn mẫu xe",
                            controller: TextEditingController(
                              text: controller.selectedModel.value,
                            ),
                            suffixIcon: const Icon(Icons.arrow_drop_down),
                            backgroundColor: AppColors.white,
                            height: 45,
                            textSize: 14,
                            type: CustomTextFieldType.dropdown,
                            onTap: () => controller.showModelBottomSheet(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// Row 3: Trạng thái xe
                  Obx(
                    () => CustomTextField(
                      label: "Trạng thái xe",
                      hintText: "Chọn trạng thái xe",
                      controller: TextEditingController(
                        text: controller.selectedStatus.value,
                      ),
                      suffixIcon: const Icon(Icons.arrow_drop_down),
                      backgroundColor: AppColors.white,
                      height: 45,
                      textSize: 14,
                      type: CustomTextFieldType.dropdown,
                      onTap: () => controller.showStatusBottomSheet(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            ExpandSectionWidget(
              title: "Thông tin mua bán (ĐVTT/VND)",
              controller: controller.expandVehicle,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          label: "Giá niêm yết bán",
                          hintText: "",
                          backgroundColor: AppColors.white,
                          height: 45,
                          textSize: 14,
                          type: CustomTextFieldType.text,
                          controller: TextEditingController(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          label: "Lợi nhuận",
                          hintText: "",
                          controller: TextEditingController(
                            text: "-125,000,000",
                          ),
                          backgroundColor: AppColors.neutralColor3,
                          height: 45,
                          textSize: 14,
                          enabled: false,
                          type: CustomTextFieldType.text,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  /// Row 3: Ngày bán - Giá bán - Chi phí bán

                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            CustomTextField(
                              label: "Ngày mua",
                              controller: TextEditingController(),
                              type: CustomTextFieldType.datePicker,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                              onDateSelected: (date) {
                                print(
                                    "Ngày đã chọn: ${date.toIso8601String()}");
                              },
                              height: 45,
                              textSize: 14,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              label: "Giá mua",
                              hintText: "125,000,000",
                              backgroundColor: AppColors.white,
                              height: 45,
                              textSize: 14,
                              type: CustomTextFieldType.text,
                              controller: TextEditingController(),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              label: "Chi phí mua",
                              hintText: "",
                              backgroundColor: AppColors.white,
                              height: 45,
                              textSize: 14,
                              type: CustomTextFieldType.text,
                              controller: TextEditingController(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            CustomTextField(
                              label: "Ngày bán",
                              controller: TextEditingController(),
                              type: CustomTextFieldType.datePicker,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now(),
                              onDateSelected: (date) {
                                print(
                                    "Ngày đã chọn: ${date.toIso8601String()}");
                              },
                              height: 45,
                              textSize: 14,
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              label: "Giá bán",
                              hintText: "125,000,000",
                              backgroundColor: AppColors.white,
                              height: 45,
                              textSize: 14,
                              type: CustomTextFieldType.text,
                              controller: TextEditingController(),
                            ),
                            const SizedBox(height: 10),
                            CustomTextField(
                              label: "Chi phí bán",
                              hintText: "",
                              backgroundColor: AppColors.white,
                              height: 45,
                              textSize: 14,
                              type: CustomTextFieldType.text,
                              controller: TextEditingController(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// Button cập nhật
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                      ),
                      onPressed: () {
                        // Implement your update logic here
                      },
                      child: const Text(
                        "Cập Nhật Mua Bán",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
