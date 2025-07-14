import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/ui/styles/app_container_styles.dart';
import 'package:auto_fin/core/ui/widgets/filter/popup_dropdown/popup_dropdown_widget.dart';
import 'package:auto_fin/core/ui/widgets/filter/sort/Sort_toggle_widget.dart';
import 'package:auto_fin/core/ui/widgets/inputs/search_widget.dart';
import 'package:auto_fin/core/ui/widgets/standard_layout_widget.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_span_widget.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_fin/core/utils/utils.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/controller/car_in_auto_controller.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/page/car_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarInAutoPage extends GetView<CarInAutoController> {
  static String routeName = "/CarInAutoPage";
  const CarInAutoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StandardLayoutWidget(
      padding: const EdgeInsets.only(top: 20),
      titleAppBar: "Xe đang ở Auto",

      ///---> [Build-body]
      bodyBuilder: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SearchWidget(
                  hint: "Nhập tên xe, biển số...",
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

class CarInfoCard extends StatelessWidget {
  const CarInfoCard({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(CarDetailPage.routeName);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: AppContainerStyles.cardStyle2(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Expanded(
                  child: TextSpanWidget(
                    textColor1: AppColors.grey,
                    fontWeight2: FontWeight.bold,
                    text1: "Tên xe: ",
                    text2: "Toyota Vios 2019",
                  ),
                ),
                TextWidget(
                  text: "Xe đang ở Auto",
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: AppColors.yellow,
                )
              ],
            ),
            const SizedBox(height: 8.0),
            const TextSpanWidget(
              textColor1: AppColors.grey,
              fontWeight2: FontWeight.bold,
              text1: "Biển số: ",
              text2: "95A-051.85",
            ),
            const SizedBox(height: 8.0),
            const TextSpanWidget(
              textColor1: AppColors.grey,
              fontWeight2: FontWeight.bold,
              text1: "Ngày Nhập: ",
              text2: "11/02/2002",
            ),
            const SizedBox(height: 8.0),
            const TextSpanWidget(
              textColor1: AppColors.grey,
              fontWeight2: FontWeight.bold,
              text1: "Giá Nhập: ",
              text2: "285,000,000 VND",
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                const Expanded(
                  child: TextSpanWidget(
                    textColor1: AppColors.grey,
                    fontWeight2: FontWeight.bold,
                    text1: "Giá Nêm Yết: ",
                    text2: "8,823,900,000 VNĐ",
                  ),
                ),
                Utils.iconSvg(svgUrl: AppIcons.icArrowRight)
              ],
            ),
          ],
        ),
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
        itemCount: 10,
        itemBuilder: (context, index) {
          return const CarInfoCard();
        },
      ),
    );
  }
}

class FilterBarWidget extends StatelessWidget {
  final CarInAutoController controller;
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
