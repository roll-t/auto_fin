import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isMaxParent;

  const PrimaryButton({
    required this.text,
    required this.onPressed,
    this.isMaxParent = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppThemeColors.primary,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onPressed,
      child: TextWidget(
        text: text,
        fontWeight: FontWeight.bold,
        size: 14,
        color: AppColors.white,
      ),
    );

    return isMaxParent
        ? ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: button,
          )
        : button;
  }
}
