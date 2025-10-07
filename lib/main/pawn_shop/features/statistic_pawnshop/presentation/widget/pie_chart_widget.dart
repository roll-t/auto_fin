import 'package:auto_find/core/config/const/app_text_styles.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/extension/core/currency_extensions.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/main/pawn_shop/features/statistic_pawnshop/data/model/pie_chart_data_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

/// Widget PieChart tái sử dụng
class PieChartWidget extends StatelessWidget {
  final List<PieChartDataModel> data;
  final String centerTitle;
  final double? height;
  final TextStyle? titleStyle;
  final TextStyle? percentStyle;

  const PieChartWidget({
    super.key,
    required this.data,
    required this.centerTitle,
    this.height = 220,
    this.titleStyle,
    this.percentStyle,
  });

  @override
  Widget build(BuildContext context) {
    final double total = data.fold(0, (sum, item) => sum + item.value);
    final double percent = total == 0
        ? 0
        : ((data
                        .firstWhere((e) => e.label == centerTitle,
                            orElse: () => PieChartDataModel('', 0, Colors.grey))
                        .value /
                    total) *
                100)
            .clamp(0, 100);

    return SizedBox(
      height: height,
      child: Row(
        children: [
          // === Biểu đồ vòng ===
          Expanded(
            flex: 3,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SfCircularChart(
                  margin: EdgeInsets.zero,
                  series: <DoughnutSeries<PieChartDataModel, String>>[
                    DoughnutSeries<PieChartDataModel, String>(
                      dataSource: data,
                      xValueMapper: (PieChartDataModel d, _) => d.label,
                      yValueMapper: (PieChartDataModel d, _) => d.value,
                      pointColorMapper: (PieChartDataModel d, _) => d.color,
                      radius: '90%',
                      innerRadius: '70%',
                      dataLabelSettings:
                          const DataLabelSettings(isVisible: false),
                    ),
                  ],
                ),
                // === Nội dung giữa vòng ===
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: centerTitle,
                      textStyle: AppTextStyle.semiBold14,
                    ),
                    TextWidget(
                      text: '${percent.toStringAsFixed(0)}%',
                      textStyle: AppTextStyle.semiBold14,
                      color: AppThemeColors.text300,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // === Legend bên phải ===
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: data.map(
                (e) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: e.color,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: TextWidget(
                            text: '${e.label}: ${"${e.value}".toCurrency()}',
                            textStyle: AppTextStyle.medium12,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
