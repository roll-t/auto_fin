import 'package:auto_find/core/config/const/app_vectors.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/extension/core/date_extensions.dart';
import 'package:auto_find/core/extension/core/empty_extensions.dart';
import 'package:auto_find/core/extension/core/currency_extensions.dart';
import 'package:auto_find/core/config/const/app_container_styles.dart';
import 'package:auto_find/core/config/const/app_padding.dart';
import 'package:auto_find/core/ui/widgets/texts/text_span_widget.dart';
import 'package:auto_find/core/utils/utils.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:flutter/material.dart';

class CarSoldItemWidget extends StatelessWidget {
  final CarModel carModel;
  final VoidCallback? onTap;

  const CarSoldItemWidget({
    super.key,
    required this.carModel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final profit = carModel.profit ?? 0;
    final profitColor = profit >= 0 ? AppColors.green : AppColors.red;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: AppPadding.v8,
        padding: AppPadding.v8h12,
        decoration: AppContainerStyles.card100(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Row tiêu đề
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextSpanWidget(
                    lineHeight: 1.5,
                    maxLine: 2,
                    textColor1: AppColors.grey,
                    textColor2: AppThemeColors.text100,
                    fontWeight2: FontWeight.w500,
                    text1: "Tên xe: ",
                    text2: carModel.name.orNA(),
                  ),
                ),
                Utils.iconSvg(
                  svgUrl: AppVectors.icArrowRight,
                  size: 14,
                )
              ],
            ),

            const SizedBox(height: 8.0),

            /// Ngày bán
            Row(
              children: [
                /// Trạng thái
                Expanded(
                  child: TextSpanWidget(
                    textColor1: AppColors.grey,
                    textColor2: AppColors.green,
                    fontWeight2: FontWeight.w500,
                    text1: 'Trạng thái: ',
                    text2: carModel.status.orNA(),
                    size: 14,
                  ),
                ),
                const SizedBox(height: 6.0),
                TextSpanWidget(
                  textColor1: AppColors.grey,
                  textColor2: AppThemeColors.text100,
                  fontWeight2: FontWeight.w500,
                  text1: 'Ngày bán: ',
                  text2: (carModel.soldDate).toString().toVNDate(),
                  size: 14,
                ),
              ],
            ),

            const SizedBox(height: 6.0),

            /// Giá nhập
            TextSpanWidget(
              textColor1: AppColors.grey,
              textColor2: AppColors.red,
              fontWeight2: FontWeight.w500,
              text1: 'Giá nhập: ',
              text2:
                  carModel.importPrice.toString().toCurrency(withSymbol: true),
              size: 14,
            ),

            const SizedBox(height: 6.0),

            /// Giá bán
            TextSpanWidget(
              textColor1: AppColors.grey,
              textColor2: AppColors.blue,
              fontWeight2: FontWeight.w500,
              text1: 'Giá bán: ',
              text2: carModel.soldPrice.toString().toCurrency(withSymbol: true),
              size: 14,
            ),

            const SizedBox(height: 6.0),

            /// Lợi nhuận
            TextSpanWidget(
              textColor1: AppColors.grey,
              textColor2: profitColor,
              fontWeight2: FontWeight.w500,
              text1: 'Lợi nhuận: ',
              text2: profit.toString().toCurrency(withSymbol: true),
              size: 14,
            ),

            const SizedBox(height: 6.0),

            /// Biển số + Năm SX
            Row(
              children: [
                Expanded(
                  child: TextSpanWidget(
                    textColor1: AppColors.grey,
                    textColor2: AppThemeColors.text100,
                    fontWeight2: FontWeight.w500,
                    text1: 'Biển số: ',
                    text2: carModel.plate.orNA(),
                    size: 14,
                  ),
                ),
                TextSpanWidget(
                  textColor1: AppColors.grey,
                  textColor2: AppThemeColors.text100,
                  fontWeight2: FontWeight.w500,
                  text1: 'Năm SX: ',
                  text2: carModel.releaseYear.orNA(),
                  size: 14,
                ),
              ],
            ),

            if (carModel.soldDes?.isNotEmpty ?? false) ...[
              const SizedBox(height: 6.0),
              TextSpanWidget(
                textColor1: AppColors.grey,
                textColor2: AppThemeColors.text100,
                fontStyle2: FontStyle.italic,
                text1: 'Ghi chú: ',
                text2: carModel.soldDes!,
                size: 14,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
