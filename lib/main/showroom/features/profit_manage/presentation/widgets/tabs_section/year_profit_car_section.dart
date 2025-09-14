import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/ui/styles/app_container_styles.dart';
import 'package:auto_find/core/ui/widgets/filter/popup_dropdown/popup_dropdown_widget.dart';
import 'package:auto_find/core/ui/widgets/inputs/search_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_span_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/main/showroom/features/profit_manage/presentation/controller/profit_manage_controller.dart';
import 'package:auto_find/main/showroom/features/profit_manage/presentation/controller/tabs_section/year_profit_car_section_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class YearProfitCarSection extends GetView<YearProfitCarSectionController> {
  final ProfitManageController profitManageController;
  const YearProfitCarSection({
    super.key,
    required this.profitManageController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(children: [
            CustomPopupDropdown(controller: controller.filterCarPopup),
            const SizedBox(width: 50),
            const Expanded(
              child: SearchWidget(
                height: 40,
                backgroundColor: AppColors.white,
              ),
            )
          ]),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            shrinkWrap: false,
            itemBuilder: (context, index) {
              return const ProfitYearCard();
            },
          ),
        ),
      ],
    );
  }
}

class ProfitYearCard extends StatelessWidget {
  const ProfitYearCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: AppContainerStyles.card100(),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: "Tháng 01 Năm 2021",
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: 8.0),
          TextSpanWidget(
            textColor2: AppColors.accent,
            textColor1: AppColors.grey,
            fontWeight2: FontWeight.bold,
            text1: "Lợi nhuận: ",
            text2: "8,823,900,000 VNĐ",
          ),
        ],
      ),
    );
  }
}
