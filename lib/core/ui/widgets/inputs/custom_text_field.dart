import 'package:auto_find/core/config/const/app_enum.dart';
import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/config/theme/app_theme_colors.dart';
import 'package:auto_find/core/extension/number_extensions.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:auto_find/core/ui/widgets/inputs/date_time_picker_text_field_widget.dart';
import 'package:auto_find/core/ui/widgets/inputs/year_picker_text_field_widget.dart';
import 'package:auto_find/core/utils/keyboard_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final Function(String)? onSubmit;

  final double borderRadius;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color disabledBorderColor;
  final Color errorBorderColor;
  final double borderWidth;
  final bool enableBorder;
  final EdgeInsets? scrollPadding;

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
    this.scrollPadding,
    this.onSubmit,
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
    this.enableBorder = true,
    this.backgroundColor,
    this.textColor,
    this.hintColor,
    this.labelColor,
    this.borderRadius = 8,
    this.borderColor = AppColors.text400,
    this.focusedBorderColor = AppColors.text300,
    this.disabledBorderColor = Colors.grey,
    this.errorBorderColor = Colors.red,
    this.borderWidth = .5,
    this.height = 45,
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
      case CustomTextFieldType.money:
        inputChild = _buildMoneyField();
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
          backgroundColor: enabled
              ? backgroundColor ?? AppColors.white
              : AppColors.neutralColor6,
        );
        break;
      case CustomTextFieldType.yearPicker:
        inputChild = YearPickerTextField(
          controller: controller ?? TextEditingController(),
          startYear: startYear ?? 2000,
          endYear: endYear ?? DateTime.now().year,
          onYearSelected: onYearSelected,
          enabled: enabled,
          backgroundColor: enabled
              ? backgroundColor ?? AppColors.white
              : AppColors.neutralColor6,
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
              color: labelColor ?? AppThemeColors.text,
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
      scrollPadding: scrollPadding ?? EdgeInsets.zero,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: obscureText ? 1 : maxLines,
      minLines: minLines,
      enabled: enabled,
      onChanged: onChanged,
      onSubmitted: onSubmit,
      style: TextStyle(
        color: textColor ?? AppColors.text700,
        fontSize: textSize ?? 14,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: enabled
            ? backgroundColor ?? AppColors.white
            : AppColors.neutralColor6,
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor ?? AppColors.palette2,
          fontSize: 14,
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

  Widget _buildMoneyField() {
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
      scrollPadding: scrollPadding ?? EdgeInsets.zero,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TextInputFormatter.withFunction((oldValue, newValue) {
          if (newValue.text.isEmpty) return newValue;

          // Dùng ext để format
          final formatted = newValue.text.toCurrency();

          return TextEditingValue(
            text: formatted,
            selection: TextSelection.collapsed(offset: formatted.length),
          );
        }),
      ],
      style: TextStyle(
        color: textColor ?? AppColors.text700,
        fontSize: textSize ?? 14,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: enabled
            ? backgroundColor ?? AppColors.white
            : AppColors.neutralColor6,
        hintText: hintText,
        hintStyle: TextStyle(
          color: hintColor ?? AppColors.palette2,
          fontSize: 14,
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
