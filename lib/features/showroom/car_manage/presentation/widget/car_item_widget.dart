import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/ui/styles/app_container_styles.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_span_widget.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_fin/core/utils/utils.dart';
import 'package:flutter/material.dart';

class CarItemWidget extends StatelessWidget {
  final String carName;
  final String status;
  final String importDate;
  final VoidCallback? onTap;

  const CarItemWidget({
    super.key,
    required this.carName,
    required this.status,
    required this.importDate,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
        decoration: AppContainerStyles.cardStyle(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: carName,
                  fontWeight: FontWeight.bold,
                ),
                Utils.iconSvg(
                  svgUrl: AppIcons.icArrowRight,
                  size: 20,
                )
              ],
            ),
            const SizedBox(height: 6.0),
            TextSpanWidget(
              textColor1: AppColors.neutralColor2,
              textColor2: AppColors.darker1,
              fontWeight2: FontWeight.w500,
              text1: 'Trạng thái: ',
              text2: status,
              size: 12,
            ),
            const SizedBox(height: 6.0),
            TextSpanWidget(
              textColor1: AppColors.neutralColor2,
              textColor2: AppColors.darker1,
              fontWeight2: FontWeight.w500,
              text1: 'Ngày Nhập: ',
              text2: importDate,
              size: 12,
            ),
          ],
        ),
      ),
    );
  }
}
