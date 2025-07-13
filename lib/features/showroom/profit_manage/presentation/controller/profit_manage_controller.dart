import 'package:auto_fin/core/data/model/item_model.dart';
import 'package:auto_fin/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:auto_fin/core/ui/widgets/tab_bar/custom_tab_bar_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ProfitManageController extends GetxController {
  ItemModel? yearSelected;
  ItemModel? monthSelected;
  BottomSheetController yearBottomSheetController = BottomSheetController(
    listItem: [
      ItemModel(title: "Năm 2025"),
      ItemModel(title: "Năm 2024"),
      ItemModel(title: "Năm 2023"),
      ItemModel(title: "Năm 2022"),
      ItemModel(title: "Năm 2021"),
      ItemModel(title: "Năm 2020"),
      ItemModel(title: "Năm 2019"),
      ItemModel(title: "Năm 2018"),
    ].obs,
  );

  final BottomSheetController monthBottomSheetController =
      BottomSheetController(
    listItem: List.generate(
      12,
      (index) => ItemModel(title: "Tháng ${index + 1}"),
    ).obs,
  );

  final TabBarController tabBarController = TabBarController(
    tabs: [
      ItemModel(id: UniqueKey().toString(), title: "Theo năm"),
      ItemModel(id: UniqueKey().toString(), title: "Theo xe"),
    ],
  );

  @override
  void onClose() {
    super.onClose();
    yearBottomSheetController.dispose();
    monthBottomSheetController.dispose();
  }
}
