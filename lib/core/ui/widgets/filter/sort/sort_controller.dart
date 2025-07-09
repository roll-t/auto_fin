import 'package:auto_fin/core/config/const/enum.dart';
import 'package:get/get.dart';

class SortController extends GetxController {
  var sortType = SortType.newest.obs;

  void toggleSort() {
    sortType.value =
        sortType.value == SortType.newest ? SortType.oldest : SortType.newest;
  }

  String get label {
    return sortType.value == SortType.newest ? 'Mới nhất' : 'Cũ nhất';
  }

  @override
  void onClose() {
    sortType.close();
    super.onClose();
  }
}
