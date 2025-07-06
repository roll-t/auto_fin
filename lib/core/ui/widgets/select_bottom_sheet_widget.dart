import 'package:auto_fin/core/data/model/item_model.dart';
import 'package:auto_fin/core/extension/empty_extension.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectBottomSheet extends StatelessWidget {
  final String title;
  final List<ItemModel> items;
  final void Function(String) onSelected;

  const SelectBottomSheet({
    super.key,
    required this.title,
    required this.items,
    required this.onSelected,
  });

  static void show({
    required String title,
    required List<ItemModel> items,
    required void Function(String) onSelected,
  }) {
    Get.bottomSheet(
      SelectBottomSheet(
        title: title,
        items: items,
        onSelected: onSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Wrap(
        children: [
          const SizedBox(height: 15),
          Center(
            child: TextWidget(
              text: title,
              fontWeight: FontWeight.w500,
              size: 14,
            ),
          ),
          const SizedBox(height: 30),
          ...items.map((item) {
            return ListTile(
              title: TextWidget(text: item.title.orNA()),
              onTap: () {
                onSelected(item.title.orNA());
                Get.back();
              },
            );
          }).toList(),
        ],
      ),
    );
  }
}
