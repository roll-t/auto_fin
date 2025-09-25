import 'package:auto_find/core/config/const/app_vectors.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/extension/datetime.dart';
import 'package:auto_find/core/extension/empty_extension.dart';
import 'package:auto_find/core/extension/currency_extensions.dart';
import 'package:auto_find/core/ui/styles/app_container_styles.dart';
import 'package:auto_find/core/ui/styles/app_padding.dart';
import 'package:auto_find/core/ui/widgets/texts/text_span_widget.dart';
import 'package:auto_find/core/utils/utils.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:flutter/material.dart';

class CarItemWidget extends StatelessWidget {
  final CarModel car;
  final VoidCallback? onTap;

  const CarItemWidget({
    super.key,
    required this.car,
    this.onTap,
  });

  static const _spaceV6 = SizedBox(height: 6.0);
  static const _spaceV8 = SizedBox(height: 8.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: AppPadding.v8,
        padding: AppPadding.v8h12,
        decoration: AppContainerStyles.card100(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Tiêu đề: Tên xe
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextSpanWidget(
                    lineHeight: 1.5,
                    maxLine: 2,
                    textColor1: AppColors.grey,
                    textColor2: AppColors.palette1,
                    fontWeight2: FontWeight.bold,
                    text1: "Tên xe: ",
                    text2: car.name.orNA(),
                  ),
                ),
                Utils.iconSvg(svgUrl: AppVectors.icArrowRight, size: 14),
              ],
            ),

            _spaceV8,

            /// Trạng thái + Ngày nhập
            Row(
              children: [
                Expanded(
                  child: TextSpanWidget(
                    textColor1: AppColors.grey,
                    textColor2: AppColors.green,
                    fontWeight2: FontWeight.bold,
                    text1: 'Trạng thái: ',
                    text2: car.status.orNA(),
                    size: 12,
                  ),
                ),
                TextSpanWidget(
                  textColor1: AppColors.grey,
                  textColor2: AppColors.palette1,
                  fontWeight2: FontWeight.bold,
                  text1: 'Ngày nhập: ',
                  text2: car.importDate.toString().toVNDate(),
                  size: 12,
                ),
              ],
            ),

            _spaceV6,

            TextSpanWidget(
              textColor1: AppColors.grey,
              textColor2: AppColors.red,
              fontWeight2: FontWeight.bold,
              text1: 'Giá nhập: ',
              text2: car.importPrice.toString().toCurrency(withSymbol: true),
              size: 12,
            ),
            _spaceV6,

            /// Biển số + Năm SX
            Row(
              children: [
                Expanded(
                  child: TextSpanWidget(
                    textColor1: AppColors.grey,
                    textColor2: AppColors.palette1,
                    fontWeight2: FontWeight.bold,
                    text1: 'Biển số: ',
                    text2: car.plate.orNA(),
                    size: 12,
                  ),
                ),
                if (car.releaseYear?.isNotEmpty ?? false)
                  TextSpanWidget(
                    textColor1: AppColors.grey,
                    textColor2: AppColors.palette1,
                    fontWeight2: FontWeight.bold,
                    text1: 'Năm SX: ',
                    text2: car.releaseYear!,
                    size: 12,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
