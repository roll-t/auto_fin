import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/data/model/item_model.dart';
import 'package:auto_fin/core/extension/empty_extension.dart';
import 'package:auto_fin/core/extension/rx_extension.dart';
import 'package:auto_fin/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';

class CustomBottomSheetWidget extends StatelessWidget {
  final BottomSheetController controller;
  final String? titleBottomSheet;
  final Color? backgroundColor;
  final List<BoxShadow>? shadow;
  final double borderRadius;
  final double height;
  final EdgeInsets padding;
  final String hint;
  final String? label;
  final Function(ItemModel) onSelectedItem;
  const CustomBottomSheetWidget({
    super.key,
    required this.onSelectedItem,
    required this.controller,
    this.backgroundColor,
    this.shadow,
    this.borderRadius = 6,
    this.height = 45,
    this.padding = const EdgeInsets.only(left: 15, right: 10),
    this.hint = "",
    this.label,
    this.titleBottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (label != null) ...[
          TextWidget(
            text: label.orNA(),
            size: 12,
            color: AppColors.text,
          )
        ],
        GestureDetector(
          onTap: () {
            controller.show(
              title: titleBottomSheet.orNA(),
              onSelected: onSelectedItem,
            );
          },
          child: Container(
            padding: padding,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor ?? AppColors.white,
              borderRadius: BorderRadius.circular(borderRadius),
              boxShadow: shadow ??
                  [
                    BoxShadow(
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                      color: AppColors.neutralColor2.withValues(alpha: 0.25),
                    )
                  ],
            ),
            child: controller.itemSelected.obx(
              onData: (value) {
                return Row(
                  children: [
                    if (value.title.orEmpty().isNotEmpty)
                      TextWidget(
                        text: value.title.orNA(),
                        size: 14,
                        color: AppColors.text,
                        maxLines: 1,
                      )
                    else
                      TextWidget(
                        text: hint,
                        size: 14,
                        color: AppColors.palette1,
                        maxLines: 1,
                      ),
                    const Spacer(),
                    const Icon(Icons.arrow_drop_down)
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
