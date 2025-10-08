import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/config/const/app_padding.dart';
import 'package:auto_find/core/config/const/app_text_styles.dart';
import 'package:auto_find/core/config/const/app_vectors.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/extension/core/empty_extensions.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:auto_find/core/ui/widgets/buttons/index.dart';
import 'package:auto_find/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/ui/widgets/wrap_body_widget.dart';
import 'package:auto_find/core/utils/custom_state.dart';
import 'package:auto_find/core/utils/utils.dart';
import 'package:auto_find/main/pawn_shop/data/model/history_income_expenditure_arg.dart';
import 'package:auto_find/main/pawn_shop/features/income_expenditure_manage/presentation/controller/add_income_expenditure_controller.dart';
import 'package:auto_find/main/pawn_shop/features/income_expenditure_manage/presentation/page/history_income_expenditure_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddIncomeExpenditurePage extends CustomState {
  const AddIncomeExpenditurePage({super.key});
  @override
  String? get title => "Quản lý thu chi";

  @override
  bool get backgroundImage => true;

  @override
  bool get dismissKeyboard => true;

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();
}

class _BodyBuilder extends GetView<AddIncomeExpenditureController> {
  const _BodyBuilder();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: AppPadding.h16b30,
      child: Column(
        spacing: 16.0,
        children: [
          ///---> [RENDER HEADER SELECT SECTION FROM]
          _HeaderTabBar(),

          ///---> [RENDER MAIN BODY FROM]
          _BuildFrom(),
        ],
      ),
    );
  }
}

///---> [RENDER BODY FROM CHUYỂN GIỮA THU TIỀN VÀ CHI TIỀN]
class _BuildFrom extends StatelessWidget {
  const _BuildFrom();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddIncomeExpenditureController>(
      id: "TAB_FORM_BODY",
      builder: (controller) {
        return controller.headerTabSelectedIndex.value == 0
            ? const _BuildFromExpenditure()
            : const _BuildFromIncome();
      },
    );
  }
}

///---> [RENDER HEADER]
class _HeaderTabBar extends StatelessWidget {
  const _HeaderTabBar();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddIncomeExpenditureController>(
      id: "HEADER_ID",
      builder: (controller) {
        return WrapBodyWidget(
          child: SizedBox(
            height: 40,
            child: Row(
              spacing: 8.0,
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                controller.headerTabItem.length,
                (index) {
                  final item = controller.headerTabItem[index];
                  final bool isActive =
                      controller.headerTabSelectedIndex.value == index;

                  return GestureDetector(
                    onTap: () {
                      controller.headerTabSelectedIndex.value = index;
                      controller.update([
                        "HEADER_ID",
                        "TAB_FORM_BODY",
                      ]);
                    },
                    child: Container(
                      padding: AppPadding.h16,
                      decoration: BoxDecoration(
                        color:
                            isActive ? AppThemeColors.primary : AppColors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: TextWidget(
                          text: item.title.orNA(),
                          color: AppColors.white,
                          textStyle: AppTextStyle.medium14,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

///---> [RENDER FORM THU TIỀN]
class _BuildFromIncome extends StatelessWidget {
  const _BuildFromIncome();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddIncomeExpenditureController>(
      builder: (controller) {
        return WrapBodyWidget(
          header: Row(
            children: [
              const Expanded(
                child: TextWidget(
                  text: "Nhập phiếu thu tiền",
                  textStyle: AppTextStyle.medium14,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    const HistoryIncomeExpenditurePage().routeName,
                    arguments:
                        const HistoryIncomeExpenditureArg(isIncome: true),
                  );
                },
                child: Container(
                  height: 35,
                  padding: AppPadding.h16,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppThemeColors.primary.withValues(alpha: .5),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: AppThemeColors.primary.withValues(alpha: .2),
                  ),
                  child: Row(
                    spacing: 6.0,
                    children: [
                      Utils.iconSvg(
                        svgUrl: AppVectors.icHistory,
                        color: AppThemeColors.primary,
                        size: 20,
                      ),
                      TextWidget(
                        text: "Lịch sử thu",
                        color: AppThemeColors.primary,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          child: Column(
            spacing: 14.0,
            children: [
              const CustomTextField(
                isRequired: true,
                label: "Tên người nộp tiền",
                hintText: "Nhập tên người nộp tiền",
              ),
              const CustomTextField(
                isRequired: true,
                type: CustomTextFieldType.money,
                label: "Số tiền",
                hintText: "Nhập số tiền",
              ),
              CustomBottomSheetWidget(
                isRequired: true,
                height: 45,
                label: "Loại phiếu",
                hint: "Chọn",
                titleBottomSheet: "Chọn",
                controller: controller.filterCapital,
                onSelectedItem: (_) {},
              ),
              const CustomTextField(
                isRequired: true,
                type: CustomTextFieldType.textArea,
                label: "Lý do thu tiền",
                hintText: "Nhập lý do thu tiền",
                height: 80,
                maxLines: 6,
                minLines: 3,
              ),
              PrimaryButton(
                isMaxParent: true,
                backgroundColor: AppColors.blue,
                text: "Thu tiền",
                onPressed: () {},
              )
            ],
          ),
        );
      },
    );
  }
}

///---> [RENDER FORM CHI TIỀN]
class _BuildFromExpenditure extends StatelessWidget {
  const _BuildFromExpenditure();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddIncomeExpenditureController>(
      builder: (controller) {
        return WrapBodyWidget(
          header: Row(
            children: [
              const Expanded(
                child: TextWidget(
                  text: "Nhập phiếu chi tiền",
                  textStyle: AppTextStyle.medium14,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    const HistoryIncomeExpenditurePage().routeName,
                    arguments:
                        const HistoryIncomeExpenditureArg(isIncome: false),
                  );
                },
                child: Container(
                  height: 35,
                  padding: AppPadding.h16,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: AppThemeColors.primary.withValues(alpha: .5),
                    ),
                    borderRadius: BorderRadius.circular(10),
                    color: AppThemeColors.primary.withValues(alpha: .2),
                  ),
                  child: Row(
                    spacing: 6.0,
                    children: [
                      Utils.iconSvg(
                        svgUrl: AppVectors.icHistory,
                        color: AppThemeColors.primary,
                        size: 20,
                      ),
                      TextWidget(
                        text: "Lịch sử chi",
                        color: AppThemeColors.primary,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          child: Column(
            spacing: 14.0,
            children: [
              const CustomTextField(
                isRequired: true,
                label: "Tên người nhận",
                hintText: "Nhập tên người nhận",
              ),
              const CustomTextField(
                isRequired: true,
                type: CustomTextFieldType.money,
                label: "Số tiền",
                hintText: "Nhập số tiền",
              ),
              CustomBottomSheetWidget(
                isRequired: true,
                height: 45,
                label: "Loại phiếu",
                hint: "Chọn",
                titleBottomSheet: "Chọn",
                controller: controller.filterCapital,
                onSelectedItem: (_) {},
              ),
              const CustomTextField(
                isRequired: true,
                type: CustomTextFieldType.textArea,
                label: "Lý do thu tiền",
                hintText: "Nhập lý do thu tiền",
                height: 80,
                maxLines: 6,
                minLines: 3,
              ),
              PrimaryButton(
                isMaxParent: true,
                backgroundColor: AppColors.red,
                text: "Chi tiền",
                onPressed: () {},
              )
            ],
          ),
        );
      },
    );
  }
}
