import 'package:auto_find/core/extension/empty_extension.dart';
import 'package:auto_find/core/model/ui/item_model.dart';
import 'package:auto_find/core/ui/widgets/bottom_sheet/bottom_sheet_controller.dart';
import 'package:auto_find/main/showroom/data/model/car_chart_model.dart';
import 'package:auto_find/main/showroom/data/usecase/car_usecase.dart';
import 'package:get/get.dart';

class StatisticVehicleController extends GetxController {
  StatisticVehicleController(this._carUsecase);

  final CarUsecase _carUsecase;

  CarChartsModel? charts;

  final BottomSheetController yearBottomSheetController = BottomSheetController(
    listItem: _yearItems().obs,
    itemSelected: _yearItems()[0],
  );

  ItemModel? yearSelected;

  @override
  void onReady() async {
    super.onReady();
    initialData();
  }

  void initialData() {
    final firstYear = int.parse(_yearItems()[0].id.orEmpty());
    yearSelected = _yearItems()[0];
    fetchChart(year: firstYear);
  }

  Future<void> fetchChart({required int year}) async {
    charts = await _carUsecase.getCharts(year);
    update(["CHART_ID"]);
  }

  void onYearSelected(ItemModel item) {
    yearSelected = item;
    final year = int.tryParse(item.id.orEmpty());
    if (year != null) {
      fetchChart(year: year);
    }
  }

  // Static Helpers
  // ===============================
  static List<ItemModel> _yearItems() {
    final currentYear = DateTime.now().year;
    return [
      for (int y = currentYear; y >= 2018; y--)
        ItemModel(id: "$y", title: "Năm $y"),
    ];
  }
}
