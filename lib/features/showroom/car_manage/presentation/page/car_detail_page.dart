import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/ui/widgets/expand/expand_section_widget.dart';
import 'package:auto_fin/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:auto_fin/core/ui/widgets/inputs/date_time_picker_text_field_widget.dart';
import 'package:auto_fin/core/ui/widgets/inputs/year_picker_text_field_widget.dart';
import 'package:auto_fin/core/ui/widgets/standard_layout_widget.dart';
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
      titleAppBar: "Chi tiết xe",
      bodyBuilder: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpandSectionWidget(
              title: "Thông tin cơ ",
              controller: controller.expandInformation,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const CustomTextField(
                    borderWidth: 1,
                    label: "Tên xe",
                    hintText: "Nhập tên xe",
                    borderColor: AppColors.light1,
                    backgroundColor: AppColors.white,
                    height: 45,
                    textSize: 14,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: CustomTextField(
                          borderWidth: 1,
                          label: "Biển số xe",
                          hintText: "Nhập biển số xe",
                          borderColor: AppColors.light1,
                          backgroundColor: AppColors.white,
                          height: 45,
                          textSize: 14,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: YearPickerTextField(
                          label: "Năm sản xuất",
                          controller: TextEditingController(),
                          startYear: 2000,
                          endYear: DateTime.now().year,
                          onYearSelected: (year) {
                            print("Năm được chọn: $year");
                          },
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
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () => controller.showBrandBottomSheet(),
                          child: Obx(
                            () => IgnorePointer(
                              child: CustomTextField(
                                borderWidth: 1,
                                label: "Hãng xe",
                                hintText: "Chọn hãng xe",
                                controller: TextEditingController(
                                  text: controller.selectedBrand.value,
                                ),
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                borderColor: AppColors.light1,
                                backgroundColor: AppColors.white,
                                height: 45,
                                textSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () => controller.showTypeCarBottomSheet(),
                          child: Obx(
                            () => IgnorePointer(
                              child: CustomTextField(
                                borderWidth: 1,
                                label: "Loại xe",
                                hintText: "Chọn loại xe",
                                controller: TextEditingController(
                                  text: controller.selectedTypeCar.value,
                                ),
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                borderColor: AppColors.light1,
                                backgroundColor: AppColors.white,
                                height: 45,
                                textSize: 14,
                              ),
                            ),
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
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () => controller.showColorBottomSheet(),
                          child: Obx(
                            () => IgnorePointer(
                              child: CustomTextField(
                                borderWidth: 1,
                                label: "Màu xe",
                                hintText: "Chọn màu xe",
                                controller: TextEditingController(
                                  text: controller.selectedColor.value,
                                ),
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                borderColor: AppColors.light1,
                                backgroundColor: AppColors.white,
                                height: 45,
                                textSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () => controller.showModelBottomSheet(),
                          child: Obx(
                            () => IgnorePointer(
                              child: CustomTextField(
                                borderWidth: 1,
                                label: "Mẫu xe",
                                hintText: "Chọn mẫu xe",
                                controller: TextEditingController(
                                  text: controller.selectedModel.value,
                                ),
                                suffixIcon: const Icon(Icons.arrow_drop_down),
                                borderColor: AppColors.light1,
                                backgroundColor: AppColors.white,
                                height: 45,
                                textSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// Row 3: Trạng thái xe
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () => controller.showStatusBottomSheet(),
                    child: Obx(
                      () => IgnorePointer(
                        child: CustomTextField(
                          borderWidth: 1,
                          label: "Trạng thái xe",
                          hintText: "Chọn trạng thái xe",
                          controller: TextEditingController(
                            text: controller.selectedStatus.value,
                          ),
                          suffixIcon: const Icon(Icons.arrow_drop_down),
                          borderColor: AppColors.light1,
                          backgroundColor: AppColors.white,
                          height: 45,
                          textSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ExpandSectionWidget(
              title: "Thông tin mua bán (ĐVTT/VND)",
              controller: controller.expandVehicle,
              child: Column(
                children: [
                  const SizedBox(height: 10),

                  /// Row 1: Giá niêm yết bán - Lợi nhuận
                  Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: CustomTextField(
                          borderWidth: 1,
                          label: "Giá niêm yết bán",
                          hintText: "",
                          borderColor: AppColors.light1,
                          backgroundColor: AppColors.white,
                          height: 45,
                          textSize: 14,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: IgnorePointer(
                          ignoring: true,
                          child: CustomTextField(
                            borderWidth: 1,
                            label: "Lợi nhuận",
                            hintText: "",
                            controller: TextEditingController(
                              text: "-125,000,000",
                            ),
                            borderColor: AppColors.light1,
                            backgroundColor: AppColors.neutralColor3,
                            height: 45,
                            textSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  /// Row 2: Ngày mua - Giá mua - Chi phí mua
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: DateTimePickerTextField(
                          label: "Ngày mua",
                          controller: TextEditingController(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                          onDateSelected: (date) {
                            print("Ngày đã chọn: ${date.toIso8601String()}");
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        flex: 1,
                        child: CustomTextField(
                          borderWidth: 1,
                          label: "Giá mua",
                          hintText: "125,000,000",
                          borderColor: AppColors.light1,
                          backgroundColor: AppColors.white,
                          height: 45,
                          textSize: 14,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        flex: 1,
                        child: CustomTextField(
                          borderWidth: 1,
                          label: "Chi phí mua",
                          hintText: "",
                          borderColor: AppColors.light1,
                          backgroundColor: AppColors.white,
                          height: 45,
                          textSize: 14,
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
                        child: DateTimePickerTextField(
                          label: "Ngày bán",
                          controller: TextEditingController(),
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                          onDateSelected: (date) {
                            print("Ngày đã chọn: ${date.toIso8601String()}");
                          },
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          borderWidth: 1,
                          label: "Giá bán",
                          hintText: "",
                          borderColor: AppColors.light1,
                          backgroundColor: AppColors.white,
                          height: 45,
                          textSize: 14,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        flex: 1,
                        child: CustomTextField(
                          borderWidth: 1,
                          label: "Chi phí bán",
                          hintText: "",
                          borderColor: AppColors.light1,
                          backgroundColor: AppColors.white,
                          height: 45,
                          textSize: 14,
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
                        // TODO: Xử lý lưu thông tin mua bán
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
