import 'package:auto_find/core/config/const/app_icons.dart';
import 'package:auto_find/main/navigation/model/item_menu_feature_model.dart';
import 'package:auto_find/main/showroom/features/add_car/presentation/page/add_car_page.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/page/car_manage_page.dart';
import 'package:auto_find/main/showroom/features/profit_manage/presentation/page/profit_manage_page.dart';
import 'package:get/get.dart';

class TabManageController extends GetxController {
  final List<ItemMenuFeatureModel> listShowroomFeature = [
    ItemMenuFeatureModel(
      title: "Quản lý lợi nhuận",
      iconUrl: AppIcons.icProfit,
      routeNameUrl: const ProfitManagePage().routeName,
    ),
    ItemMenuFeatureModel(
      title: "Thêm xe mới",
      iconUrl: AppIcons.icAddCar,
      routeNameUrl: const AddCarPage().routeName,
    ),
    ItemMenuFeatureModel(
      title: "Quản lý xe",
      iconUrl: AppIcons.icAllCar,
      routeNameUrl: const CarManagePage().routeName,
    ),
  ];

  final List<ItemMenuFeatureModel> listEmployeeFeature = [
    ItemMenuFeatureModel(
      title: "Theo dõi lương",
      iconUrl: AppIcons.icSalary,
    ),
    ItemMenuFeatureModel(
      title: "Hoa hồng",
      iconUrl: AppIcons.icRose,
    ),
    ItemMenuFeatureModel(
      title: "Chấm công",
      iconUrl: AppIcons.icAttendance,
    ),
  ];

  final List<ItemMenuFeatureModel> listDiamondFeature = [
    ItemMenuFeatureModel(
      title: "Nhập - Xuất\n Vàng",
      iconUrl: AppIcons.icExportGold,
    ),
    ItemMenuFeatureModel(
      title: "Vàng tồn kho",
      iconUrl: AppIcons.icGoldInventory,
    ),
    ItemMenuFeatureModel(
      title: "Giao dịch bán lẻ",
      iconUrl: AppIcons.icRetail,
    ),
    ItemMenuFeatureModel(
      title: "Dòng tiền theo ngày",
      iconUrl: AppIcons.icFlowMoney,
    ),
  ];

  final List<ItemMenuFeatureModel> listMoneyFeature = [
    ItemMenuFeatureModel(
      title: "Thống kê thu chi từng mảng",
      iconUrl: AppIcons.icIncomeExpenseByCategory,
    ),
    ItemMenuFeatureModel(
      title: "Báo cáo theo\nTuần - Tháng",
      iconUrl: AppIcons.icReportWeeklyMonthly,
    ),
  ];

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
