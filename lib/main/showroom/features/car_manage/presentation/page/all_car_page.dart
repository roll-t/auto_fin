import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/extension/datetime.dart';
import 'package:auto_find/core/extension/empty_extension.dart';
import 'package:auto_find/core/extension/number_extensions.dart';
import 'package:auto_find/core/ui/styles/app_container_styles.dart';
import 'package:auto_find/core/ui/styles/app_padding.dart';
import 'package:auto_find/core/ui/styles/app_text_styles.dart';
import 'package:auto_find/core/ui/widgets/filter/popup_dropdown/popup_dropdown_widget.dart';
import 'package:auto_find/core/ui/widgets/filter/sort/Sort_toggle_widget.dart';
import 'package:auto_find/core/ui/widgets/inputs/search_widget.dart';
import 'package:auto_find/core/ui/widgets/load_more_list_view_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_span_widget.dart';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeaderTabBar(controller: controller),
              const SizedBox(height: 12),
              GetBuilder<AllCarController>(
                id: "HEADER_MANAGE_CAR_ID",
                builder: (_) {
                  ///---> [CARS IN SHOWROOM TAB]
                  if (controller.headerTabSelectedIndex.value == 1) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SearchWidget(
                          onSubmit: (value) {
                            controller.searchText.value = value;
                            controller.refreshCars();
                          },
                          height: 40,
                        ),
                        const SizedBox(height: 12),
                        _FilterBarWidget(controller: controller),
                        const SizedBox(height: 12),
                        TextSpanWidget(
                          text1: "Số lượng: ",
                          text2: "${controller.cars.length}",
                          textColor2: AppColors.accent,
                          fontWeight2: FontWeight.bold,
                        ),
                        const SizedBox(height: 8),
                        TextSpanWidget(
                          text1: "Giá trị kho: ",
                          text2:
                              "${controller.inventoryValue.value.toString().toCurrency()} VND",
                          textColor2: AppColors.accent,
                          fontWeight2: FontWeight.bold,
                        ),
                      ],
                    );
                  }

                  ///---> [CARS IN SHOWROOM TAB]
                  if (controller.headerTabSelectedIndex.value == 2) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        _FilterBarWidget(controller: controller),
                        const SizedBox(height: 12),
                        TextSpanWidget(
                          text1: "Tổng giá trị: ",
                          text2:
                              "${controller.soldValue.value.toString().toCurrency()} VND",
                          textColor2: AppColors.accent,
                          fontWeight2: FontWeight.bold,
                        ),
                        const SizedBox(height: 8),
                        TextSpanWidget(
                          text1: "Tổng lợi nhuận: ",
                          text2:
                              "${controller.profit.value.toString().toCurrency()} VND",
                          textColor2: AppColors.accent,
                          fontWeight2: FontWeight.bold,
                        ),
                      ],
                    );
                  }

                  ///---> [ALL CARS TAB]
                  return Column(
                    children: [
                      SearchWidget(
                        onSubmit: (value) {
                          controller.searchText.value = value;
                          controller.refreshCars();
                        },
                        height: 40,
                      ),
                      const SizedBox(height: 12),
                      _FilterBarWidget(
                        controller: controller,
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        const _ListCarWidget()
      ],
    );
  }
}

class _HeaderTabBar extends StatelessWidget {
  final AllCarController controller;
  final ScrollController tabScrollController = ScrollController();

  _HeaderTabBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: tabScrollController,
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(controller.headerTabItem.length, (index) {
          return Obx(() {
            final bool isActive =
                controller.headerTabSelectedIndex.value == index;

            return GestureDetector(
              onTap: () {
                controller.onSetSelectedHeaderTab(index);
                _scrollToCenter(index, context);
              },
              child: Container(
                margin: const EdgeInsets.only(right: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: isActive ? AppColors.accent : AppColors.grey,
                ),
                padding: AppPadding.v8h16,
                child: TextWidget(
                  color: AppColors.white,
                  text: (controller.headerTabItem[index].title).orNA(),
                  textStyle: AppTextStyle.medium14,
                ),
              ),
            );
          });
        }),
      ),
    );
  }

  void _scrollToCenter(int index, BuildContext context) {
    /// Lấy kích thước màn hình
    final screenWidth = MediaQuery.of(context).size.width;

    /// Tính offset của item theo index
    double itemWidth = 100; // tạm thời, hoặc đo bằng GlobalKey
    double spacing = 12; // như trong margin
    double targetOffset =
        index * (itemWidth + spacing) - (screenWidth / 2) + (itemWidth / 2);

    /// Giới hạn offset không bị âm hoặc vượt quá max
    targetOffset = targetOffset.clamp(
      0.0,
      tabScrollController.position.maxScrollExtent,
    );

    /// Animate scroll
    tabScrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
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
          return const Center(
            child: CircularProgressIndicator(),
          );
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
    final controllerPopup = controller.headerTabSelectedIndex.value == 0
        ? controller.filterCarPopup
        : controller.headerTabSelectedIndex.value == 1
            ? controller.filterCarInShowRoomPopup
            : controller.filterSoldCarPopup;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomPopupDropdown(
          controller: controllerPopup,
          onSelected: (value) {
            controller.onFilterChanged();
          },
        ),
        SortToggleWidget(controller: controller.sortController),
      ],
    );
  }
}
