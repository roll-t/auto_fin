import 'package:auto_fin/core/config/const/app_dimens.dart';
import 'package:auto_fin/core/config/enum.dart';
import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double? size;
  final Color color;
  final int? maxLines;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final List<Shadow>? listShadow;
  final TextDecoration? textDecoration;
  final FontStyle? fontStyle;
  final String? fontFamily;
  final TextTransformType transform;

  const TextWidget({
    super.key,
    this.textAlign,
    this.listShadow,
    this.maxLines = 1000,
    required this.text,
    this.color = AppColors.palette2,
    this.size = AppDimens.fontSizeMedium,
    this.fontWeight = FontWeight.normal,
    this.fontStyle = FontStyle.normal,
    this.textDecoration = TextDecoration.none,
    this.fontFamily,
    this.transform = TextTransformType.normal,
  });

  String _applyTransform(String value) {
    switch (transform) {
      case TextTransformType.uppercase:
        return value.toUpperCase();
      case TextTransformType.lowercase:
        return value.toLowerCase();
      case TextTransformType.capitalize:
        if (value.isEmpty) return value;
        return value[0].toUpperCase() + value.substring(1).toLowerCase();
      case TextTransformType.capitalizeWords:
        return value
            .split(' ')
            .map(
              (word) =>
                  word.isNotEmpty
                      ? '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}'
                      : '',
            )
            .join(' ');
      case TextTransformType.normal:
        return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final transformedText = _applyTransform(text.tr);
    return Text(
      transformedText,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: fontFamily ?? "Roboto",
        color: color,
        fontSize: size,
        fontStyle: fontStyle,
        shadows: listShadow,
        fontWeight: fontWeight,
        decoration: textDecoration,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
