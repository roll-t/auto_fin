import 'package:auto_fin/core/config/theme/app_theme_colors.dart';
import 'package:auto_fin/core/data/model/popup_dropdown_model.dart';
import 'package:auto_fin/core/ui/widgets/filter/popup_dropdown/popup_dropdown_controller.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPopupDropdown extends StatelessWidget {
  final PopupDropdownController controller;
  const CustomPopupDropdown({
    super.key,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showPopupMenu(context),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.5,
              color: AppThemeColors.primary,
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => TextWidget(
                    text: controller.selectedItem.value.label,
                    size: 14,
                  ),
                ),
                const SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: AppThemeColors.primary,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showPopupMenu(BuildContext context) async {
    // Tìm vị trí widget trên màn hình
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    // Hiển thị popup ngay bên dưới
    final selected = await showMenu<PopupDropdownModel>(
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height + 5,
        offset.dx + size.width,
        offset.dy,
      ),
      items: controller.listItem
          .map(
            (item) => PopupMenuItem<PopupDropdownModel>(
              value: item,
              child: TextWidget(text: item.label),
            ),
          )
          .toList(),
    );

    if (selected != null) {
      controller.selectItem(selected);
    }
  }
}
