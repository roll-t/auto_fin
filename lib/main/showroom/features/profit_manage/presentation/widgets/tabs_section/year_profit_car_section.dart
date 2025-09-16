import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/ui/styles/app_container_styles.dart';
import 'package:auto_find/core/ui/styles/app_text_styles.dart';
import 'package:auto_find/core/ui/widgets/texts/text_span_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/main/showroom/data/model/profit_matrix_response_model.dart';
import 'package:auto_find/main/showroom/features/profit_manage/presentation/controller/profit_manage_controller.dart';
import 'package:flutter/material.dart';

class YearProfitCarSection extends StatelessWidget {
  final ProfitManageController controller;
  const YearProfitCarSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final List<MonthProfit> listMonthProfit = controller.listMonthProfit;
    return ListView.builder(
      itemCount: listMonthProfit.length,
      itemBuilder: (context, index) {
        final MonthProfit monthProfit = listMonthProfit[index];
        return ProfitYearCard(monthProfit: monthProfit);
      },
    );
  }
}

class ProfitYearCard extends StatelessWidget {
  final MonthProfit monthProfit;
  const ProfitYearCard({
    super.key,
    required this.monthProfit,
  });

  @override
  Widget build(BuildContext context) {
    final displayMonth = monthProfit.month.toString().padLeft(2, '0');
    final displayYear = monthProfit.year.toString();
    final displayProfit = "${monthProfit.profit.toStringAsFixed(1)} triệu";

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: AppContainerStyles.card100(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: "Tháng $displayMonth Năm $displayYear",
            textStyle: AppTextStyle.semiBold14,
          ),
          const SizedBox(height: 8),
          TextSpanWidget(
            text1: "Lợi nhuận: ",
            text2: displayProfit,
            textColor1: AppColors.grey,
            textColor2: AppColors.accent,
            fontWeight2: FontWeight.bold,
          ),
        ],
      ),
    );
  }
}
