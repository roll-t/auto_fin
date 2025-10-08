import 'package:auto_find/core/config/const/app_icons.dart';
import 'package:auto_find/main/nav/model/item_menu_feature_model.dart';
import 'package:auto_find/main/pawn_shop/features/capital_manage/presentation/page/capital_manage_page.dart';
import 'package:auto_find/main/pawn_shop/features/income_expenditure_manage/presentation/page/add_income_expenditure_page.dart';
import 'package:auto_find/main/pawn_shop/features/statistic_pawnshop/presentation/page/statistic_pawnshop_page.dart';
import 'package:auto_find/main/showroom/features/add_car/presentation/page/add_car_page.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/page/car_manage_page.dart';
import 'package:auto_find/main/showroom/features/profit_manage/presentation/page/profit_manage_page.dart';
import 'package:auto_find/main/showroom/features/statistic/presentation/page/statistic_vehicle_page.dart';
import 'package:get/get.dart';

class ManageController extends GetxController {
  final List<ItemMenuFeatureModel> listShowroomFeature = [
    ItemMenuFeatureModel(
      title: "Thống kê\nshowroom",
      iconUrl: AppIcons.icStatisticsVehicle,
      routeNameUrl: const StatisticVehiclePage().routeName,
    ),
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
      title: "Thống kê chung",
      routeNameUrl: const StatisticPawnshopPagePage().routeName,
      iconUrl: AppIcons.ic20Loan,
    ),
    ItemMenuFeatureModel(
      title: "Quản lý nguồn vốn",
      routeNameUrl: const CapitalManagePage().routeName,
      iconUrl: AppIcons.icMonthlyPrincipalInterest,
    ),
    ItemMenuFeatureModel(
      title: "Quản lý thu chi",
      routeNameUrl: const AddIncomeExpenditurePage().routeName,
      iconUrl: AppIcons.icReportDebt,
    ),
    ItemMenuFeatureModel(
      title: "Quản lý cửa hàng",
      iconUrl: AppIcons.icReportDebt,
    ),
    ItemMenuFeatureModel(
      title: "Quản lý khách hàng",
      iconUrl: AppIcons.icReportDebt,
    ),
    ItemMenuFeatureModel(
      title: "Cầm đồ",
      iconUrl: AppIcons.icReportDebt,
    ),
    ItemMenuFeatureModel(
      title: "Tín chấp",
      iconUrl: AppIcons.icReportDebt,
    ),
  ];
}
