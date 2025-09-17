import 'package:auto_find/core/config/theme/app_colors.dart';
import 'package:auto_find/core/extension/empty_extension.dart';
import 'package:auto_find/core/extension/number_extensions.dart';
import 'package:auto_find/core/ui/styles/app_container_styles.dart';
import 'package:auto_find/core/ui/styles/app_padding.dart';
import 'package:auto_find/core/ui/styles/app_text_styles.dart';
import 'package:auto_find/core/ui/widgets/filter/popup_dropdown/popup_dropdown_widget.dart';
import 'package:auto_find/core/ui/widgets/filter/sort/sort_toggle_widget.dart';
import 'package:auto_find/core/ui/widgets/inputs/search_widget.dart';
import 'package:auto_find/core/ui/widgets/load_more_list_view_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_span_widget.dart';
import 'package:auto_find/core/ui/widgets/texts/text_widget.dart';
import 'package:auto_find/core/utils/custom_framework.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/controller/car_manage_controller.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/page/car_detail_page.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/widget/car_in_showroom_item_widget.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/widget/car_item_widget.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/widget/car_sold_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// ----------------------------
/// MAIN PAGE
/// ----------------------------
class CarManagePage extends CustomState {
  const CarManagePage({super.key});

  @override
  String? get title => "Quản lý xe";

  @override
  bool get backgroundImage => true;

  @override
  bool get dismissKeyboard => true;

  @override
  Widget buildBody(BuildContext context) => const _BodyBuilder();
}

/// ----------------------------
/// BODY BUILDER
/// ----------------------------
class _BodyBuilder extends GetView<CarManageController> {
  const _BodyBuilder();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _HeaderSection(controller: controller),
        const SizedBox(height: 8),
        const _ListCarWidget(),
      ],
    );
  }
}

/// ----------------------------
/// HEADER SECTION (tabs + filter)
/// ----------------------------
class _HeaderSection extends StatelessWidget {
  final CarManageController controller;
  const _HeaderSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppContainerStyles.card200(),
      padding: AppPadding.all16,
      margin: AppPadding.h16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderTabBar(controller: controller),
          const SizedBox(height: 12),
          GetBuilder<CarManageController>(
            id: "HEADER_MANAGE_CAR_ID",
            builder: (_) {
              switch (controller.headerTabSelectedIndex.value) {
                case 1:
                  return _ShowroomTabContent(controller: controller);
                case 2:
                  return _SoldCarTabContent(controller: controller);
                default:
                  return _AllCarTabContent(controller: controller);
              }
            },
          ),
        ],
      ),
    );
  }
}

/// ----------------------------
/// TAB BAR
/// ----------------------------
class _HeaderTabBar extends StatelessWidget {
  final CarManageController controller;
  final ScrollController _scrollCtrl = ScrollController();

  _HeaderTabBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        controller: _scrollCtrl,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemCount: controller.headerTabItem.length,
        itemBuilder: (_, index) {
          return Obx(() {
            final isActive = controller.headerTabSelectedIndex.value == index;
            return GestureDetector(
              onTap: () {
                controller.onSetSelectedHeaderTab(index);
                _scrollToCenter(index, context);
              },
              child: Container(
                padding: AppPadding.h12,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.accent : AppColors.grey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: TextWidget(
                    text: controller.headerTabItem[index].title.orNA(),
                    color: AppColors.white,
                    textStyle: AppTextStyle.medium14,
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  void _scrollToCenter(int index, BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const itemWidth = 100.0;
    const spacing = 12.0;
    double target =
        index * (itemWidth + spacing) - (screenWidth / 2) + (itemWidth / 2);
    target = target.clamp(
      0.0,
      _scrollCtrl.position.maxScrollExtent,
    );
    _scrollCtrl.animateTo(
      target,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}

/// ----------------------------
/// LIST OF CARS
/// ----------------------------
class _ListCarWidget extends GetView<CarManageController> {
  const _ListCarWidget();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(() {
        if (controller.isLoading.value && controller.cars.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.headerTabSelectedIndex.value == 1) {
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
                itemBuilder: (car) => CarInShowroomItemWidget(
                  carModel: car,
                  onTap: () {
                    Get.toNamed(
                      const CarDetailPage().routeName,
                      arguments: car,
                    );
                  },
                ),
              ),
            ),
          );
        }

        if (controller.headerTabSelectedIndex.value == 2) {
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
                itemBuilder: (car) => CarSoldItemWidget(
                  carModel: car,
                  onTap: () {
                    Get.toNamed(
                      const CarDetailPage().routeName,
                      arguments: car,
                    );
                  },
                ),
              ),
            ),
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
              itemBuilder: (car) => CarItemWidget(
                car: car,
                onTap: () {
                  Get.toNamed(
                    const CarDetailPage().routeName,
                    arguments: car,
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}

/// ----------------------------
/// FILTER BAR WIDGET
/// ----------------------------
class _FilterBarWidget extends StatelessWidget {
  final CarManageController controller;
  const _FilterBarWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    final popupCtrl = controller.headerTabSelectedIndex.value == 0
        ? controller.filterCarPopup
        : controller.headerTabSelectedIndex.value == 1
            ? controller.filterCarInShowRoomPopup
            : controller.filterSoldCarPopup;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomPopupDropdown(
          controller: popupCtrl,
          onSelected: (_) => controller.onFilterChanged(),
        ),
        SortToggleWidget(
          controller: controller.sortController,
          onSort: controller.onSort,
        ),
      ],
    );
  }
}

/// ----------------------------
/// TAB CONTENTS
/// ----------------------------
class _AllCarTabContent extends StatelessWidget {
  final CarManageController controller;
  const _AllCarTabContent({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchWidget(
          onSubmit: (v) {
            controller.searchText.value = v;
            controller.refreshCars();
          },
          height: 40,
        ),
        const SizedBox(height: 12),
        _FilterBarWidget(controller: controller),
      ],
    );
  }
}

class _ShowroomTabContent extends StatelessWidget {
  final CarManageController controller;
  const _ShowroomTabContent({required this.controller});

  Widget _infoRow(String label, String value) {
    return TextSpanWidget(
      text1: "$label: ",
      text2: value,
      textColor2: AppColors.accent,
      fontWeight2: FontWeight.bold,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchWidget(
          onSearch: controller.onSearchShowroomCars,
          onSubmit: (v) {
            controller.searchText.value = v;
            controller.refreshCars();
          },
          height: 40,
        ),
        const SizedBox(height: 12),
        _FilterBarWidget(controller: controller),
        const SizedBox(height: 12),
        _infoRow("Số lượng kho", "${controller.cars.length}"),
        const SizedBox(height: 8),
        _infoRow("Giá trị kho",
            "${controller.inventoryValue.value.toString().toCurrency()} VND"),
      ],
    );
  }
}

class _SoldCarTabContent extends StatelessWidget {
  final CarManageController controller;
  const _SoldCarTabContent({required this.controller});

  Widget _infoRow(String label, String value) {
    return TextSpanWidget(
      text1: "$label: ",
      text2: value,
      textColor2: AppColors.accent,
      fontWeight2: FontWeight.bold,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        _infoRow("Tổng giá trị",
            "${controller.soldValue.value.toString().toCurrency()} VND"),
        const SizedBox(height: 8),
        _infoRow("Tổng lợi nhuận",
            "${controller.profit.value.toString().toCurrency()} VND"),
      ],
    );
  }
}
