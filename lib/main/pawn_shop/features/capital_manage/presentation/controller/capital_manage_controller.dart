import 'package:auto_find/core/model/ui/item_model.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:get/get.dart';

class CapitalManageController extends GetxController {
  final BottomSheetController filterCapital = BottomSheetController(
    listItem: [
      ItemModel(id: "all", title: "Tất cả"),
      ItemModel(id: "million", title: "Triệu"),
      ItemModel(id: "billion", title: "Tỷ"),
    ].obs,
    itemSelected: ItemModel(id: "all", title: "Tất cả"),
  );
}
