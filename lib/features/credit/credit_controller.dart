import 'package:auto_fin/core/config/const/app_icons.dart';
import 'package:auto_fin/features/main/model/item_menu_feature_model.dart';
import 'package:get/get.dart';

class CreditController extends GetxController{

    final List<ItemMenuFeatureModel> listCreditFeature = [
    ItemMenuFeatureModel(
      title: "20\n Khoản vay",
      iconUrl: AppIcons.ic20Loan,
    ),
    ItemMenuFeatureModel(
      title: "Gốc - Lãi\nHàng tháng",
      iconUrl: AppIcons.icMonthlyPrincipalInterest,
    ),
    ItemMenuFeatureModel(
      title: "Báo cáo tổng nợ",
      iconUrl: AppIcons.icReportDebt,
    ),
  ];
}