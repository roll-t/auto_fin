import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/config/const/app_padding.dart';
import 'package:auto_find/core/config/const/app_text_styles.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:auto_find/core/ui/widgets/buttons/primary_button.dart';
import 'package:auto_find/core/ui/widgets/inputs/check_box_widget.dart';
import 'package:auto_find/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/ui/widgets/wrap_body_widget.dart';
import 'package:auto_find/core/utils/custom_state.dart';
import 'package:auto_find/main/pawn_shop/features/capital_manage/presentation/controller/add_capital_contract_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCapitalContractPage extends CustomState {
  const AddCapitalContractPage({super.key});

  @override
  String? get title => "Thêm mới Hợp đồng góp vốn";

  @override
  bool get backgroundImage => true;

  @override
  bool get dismissKeyboard => true;

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();

  @override
  Widget? get bottomNavigationBar => const _BuildBottomNavigation();
}

///=============================== [RENDER LAYOUT COMPONENTS] ====================================
class _BuildBottomNavigation extends StatelessWidget {
  const _BuildBottomNavigation();

  @override
  Widget build(BuildContext context) {
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
        text: "Lưu Hợp đồng",
        onPressed: () {},
      ),
    );
  }
}

///=============================== [RENDER MAIN BODY] ====================================
class _BodyBuilder extends GetView<AddCapitalContractController> {
  const _BodyBuilder();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 30,
      ),
      child: Column(
        spacing: 14,
        children: [
          WrapBodyWidget(
            header: const TextWidget(
              text: "Thông tin khách hàng",
              textStyle: AppTextStyle.medium14,
            ),
            child: Column(
              spacing: 14.0,
              children: [
                CustomBottomSheetWidget(
                  isRequired: true,
                  label: "Loại khách hàng",
                  height: 45,
                  hint: "Chọn loại khách hàng",
                  titleBottomSheet: "Chọn loại khách hàng",
                  controller: controller.customerType,
                  onSelectedItem: (_) {},
                ),
                const CustomTextField(
                  isRequired: true,
                  label: "Tên khách hàng",
                  hintText: "Nhập Tên khách hàng",
                ),
                const CustomTextField(
                  keyboardType: TextInputType.number,
                  label: "Số CCCD/Hộ chiếu",
                  hintText: "Nhập Số CCCD/Hộ chiếu",
                ),
                const CustomTextField(
                  keyboardType: TextInputType.number,
                  label: "Số điện thoại",
                  hintText: "Nhập Số điện thoại",
                ),
                const CustomTextField(
                  type: CustomTextFieldType.textArea,
                  label: "Địa chỉ",
                  hintText: "Nhập Địa chỉ",
                  height: 80,
                  maxLines: 6,
                  minLines: 3,
                ),
              ],
            ),
          ),
          WrapBodyWidget(
            header: const TextWidget(
              text: "Thông hợp đồng",
              textStyle: AppTextStyle.medium14,
            ),
            child: Column(
              spacing: 14.0,
              children: [
                const CustomTextField(
                  isRequired: true,
                  label: "Số tiền đầu tư",
                  hintText: "0",
                  type: CustomTextFieldType.money,
                ),
                const CustomTextField(
                  isRequired: true,
                  label: "Ngày góp",
                  type: CustomTextFieldType.datePicker,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: CustomBottomSheetWidget(
                        isRequired: true,
                        label: "Hình thức lãi",
                        height: 45,
                        hint: "Chọn hình thức lãi",
                        titleBottomSheet: "Chọn hình thức lãi",
                        controller: controller.interestRateType,
                        onSelectedItem: (_) {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: CheckBoxWidget(
                        isCheck: controller.isPrepaidInterest,
                        label: "Thu lãi trước",
                      ),
                    ),
                  ],
                ),
                const CustomTextField(
                  isRequired: true,
                  label: "Lãi",
                  hintText: "Nhập số lãi",
                  type: CustomTextFieldType.text,
                  keyboardType: TextInputType.number,
                  suffixIcon: SizedBox(
                    width: 70,
                    height: 30,
                    child: Center(
                      child: TextWidget(
                        text: "K/1 ngày",
                        size: 12,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ),
                const CustomTextField(
                  isRequired: true,
                  label: "Kỳ lãi",
                  hintText: "Nhập số kỳ lãi",
                  keyboardType: TextInputType.number,
                  type: CustomTextFieldType.text,
                  suffixIcon: SizedBox(
                    width: 30,
                    height: 30,
                    child: Center(
                      child: TextWidget(
                        text: "Ngày",
                        size: 12,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ),
                const CustomTextField(
                  isRequired: true,
                  label: "Số ngày vay",
                  hintText: "Nhập số ngày vay",
                  keyboardType: TextInputType.number,
                  type: CustomTextFieldType.text,
                  suffixIcon: SizedBox(
                    width: 30,
                    height: 30,
                    child: Center(
                      child: TextWidget(
                        text: "Ngày",
                        size: 12,
                        color: AppColors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
