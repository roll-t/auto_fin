import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final double? textSize;
  final TextEditingController? controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? leading;
  final bool enabled;
  final String? errorText;
  final int maxLines;
  final int minLines;
  final Function(String)? onChanged;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;
  final Color? labelColor;

  final double borderRadius;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color disabledBorderColor;
  final Color errorBorderColor;
  final double borderWidth;

  /// NEW
  final double? height;
  final List<BoxShadow>? boxShadow;

  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    this.textSize,
    this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.leading,
    this.enabled = true,
    this.errorText,
    this.maxLines = 1,
    this.minLines = 1,
    this.onChanged,
    this.backgroundColor,
    this.textColor,
    this.hintColor,
    this.labelColor,
    this.borderRadius = 8,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = AppColors.light1,
    this.disabledBorderColor = Colors.grey,
    this.errorBorderColor = Colors.red,
    this.borderWidth = 1.0,
    this.height,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder buildBorder(Color color) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: color, width: borderWidth),
        );

    Widget textField = TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
      enabled: enabled,
      onChanged: onChanged,
      style: TextStyle(
        color: textColor ?? AppThemeColors.dark,
        fontSize: textSize ?? 12,
      ),
      decoration: InputDecoration(
        filled: backgroundColor != null,
        fillColor: backgroundColor,
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor ?? AppColors.neutralColor1,
          fontSize: 12,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorText: errorText,
        enabledBorder: buildBorder(borderColor),
        focusedBorder: buildBorder(focusedBorderColor),
        disabledBorder: buildBorder(disabledBorderColor),
        errorBorder: buildBorder(errorBorderColor),
        focusedErrorBorder: buildBorder(errorBorderColor),
        // adjust height via contentPadding
        contentPadding: EdgeInsets.symmetric(
          vertical: height != null ? (height! - 24) / 2 : 12,
          horizontal: 12,
        ),
      ),
    );

    if (leading != null) {
      textField = Row(
        children: [
          leading!,
          const SizedBox(width: 8),
          Expanded(child: textField),
        ],
      );
    }

    Widget decorated = Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: boxShadow,
      ),
      child: textField,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: labelColor ?? AppThemeColors.dark,
            ),
          ),
          const SizedBox(height: 6),
        ],
        decorated,
      ],
    );
  }
}
