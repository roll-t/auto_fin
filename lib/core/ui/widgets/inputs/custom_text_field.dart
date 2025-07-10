import 'package:auto_fin/core/config/const/enum.dart';
import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:auto_fin/core/ui/widgets/inputs/date_time_picker_text_field_widget.dart';
import 'package:auto_fin/core/ui/widgets/inputs/year_picker_text_field_widget.dart';
import 'package:auto_fin/core/utils/keyboard_utils.dart';
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
  final BottomSheetController? bottomSheetController;

  final double borderRadius;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color disabledBorderColor;
  final Color errorBorderColor;
  final double borderWidth;
  final bool enableBorder;

  final double? height;
  final List<BoxShadow>? boxShadow;

  /// NEW: type of input
  final CustomTextFieldType type;

  /// Dropdown-specific
  final VoidCallback? onTap;

  /// DatePicker-specific
  final DateTime? firstDate;
  final DateTime? lastDate;
  final Function(DateTime)? onDateSelected;

  /// YearPicker-specific
  final int? startYear;
  final int? endYear;
  final Function(int)? onYearSelected;

  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    this.textSize,
    this.controller,
    this.bottomSheetController,
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
    this.enableBorder = false,
    this.backgroundColor,
    this.textColor,
    this.hintColor,
    this.labelColor,
    this.borderRadius = 8,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = AppColors.light1,
    this.disabledBorderColor = Colors.grey,
    this.errorBorderColor = Colors.red,
    this.borderWidth = .5,
    this.height,
    this.boxShadow,
    this.type = CustomTextFieldType.text,
    this.onTap,
    this.firstDate,
    this.lastDate,
    this.onDateSelected,
    this.startYear,
    this.endYear,
    this.onYearSelected,
  });

  @override
  Widget build(BuildContext context) {
    Widget inputChild;

    switch (type) {
      case CustomTextFieldType.text:
        inputChild = _buildTextField();
        break;
      case CustomTextFieldType.dropdown:
        inputChild = InkWell(
          onTap: () {
            KeyboardUtils.hiddenKeyboard();
            onTap?.call();
          },
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: IgnorePointer(
            child: _buildTextField(),
          ),
        );
        break;
      case CustomTextFieldType.datePicker:
        inputChild = DateTimePickerTextField(
          controller: controller ?? TextEditingController(),
          firstDate: firstDate ?? DateTime(2000),
          lastDate: lastDate ?? DateTime.now(),
          onDateSelected: onDateSelected,
          enabled: enabled,
          backgroundColor:
              enabled ? backgroundColor ?? AppColors.white : AppColors.palette5,
        );
        break;
      case CustomTextFieldType.yearPicker:
        inputChild = YearPickerTextField(
          controller: controller ?? TextEditingController(),
          startYear: startYear ?? 2000,
          endYear: endYear ?? DateTime.now().year,
          onYearSelected: onYearSelected,
          enabled: enabled,
          backgroundColor:
              enabled ? backgroundColor ?? AppColors.white : AppColors.palette5,
        );
        break;
    }

    if (leading != null) {
      inputChild = Row(
        children: [
          leading!,
          const SizedBox(width: 8),
          Expanded(child: inputChild),
        ],
      );
    }

    Widget decorated = Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                blurRadius: 4,
                offset: const Offset(0, 1),
                color: AppColors.neutralColor2.withValues(alpha: 0.25),
              )
            ],
      ),
      child: inputChild,
    );

    decorated = IgnorePointer(
      ignoring: !enabled,
      child: decorated,
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

  Widget _buildTextField() {
    InputBorder buildBorder(Color color) => !enableBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(
              color: AppColors.transparent,
              width: 0,
            ),
          )
        : OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: color, width: borderWidth),
          );

    return TextField(
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
        filled: true,
        fillColor:
            enabled ? backgroundColor ?? AppColors.white : AppColors.palette5,
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
        contentPadding: EdgeInsets.symmetric(
          vertical: height != null ? (height! - 24) / 2 : 12,
          horizontal: 12,
        ),
      ),
    );
  }
}
