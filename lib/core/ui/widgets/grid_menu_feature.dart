import 'package:auto_fin/features/main/model/item_menu_feature_model.dart';
import 'package:flutter/material.dart';
import 'item_menu_feature_widget.dart'; // Import widget con của bạn

class GridMenuFeature extends StatelessWidget {
  final List<ItemMenuFeatureModel> items;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;

  const GridMenuFeature({
    super.key,
    required this.items,
    this.crossAxisCount = 3,
    this.crossAxisSpacing = 16,
    this.mainAxisSpacing = 16,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
      ),
      itemBuilder: (context, index) {
        final dataItem = items[index];
        return ItemMenuFeatureWidget(
          title: dataItem.title,
          iconUrl: dataItem.iconUrl,
          routeNameUrl: dataItem.routeNameUrl,
        );
      },
    );
  }
}
