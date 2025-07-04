import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:auto_fin/core/utils/utils.dart';
import 'package:flutter/material.dart';

class SearchCardWidget extends StatelessWidget {
  const SearchCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      prefixIcon: Padding(
        padding: const EdgeInsetsGeometry.all(10),
        child: Utils.iconSvg(
          svgUrl: AppIcons.icSearch,
        ),
      ),
      backgroundColor: AppColors.white,
      hintText: "Nhập tên xe tìm kiếm....",
      borderRadius: 10,
      borderColor: AppThemeColors.lightest,
      borderWidth: 1,
    );
  }
}
