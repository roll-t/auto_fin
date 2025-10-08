import 'package:auto_find/core/model/ui/item_model.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddIncomeExpenditureController extends GetxController {
  ///============================== [VARIABLES] ==============================

  final RxBool isLoading = false.obs;
  final RxString message = ''.obs;
  final headerTabSelectedIndex = 0.obs;
  final ScrollController scrollCtrl = ScrollController();

  final BottomSheetController filterCapital = BottomSheetController(
    listItem: [
      ItemModel(id: "all", title: "Thu khác"),
      ItemModel(id: "million", title: "Triệu"),
      ItemModel(id: "billion", title: "Tỷ"),
    ].obs,
    itemSelected: ItemModel(id: "all", title: "Thu khác"),
  );

  final headerTabItem = [
    ItemModel(id: 'all', title: 'Phiếu chi tiền'),
    ItemModel(id: 'in_stock', title: 'Phiếu thu tiền'),
  ];

  ///============================== [LIFECYCLE] ==============================
  @override
  void onInit() {
    super.onInit();
    // TODO: implement onInit
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
