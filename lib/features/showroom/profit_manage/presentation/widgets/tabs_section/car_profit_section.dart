import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/ui/styles/app_container_styles.dart';
import 'package:auto_fin/core/ui/widgets/filter/popup_dropdown/popup_dropdown_widget.dart';
import 'package:auto_fin/core/ui/widgets/inputs/search_widget.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_span_widget.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_fin/core/utils/utils.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/page/car_detail_page.dart';
import 'package:auto_fin/features/showroom/profit_manage/presentation/controller/tabs_section/car_profit_section_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarProfitSection extends GetView<CarProfitSectionController> {
  const CarProfitSection({super.key});

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
              child: SearchWidget(height: 40),
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
    return GestureDetector(
      onTap: () {
        Get.toNamed(CarDetailPage.routeName);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: AppContainerStyles.cardStyle2(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Expanded(
                  child: TextSpanWidget(
                    textColor1: AppColors.grey,
                    fontWeight2: FontWeight.bold,
                    text1: "Tên xe: ",
                    text2: "Toyota Vios 2019",
                  ),
                ),
                TextWidget(
                  text: "Xe đã bán",
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: AppColors.greeen,
                )
              ],
            ),
            const SizedBox(height: 8.0),
            const TextSpanWidget(
              textColor1: AppColors.grey,
              fontWeight2: FontWeight.bold,
              text1: "Biển số: ",
              text2: "95A-051.85",
            ),
            const SizedBox(height: 8.0),
            const TextSpanWidget(
              textColor1: AppColors.grey,
              fontWeight2: FontWeight.bold,
              text1: "Ngày bán: ",
              text2: "11/02/2002",
            ),
            const SizedBox(height: 8.0),
            const TextSpanWidget(
              textColor1: AppColors.grey,
              fontWeight2: FontWeight.bold,
              text1: "Giá bán: ",
              text2: "285,000,000 VND",
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: TextSpanWidget(
                    textColor2: AppThemeColors.secondary,
                    textColor1: AppColors.grey,
                    fontWeight2: FontWeight.bold,
                    text1: "Lợi nhuận: ",
                    text2: "8,823,900,000 VNĐ",
                  ),
                ),
                Utils.iconSvg(svgUrl: AppIcons.icArrowRight)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
