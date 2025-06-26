import 'package:auto_fin/core/config/const/app_dimensions.dart';
import 'package:flutter/material.dart';

class CustomRadio<T> extends StatelessWidget {
  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;

  const CustomRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppDimensions.radioSize,
      height: AppDimensions.radioSize,
      child: Radio<T>(
        value: value,
        groupValue: groupValue,
        onChanged: onChanged,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
