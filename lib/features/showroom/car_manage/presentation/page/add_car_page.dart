import 'package:auto_fin/core/config/const/enum.dart';
import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/data/model/item_model.dart';
import 'package:auto_fin/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:auto_fin/core/ui/widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:auto_fin/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:auto_fin/core/ui/widgets/standard_layout_widget.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/controller/add_car_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCarPage extends GetView<AddCarController> {
  static const String routeName = "/add_car_page";
  const AddCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardLayoutWidget(
      padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 25),
      titleAppBar: "Thêm xe mới",
      bodyBuilder: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 10,
        ),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            const Row(
              children: [
                const Expanded(
                  child: const CustomTextField(
                    label: "Tên xe",
                    hintText: "Nhập tên xe",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "Biển số",
                    hintText: "Nhập biển số xe",
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    type: CustomTextFieldType.datePicker,
                    label: "Năm sản xuất",
                    hintText: "Chọn năm sản xuất",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomBottomSheetWidget(
                    label: "Hãng xe",
                    hint: "Chọn hãng xe",
                    onSelectedItem: (ItemModel) {},
                    controller: BottomSheetController(
                      listItem: <ItemModel>[].obs,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomBottomSheetWidget(
                    label: "Loại xe",
                    hint: "Chọn loại xe",
                    onSelectedItem: (ItemModel) {},
                    controller: BottomSheetController(
                      listItem: <ItemModel>[].obs,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "Biển số",
                    hintText: "Nhập biển số xe",
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: CustomTextField(
                    type: CustomTextFieldType.datePicker,
                    label: "Năm sản xuất",
                    hintText: "Chọn năm sản xuất",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomBottomSheetWidget(
                    label: "Trạng thái xe",
                    hint: "Chọn trạng thái xe",
                    onSelectedItem: (ItemModel) {},
                    controller: BottomSheetController(
                      listItem: <ItemModel>[].obs,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: const CustomTextField(
                    type: CustomTextFieldType.datePicker,
                    label: "Năm sản xuất",
                    hintText: "Chọn năm sản xuất",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomBottomSheetWidget(
                    label: "Giá mua",
                    hint: "Chọn trạng thái xe",
                    onSelectedItem: (ItemModel) {},
                    controller: BottomSheetController(
                      listItem: <ItemModel>[].obs,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: const CustomTextField(
                    type: CustomTextFieldType.datePicker,
                    label: "Năm sản xuất",
                    hintText: "Chọn năm sản xuất",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
