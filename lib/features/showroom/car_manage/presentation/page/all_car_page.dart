import 'package:auto_fin/core/ui/widgets/filter/popup_dropdown/popup_dropdown_widget.dart';
import 'package:auto_fin/core/ui/widgets/filter/sort/Sort_toggle_widget.dart';
import 'package:auto_fin/core/ui/widgets/inputs/search_widget.dart';
import 'package:auto_fin/core/ui/widgets/standard_layout_widget.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/controller/all_car_controller.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/page/car_detail_page.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/widget/car_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCarPage extends GetView<AllCarController> {
  static String routeName = "/AllCarPage";
  const AllCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardLayoutWidget(
      padding: const EdgeInsets.only(top: 20),
      titleAppBar: "Toàn bộ xe",

      ///---> [Build-body]
      bodyBuilder: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SearchWidget(
                  height: 45,
                ),
                const SizedBox(height: 12),
                FilterBarWidget(
                  controller: controller,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8.0),
          const ListCarWidget()
        ],
      ),
    );
  }
}

class ListCarWidget extends StatelessWidget {
  const ListCarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 10,
        itemBuilder: (context, index) {
          return CarItemWidget(
            carName: 'Xe Toyota Altis',
            status: 'Đang ở Auto',
            importDate: '11/02/2002',
            onTap: () {
              Get.toNamed(CarDetailPage.routeName);
            },
          );
        },
      ),
    );
  }
}

class FilterBarWidget extends StatelessWidget {
  final AllCarController controller;
  const FilterBarWidget({
    super.key,
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomPopupDropdown(controller: controller.filterCarPopup),
        SortToggleWidget(controller: controller.sortController),
      ],
    );
  }
}
