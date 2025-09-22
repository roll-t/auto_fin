import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/page/car_detail_page.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/widget/car_sold_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CarProfitSection extends StatelessWidget {
  final List<CarModel> soldCars;

  const CarProfitSection({
    super.key,
    required this.soldCars,
  });

  @override
  Widget build(BuildContext context) {
    if (soldCars.isEmpty) {
      return const Center(
        child: TextWidget(
          text: "Không có dữ liệu xe đã bán",
          color: AppColors.grey,
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(
        bottom: 40,
        left: 16,
        right: 16,
      ),
      itemCount: soldCars.length,
      itemBuilder: (context, index) {
        final car = soldCars[index];
        return CarSoldItemWidget(
          carModel: car,
          onTap: () {
            Get.toNamed(
              const CarDetailPage().routeName,
              arguments: car,
            );
          },
        );
      },
    );
  }
}
