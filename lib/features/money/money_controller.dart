import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/features/main/model/item_menu_feature_model.dart';
import 'package:get/get.dart';

class MoneyController extends GetxController {
  final List<ItemMenuFeatureModel> listMoneyFeature = [
    ItemMenuFeatureModel(
      title: "Thong kê thu chi từng mảng",
      iconUrl: AppIcons.icIncomeExpenseByCategory,
    ),
    ItemMenuFeatureModel(
      title: "Báo cáo theo\nTuần - Tháng",
      iconUrl: AppIcons.icReportWeeklyMonthly,
    ),
  ];
}
   