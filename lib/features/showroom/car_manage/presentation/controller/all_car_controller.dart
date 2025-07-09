import 'package:auto_fin/core/data/model/popup_dropdown_model.dart';
import 'package:auto_fin/core/ui/widgets/filter/popup_dropdown/popup_dropdown_controller.dart';
import 'package:auto_fin/core/ui/widgets/filter/sort/sort_controller.dart';
import 'package:get/get.dart';

class AllCarController extends GetxController {
  final PopupDropdownController filterCarPopup = PopupDropdownController(
    listItem: [
      const PopupDropdownModel(id: 'all', label: 'Tất cả'),
      const PopupDropdownModel(id: 'new_car', label: 'Xe mới'),
      const PopupDropdownModel(id: 'used_car', label: 'Xe cũ'),
    ].obs,
  );

  final SortController sortController = SortController();

  @override
  void onClose() {
    filterCarPopup.dispose();
    super.onClose();
  }
}
