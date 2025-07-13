import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/ui/widgets/images/asset_image_widget.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemMenuFeatureWidget extends StatelessWidget {
  final String title;
  final String? iconUrl;
  final String? routeNameUrl;
  const ItemMenuFeatureWidget({
    super.key,
    required this.title,
    this.iconUrl = "",
    this.routeNameUrl,
  });

  @override
  Widget build(BuildContext context) {
    final displayTitle = title.trim().isNotEmpty ? title : "N/A";
    return GestureDetector(
      onTap: () {
        Get.toNamed(routeNameUrl ?? "/");
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: AppThemeColors.lighter,
          ),
          borderRadius: BorderRadius.circular(6),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 3,
              offset: const Offset(2, 2),
              color: AppThemeColors.darker.withValues(
                alpha: .2,
              ),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: AssetImageWidget(
                assetPath: iconUrl ?? "",
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextWidget(
                    textAlign: TextAlign.center,
                    text: displayTitle,
                    size: 12,
                    maxLines: 2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
