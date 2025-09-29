import 'package:auto_find/core/config/const/app_vectors.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/extension/core/date_extensions.dart';
import 'package:auto_find/core/extension/core/empty_extensions.dart';
import 'package:auto_find/core/extension/core/currency_extensions.dart';
import 'package:auto_find/core/config/const/app_container_styles.dart';
import 'package:auto_find/core/config/const/app_padding.dart';
import 'package:auto_find/core/ui/widgets/texts/text_span_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/utils/utils.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarItemWidget extends StatelessWidget {
  final CarModel car;
  final VoidCallback? onTap;
  final VoidCallback? onDeleteItem;

  const CarItemWidget({
    super.key,
    required this.car,
    this.onTap,
    this.onDeleteItem,
  });

  static const _spaceV6 = SizedBox(height: 6.0);
  static const _spaceV8 = SizedBox(height: 8.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Get.bottomSheet(
          SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              child: Wrap(
                children: [
                  ListTile(
                    leading: const Icon(Icons.delete, color: AppColors.red),
                    title: const TextWidget(
                      text: "Xoá xe",
                      color: AppColors.red,
                    ),
                    onTap: () {
                      Get.back();
                      onDeleteItem?.call();
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.close),
                    title: const TextWidget(text: "Đóng"),
                    onTap: () => Get.back(),
                  ),
                ],
              ),
            ),
          ),
          backgroundColor: Colors.transparent,
        );
      },
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
                    textColor2: AppThemeColors.text100,
                    fontWeight2: FontWeight.w600,
                    text1: "Tên xe: ",
                    text2: car.name.orNA(),
                  ),
                ),
                Utils.iconSvg(svgUrl: AppVectors.icArrowRight, size: 14),
              ],
            ),
            _spaceV8,

            Row(
              children: [
                /// Giá nhập
                Expanded(
                  child: TextSpanWidget(
                    maxLine: 1,
                    textColor1: AppColors.grey,
                    textColor2: AppColors.red,
                    fontWeight2: FontWeight.w600,
                    text1: 'Giá nhập: ',
                    text2:
                        car.importPrice.toString().toCurrency(withSymbol: true),
                    size: 14,
                  ),
                ),

                TextSpanWidget(
                  maxLine: 1,
                  textColor1: AppColors.grey,
                  textColor2: AppThemeColors.text100,
                  fontWeight2: FontWeight.w500,
                  text1:
                      car.status == "Xe đã bán" ? "Ngày bán: " : "Ngày nhập: ",
                  text2: car.status == "Xe đã bán"
                      ? car.soldDate.toString().toVNDate()
                      : car.importDate.toString().toVNDate(),
                  size: 12,
                ),
              ],
            ),
            if ((car.soldPrice ?? 0) > 0)
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: TextSpanWidget(
                  textColor1: AppColors.grey,
                  textColor2: AppColors.blue,
                  fontWeight2: FontWeight.w600,
                  text1: 'Giá bán: ',
                  text2: car.soldPrice.toString().toCurrency(withSymbol: true),
                  size: 14,
                ),
              ),

            if ((car.profit ?? 0) > 0)
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: TextSpanWidget(
                  textColor1: AppColors.grey,
                  textColor2: AppColors.green,
                  fontWeight2: FontWeight.w600,
                  text1: 'Lợi nhuận: ',
                  text2: car.profit.toString().toCurrency(withSymbol: true),
                  size: 14,
                ),
              ),

            _spaceV6,

            /// Biển số + Năm SX
            Row(
              children: [
                Expanded(
                  child: TextSpanWidget(
                    maxLine: 1,
                    textColor1: AppColors.grey,
                    textColor2: AppThemeColors.text100,
                    fontWeight2: FontWeight.w500,
                    text1: 'Biển số: ',
                    text2: car.plate.orNA(),
                    size: 14,
                  ),
                ),

                /// Trạng thái
                TextSpanWidget(
                  maxLine: 1,
                  textColor1: AppColors.grey,
                  textColor2:
                      car.status == "Đã bán" ? AppColors.red : AppColors.green,
                  fontWeight2: FontWeight.w600,
                  text1: 'Trạng thái: ',
                  text2: car.status.orNA(),
                  size: 12,
                ),
              ],
            ),

            if ((car.soldDes?.isNotEmpty ?? false) &&
                car.status == "Xe đã bán") ...[
              const SizedBox(height: 6.0),
              TextSpanWidget(
                maxLine: 2,
                textColor1: AppColors.grey,
                textColor2: AppThemeColors.text100,
                fontStyle2: FontStyle.italic,
                text1: 'Ghi chú bán: ',
                text2: car.soldDes.orEmpty(),
                size: 14,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
