import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/config/const/app_container_styles.dart';
import 'package:auto_find/core/config/const/app_padding.dart';
import 'package:auto_find/core/extension/core/date_extensions.dart';
import 'package:auto_find/core/extension/core/currency_extensions.dart';
import 'package:auto_find/core/extension/core/empty_extensions.dart';
import 'package:auto_find/core/ui/widgets/texts/text_span_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/config/const/app_vectors.dart';
import 'package:auto_find/core/utils/utils.dart';

class ContractItemWidget extends StatelessWidget {
  final String customerName;
  final String amount;
  final String contractType;
  final String interestRate;
  final String paidInterest;
  final String contributeDate;
  final String dueDate;
  final String status;
  final String? note;
  final VoidCallback? onTap;
  final VoidCallback? onDeleteItem;

  const ContractItemWidget({
    super.key,
    required this.customerName,
    required this.amount,
    required this.contractType,
    required this.interestRate,
    required this.paidInterest,
    required this.contributeDate,
    required this.dueDate,
    required this.status,
    this.note,
    this.onTap,
    this.onDeleteItem,
  });

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
                      text: "Xoá hợp đồng",
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
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: AppPadding.v8h12,
        decoration: AppContainerStyles.card100(),
        child: Column(
          spacing: 6.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Tên khách hàng
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TextSpanWidget(
                    maxLine: 2,
                    lineHeight: 1.5,
                    textColor1: AppColors.grey,
                    textColor2: AppThemeColors.text100,
                    fontWeight2: FontWeight.w600,
                    text1: "Khách hàng: ",
                    text2: customerName.orNA(),
                  ),
                ),
                Utils.iconSvg(svgUrl: AppVectors.icArrowRight, size: 14),
              ],
            ),
            const SizedBox(height: 2),
            /// Số tiền
            TextSpanWidget(
              maxLine: 1,
              textColor1: AppColors.grey,
              textColor2: AppColors.red,
              fontWeight2: FontWeight.w600,
              text1: 'Số tiền: ',
              text2: amount.toCurrency(withSymbol: true),
              size: 14,
            ),

            /// Loại vốn + Lãi suất
            Row(
              children: [
                Expanded(
                  child: TextSpanWidget(
                    maxLine: 1,
                    textColor1: AppColors.grey,
                    textColor2: AppThemeColors.text100,
                    text1: 'Loại: ',
                    text2: contractType.orNA(),
                    size: 13,
                  ),
                ),
                TextSpanWidget(
                  maxLine: 1,
                  textColor1: AppColors.grey,
                  textColor2: AppThemeColors.text100,
                  text1: 'Lãi suất: ',
                  text2: '$interestRate/tháng',
                  size: 13,
                ),
              ],
            ),

            /// Ngày góp + Ngày đóng lãi
            Row(
              children: [
                Expanded(
                  child: TextSpanWidget(
                    textColor1: AppColors.grey,
                    textColor2: AppThemeColors.text100,
                    text1: 'Ngày góp: ',
                    text2: contributeDate.toVNDate(),
                    size: 13,
                  ),
                ),
                TextSpanWidget(
                  textColor1: AppColors.grey,
                  textColor2: AppThemeColors.text100,
                  text1: 'Ngày đóng lãi: ',
                  text2: dueDate.toVNDate(),
                  size: 13,
                ),
              ],
            ),

            /// Tình trạng
            TextSpanWidget(
              textColor1: AppColors.grey,
              textColor2: status == "Nợ lãi" ? AppColors.red : AppColors.green,
              fontWeight2: FontWeight.bold,
              text1: 'Tình trạng: ',
              text2: status,
              size: 14,
            ),

            if (note?.isNotEmpty ?? false) ...[
              TextSpanWidget(
                textColor1: AppColors.grey,
                textColor2: AppThemeColors.text100,
                fontStyle2: FontStyle.italic,
                text1: 'Ghi chú: ',
                text2: note.orEmpty(),
                size: 13,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
