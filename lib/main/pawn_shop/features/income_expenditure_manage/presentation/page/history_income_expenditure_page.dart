import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/config/const/app_padding.dart';
import 'package:auto_find/core/config/const/app_text_styles.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:auto_find/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:auto_find/core/ui/widgets/inputs/search_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_span_currency.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/ui/widgets/wrap_body_widget.dart';
import 'package:auto_find/core/utils/custom_state.dart';
import 'package:auto_find/main/pawn_shop/features/capital_manage/presentation/widgets/contract_item_widget.dart';
import 'package:auto_find/main/pawn_shop/features/income_expenditure_manage/presentation/controller/history_income_expenditure_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HistoryIncomeExpenditurePage extends CustomState {
  const HistoryIncomeExpenditurePage({super.key});

  @override
  Widget? get appBar => const _BuildAppBar();

  @override
  bool get backgroundImage => true;

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();
}

class _BuildAppBar extends StatelessWidget {
  const _BuildAppBar();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryIncomeExpenditureController>(
      id: "TITLE_PAGE_ID",
      builder: (controller) {
        return TextWidget(
          maxLines: 2,
          text: controller.titlePage.value,
          textStyle: AppTextStyle.medium20,
          color: AppColors.white,
        );
      },
    );
  }
}

///=============================== [LAYOUT COMPONENTS] ====================================
///---> [RENDER MAIN BODY]
class _BodyBuilder extends StatelessWidget {
  const _BodyBuilder();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: AppPadding.h16,
      child: Column(
        spacing: 16.0,
        children: [
          ///---> [RENDER FILTER LỊCH SỬ THU CHI]
          _BuildFilter(),

          ///---> [RENDER LIST LỊCH SỬ THU CHI]
          _BuildList(),
        ],
      ),
    );
  }
}

class _BuildFilter extends StatelessWidget {
  const _BuildFilter();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HistoryIncomeExpenditureController>(
      builder: (controller) {
        return WrapBodyWidget(
          header: Column(
            spacing: 12.0,
            children: [
              const Row(
                spacing: 12.0,
                children: [
                  Expanded(
                    child: CustomTextField(
                      hintText: "Từ ngày",
                      type: CustomTextFieldType.datePicker,
                    ),
                  ),
                  Expanded(
                    child: CustomTextField(
                      hintText: "Đến ngày",
                      type: CustomTextFieldType.datePicker,
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 12.0,
                children: [
                  Expanded(
                    flex: 2,
                    child: SearchWidget(
                      hint: "Nhập tên người góp vốn",
                      onSubmit: (_) {},
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomBottomSheetWidget(
                      height: 45,
                      hint: "Chọn",
                      titleBottomSheet: "Chọn",
                      controller: controller.filterCapital,
                      onSelectedItem: (_) {},
                    ),
                  ),
                ],
              ),
            ],
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.0,
            children: [
              TextSpanCurrency(
                label: "Tổng tiền",
                value: "1260000000",
                textColor: AppColors.blue,
                isCurrency: true,
              ),
            ],
          ),
        );
      },
    );
  }
}

///---> [LIST LỊCH SỬ THU CHI]
class _BuildList extends StatelessWidget {
  const _BuildList();

  @override
  Widget build(BuildContext context) {
    final contracts = [
      {
        "customerName": "Ngân Hàng Agribank CN Vị Thủy",
        "amount": "1100000000",
        "contractType": "Đi vay",
        "interestRate": "0.564%",
        "paidInterest": "0",
        "contributeDate": "2025-04-21",
        "dueDate": "2025-07-19",
        "status": "Nợ lãi",
      },
    ];

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 30),
        itemCount: 20,
        itemBuilder: (index, context) {
          return ContractItemWidget(
            customerName: contracts[0]["customerName"]!,
            amount: contracts[0]["amount"]!,
            contractType: contracts[0]["contractType"]!,
            interestRate: contracts[0]["interestRate"]!,
            paidInterest: contracts[0]["paidInterest"]!,
            contributeDate: contracts[0]["contributeDate"]!,
            dueDate: contracts[0]["dueDate"]!,
            status: contracts[0]["status"]!,
            onTap: () {},
            onDeleteItem: () {},
          );
        },
      ),
    );
  }
}
