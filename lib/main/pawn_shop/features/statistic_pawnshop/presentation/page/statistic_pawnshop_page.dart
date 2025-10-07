import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/config/const/app_padding.dart';
import 'package:auto_find/core/config/const/app_text_styles.dart';
import 'package:auto_find/core/config/const/app_vectors.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/extension/export/extension.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/custom_bottom_sheet_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/ui/widgets/wrap_body_widget.dart';
import 'package:auto_find/core/utils/custom_state.dart';
import 'package:auto_find/main/pawn_shop/features/statistic_pawnshop/data/model/pie_chart_data_model.dart';
import 'package:auto_find/main/pawn_shop/features/statistic_pawnshop/data/model/row_table_data_model.dart';
import 'package:auto_find/main/pawn_shop/features/statistic_pawnshop/presentation/controller/statistic_pawnshop_controller.dart';
import 'package:auto_find/main/pawn_shop/features/statistic_pawnshop/presentation/widget/info_table_widget.dart';
import 'package:auto_find/main/pawn_shop/features/statistic_pawnshop/presentation/widget/pie_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class StatisticPawnshopPagePage extends CustomState {
  const StatisticPawnshopPagePage({super.key});

  @override
  String? get title => "Thống kê chung";

  @override
  bool get backgroundImage => true;

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();
}

class _BodyBuilder extends StatelessWidget {
  const _BodyBuilder();

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 50,
      ),
      child: Column(
        spacing: 16.0,
        children: [
          ///---> [RENDER LIST THỐNG KÊ]
          _BuildListStatistic(),

          ///---> [RENDER SƠ ĐỒ TRÒN]
          _BuildBodyPieChart(),

          ///---> [RENDER BẢN THỐNG KÊ]
          _BuildTableStatistic(),
        ],
      ),
    );
  }
}

class _BuildTableStatistic extends StatelessWidget {
  const _BuildTableStatistic();

  @override
  Widget build(BuildContext context) {
    return InfoTable(
      rows: [
        RowTableDataModel("Cầm đồ", 46, 2418),
        RowTableDataModel("Tín chấp", 46, 2418),
        RowTableDataModel("Trả góp", 10, 1500),
      ],
    );
  }
}

class _BuildBodyPieChart extends GetView<StatisticPawnshopController> {
  const _BuildBodyPieChart();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        WrapBodyWidget(
          header: Row(
            children: [
              const Expanded(
                child: TextWidget(
                  maxLines: 2,
                  text: "Đang cho vay",
                  textStyle: AppTextStyle.semiBold14,
                ),
              ),
              Expanded(
                child: CustomBottomSheetWidget(
                  leadingIconUrl: AppVectors.icCurrency,
                  height: 30,
                  hint: "Chọn đơn vị tiền",
                  titleBottomSheet: "Chọn đơn vị tiền tệ",
                  controller: controller.currencyUnitControllerV1,
                  onSelectedItem: controller.onCurrencyUnitChangedV1,
                ),
              ),
            ],
          ),
          child: Column(
            children: [
              PieChartWidget(
                centerTitle: 'Tín Chấp',
                data: [
                  PieChartDataModel('Cầm đồ', 4885500000, Colors.purple),
                  PieChartDataModel('Tín Chấp', 3026350000, Colors.pink),
                  PieChartDataModel('Trả Góp', 0, Colors.teal),
                ],
              )
            ],
          ),
        ),
        WrapBodyWidget(
          header: Row(
            children: [
              const Expanded(
                child: TextWidget(
                  maxLines: 2,
                  text: "Lợi nhuận",
                  textStyle: AppTextStyle.semiBold14,
                ),
              ),
              Expanded(
                child: CustomBottomSheetWidget(
                  leadingIconUrl: AppVectors.icCurrency,
                  height: 30,
                  hint: "Chọn đơn vị tiền",
                  titleBottomSheet: "Chọn đơn vị tiền tệ",
                  controller: controller.currencyUnitControllerV2,
                  onSelectedItem: controller.onCurrencyUnitChangedV2,
                ),
              ),
            ],
          ),
          child: Column(
            children: [
              PieChartWidget(
                centerTitle: 'Tín Chấp',
                data: [
                  PieChartDataModel('Cầm đồ', 4885500000, Colors.purple),
                  PieChartDataModel('Tín Chấp', 3026350000, Colors.pink),
                  PieChartDataModel('Trả Góp', 0, Colors.teal),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class _BuildListStatistic extends GetView<StatisticPawnshopController> {
  const _BuildListStatistic();

  @override
  Widget build(BuildContext context) {
    return WrapBodyWidget(
      child: Column(
        spacing: 8.0,
        children: [
          Row(
            spacing: 8.0,
            children: [
              _BuildItemStatistic(
                title: "TỔNG QUỸ TIỀN MẶT",
                value: "900000000000".toCurrency(withSymbol: true),
                colorTitle: AppColors.blue,
              ),
              const _BuildItemStatistic(
                title: "Số hợp đồng đang vay",
                value: "53",
                colorTitle: AppColors.text600,
              ),
            ],
          ),
          Row(
            spacing: 8.0,
            children: [
              _BuildItemStatistic(
                title: "Tiền đang cho vay",
                value: "79000000000".toCurrency(withSymbol: true),
                colorTitle: AppColors.red,
              ),
              _BuildItemStatistic(
                title: "Lãi đã thu trong tháng",
                value: "62002000".toCurrency(withSymbol: true),
                colorTitle: AppColors.green,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _BuildItemStatistic extends StatelessWidget {
  final String? value;
  final String? title;
  final Color? colorTitle;
  const _BuildItemStatistic({
    this.value,
    this.title,
    this.colorTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: AppPadding.all8,
        decoration: BoxDecoration(
          color: AppThemeColors.primary.withValues(alpha: .04),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          spacing: 6.0,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget(
              maxLines: 1,
              textAlign: TextAlign.start,
              text: value.orNA(),
              textStyle: AppTextStyle.semiBold14,
              color: colorTitle ?? AppColors.blue,
            ),
            TextWidget(
              maxLines: 1,
              text: title.orNA(),
              textStyle: AppTextStyle.medium12,
              transform: TextTransformType.capitalizeWords,
            ),
          ],
        ),
      ),
    );
  }
}
