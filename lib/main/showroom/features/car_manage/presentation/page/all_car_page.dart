import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/extension/datetime.dart';
import 'package:auto_find/core/extension/empty_extension.dart';
import 'package:auto_find/core/ui/styles/app_container_styles.dart';
import 'package:auto_find/core/ui/styles/app_padding.dart';
import 'package:auto_find/core/ui/styles/app_text_styles.dart';
import 'package:auto_find/core/ui/widgets/filter/popup_dropdown/popup_dropdown_widget.dart';
import 'package:auto_find/core/ui/widgets/filter/sort/Sort_toggle_widget.dart';
import 'package:auto_find/core/ui/widgets/inputs/search_widget.dart';
import 'package:auto_find/core/ui/widgets/load_more_list_view_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/utils/custom_framework.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/controller/all_car_controller.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/page/car_detail_page.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/widget/car_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCarPage extends CustomState {
  const AllCarPage({super.key});

  @override
  String? get title => "Quản lý xe";

  @override
  bool get backgroundImage => true;

  @override
  bool get dismissKeyboard => true;

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();
}

class _BodyBuilder extends GetView<AllCarController> {
  const _BodyBuilder();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: AppContainerStyles.card200(),
          padding: AppPadding.all16,
          margin: AppPadding.h16,
          child: Column(
            children: [
              Row(
                children: List.generate(
                  controller.items.length,
                  (index) {
                    return Obx(
                      () {
                        final bool isActive =
                            controller.selectedIndex.value == index;
                        return GestureDetector(
                          onTap: () => controller.setSelected(index),
                          child: Container(
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color:
                                  isActive ? AppColors.accent : AppColors.grey,
                            ),
                            padding: AppPadding.v8h16,
                            child: TextWidget(
                              color: AppColors.white,
                              text: controller.items[index],
                              textStyle: AppTextStyle.medium14,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              const SearchWidget(
                height: 40,
              ),
              const SizedBox(height: 12),
              _FilterBarWidget(
                controller: controller,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        const _ListCarWidget()
      ],
    );
  }
}

class _ListCarWidget extends GetView<AllCarController> {
  const _ListCarWidget();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value && controller.cars.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: AppPadding.h16,
          child: RefreshIndicator(
            onRefresh: controller.refreshCars,
            child: LoadMoreListViewWidget<CarModel>(
              items: controller.cars,
              isLoading: controller.isLoading.value,
              isLoadMore: controller.isLoadMore.value,
              scrollController: controller.scrollController,
              dataNullWidget: const TextWidget(text: "Không có dữ liệu"),
              itemBuilder: (car) {
                return CarItemWidget(
                  carName: car.name.orNA(),
                  status: car.status.orNA(),
                  importDate: car.createdAt.toString().toVNDate(),
                  onTap: () {
                    Get.toNamed(
                      const CarDetailPage().routeName,
                      arguments: car,
                    );
                  },
                );
              },
            ),
          ),
        );
      }),
    );
  }
}

class _FilterBarWidget extends StatelessWidget {
  final AllCarController controller;
  const _FilterBarWidget({
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
