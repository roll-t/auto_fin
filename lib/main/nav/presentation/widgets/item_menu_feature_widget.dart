import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/ui/styles/app_text_styles.dart';
import 'package:auto_find/core/ui/widgets/images/asset_image_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppThemeColors.primary.withValues(alpha: .05),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: AssetImageWidget(
                  assetPath: iconUrl ?? "",
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: TextWidget(
                    textAlign: TextAlign.center,
                    text: displayTitle,
                    textStyle: AppTextStyle.medium12,
                    maxLines: 2,
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
