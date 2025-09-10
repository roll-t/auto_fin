import 'package:auto_find/core/model/ui/popup_dropdown_model.dart';
import 'package:auto_find/core/ui/widgets/filter/popup_dropdown/popup_dropdown_controller.dart';
import 'package:auto_find/core/ui/widgets/filter/sort/sort_controller.dart';
import 'package:auto_find/main/showroom/data/model/car_model.dart';
import 'package:auto_find/main/showroom/data/usecase/car_usecase.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCarController extends GetxController {
  final CarUsecase _carUsecase;
  AllCarController(this._carUsecase);

  // State
  final cars = <CarModel>[].obs;
  final isLoading = false.obs;
  final isLoadMore = false.obs;        
  final isRefreshing = false.obs;
  final errorMessage = ''.obs;
  final selectedIndex = 0.obs;

  String? _nextPageToken;

  final scrollController = ScrollController();
  final sortController = SortController();
  final filterCarPopup = PopupDropdownController(
    listItem: const [
      PopupDropdownModel(id: 'all', label: 'Tất cả'),
      PopupDropdownModel(id: 'new_car', label: 'Xe mới'),
      PopupDropdownModel(id: 'used_car', label: 'Xe cũ'),
    ].obs,
  );

  final items = const ["Tất cả xe", "Xe đã bán", "Xe ở Auto"];

  @override
  void onReady() {
    super.onReady();
    fetchCars();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 100 &&
        !isLoadMore.value &&
        _nextPageToken != null) {
      fetchCars(loadMore: true);
    }
  }

  Future<void> fetchCars({bool loadMore = false}) async {
    if (loadMore) {
      if (isLoadMore.value) return;
      isLoadMore.value = true;
    } else {
      if (isLoading.value) return;
      isLoading.value = true;
    }

    try {
      final result = await _carUsecase.getCars(
        pageSize: 20,
        startAfter: loadMore ? _nextPageToken : null,
      );

      if (loadMore) {
        cars.addAll(result.items);
      } else {
        cars.assignAll(result.items);
      }

      _nextPageToken = result.nextPageToken;
    } catch (e, stack) {
      errorMessage.value = e.toString();
      debugPrint('❌ fetchCars lỗi: $e\n$stack');
    } finally {
      if (loadMore) {
        isLoadMore.value = false;
      } else {
        isLoading.value = false;
        isRefreshing.value = false;
      }
    }
  }

  Future<void> refreshCars() async {
    isRefreshing.value = true;
    _nextPageToken = null;
    await fetchCars(loadMore: false);
  }

  void setSelected(int index) => selectedIndex.value = index;

  @override
  void onClose() {
    scrollController.dispose();
    filterCarPopup.dispose();
    super.onClose();
  }
}
