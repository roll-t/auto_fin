import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/core/config/theme/app_colors.dart';
import 'package:auto_fin/core/ui/widgets/standard_layout_widget.dart';
import 'package:auto_fin/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_fin/core/utils/utils.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/controller/all_car_controller.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/page/car_detail_page.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/widget/car_item_widget.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/widget/search_car_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCarPage extends GetView<AllCarController> {
  static String routeName = "/AllCarPage";
  const AllCarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const StandardLayoutWidget(
      padding: EdgeInsets.only(top: 20),
      titleAppBar: "Toàn bộ xe",

      ///---> [Build-body]
      bodyBuilder: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SearchCardWidget(),
                SizedBox(height: 12),
                FilterBarWidget(),
              ],
            ),
          ),
          SizedBox(height: 8.0),
          ListCarWidget()
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
  const FilterBarWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () {},
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2,
                  color: AppColors.white,
                ),
              ),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const TextWidget(
                      text: "Tất cả",
                      color: AppColors.white,
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Utils.iconSvg(svgUrl: AppIcons.icArrowDropDown),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const TextWidget(
                    text: "Mới nhất",
                    color: AppColors.white,
                  ),
                  const SizedBox(width: 10),
                  Utils.iconSvg(
                    svgUrl: AppIcons.icFilter,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
