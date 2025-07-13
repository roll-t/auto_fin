import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:auto_fin/core/utils/utils.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final Function(String value)? onSearch;
  final double height;
  final String hint;
  const SearchWidget({
    super.key,
    this.hint = "Nhập nội dung tìm kiếm....",
    this.onSearch,
    this.height = 45,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onChanged: onSearch,
      enableBorder: true,
      borderColor: AppThemeColors.lighter,
      borderWidth: 1,
      textSize: 14,
      hintText: hint,
      prefixIcon: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Utils.iconSvg(
          color: AppColors.grey.withValues(alpha: .5),
          svgUrl: AppIcons.icSearch,
          size: 20,
        ),
      ),
      backgroundColor: AppColors.white,
      boxShadow: const [],
      height: height,
    );
  }
}
