import 'package:auto_fin/core/data/model/item_model.dart';
import 'package:auto_fin/core/extension/empty_extension.dart';
import 'package:auto_fin/core/ui/widgets/inputs/search_widget.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectBottomSheet extends StatelessWidget {
  final String title;
  final List<ItemModel> items;
  final void Function(ItemModel item) onSelected;
  final double? height;
  const SelectBottomSheet({
    super.key,
    required this.title,
    required this.items,
    required this.onSelected,
    this.height,
  });

  static void show({
    required String title,
    required List<ItemModel> items,
    required void Function(ItemModel item) onSelected,
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
      height: height ?? MediaQuery.of(context).size.height * .6,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Center(
            child: TextWidget(
              text: title,
              fontWeight: FontWeight.w500,
              size: 16,
            ),
          ),
          const SizedBox(height: 15),
          const SearchWidget(height: 45),
          const SizedBox(height: 25),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                ItemModel item = items[index];
                return ListTile(
                  title: TextWidget(text: item.title.orNA()),
                  onTap: () {
                    onSelected(item);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
