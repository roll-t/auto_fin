import 'package:auto_fin/core/routes/app_routes.dart';
import 'package:auto_fin/features/auth/page/signin_page.dart';
import 'package:auto_fin/features/auth/page/signup_page.dart';
import 'package:auto_fin/features/dashboard/dashboard_page.dart';
import 'package:auto_fin/features/dashboard/di_dashboard/dashboard_binding.dart';
import 'package:auto_fin/features/main/di/main_binding.dart';
import 'package:auto_fin/features/main/presentation/page/main_page.dart';
import 'package:auto_fin/features/notFound/page/not_found_page.dart';
import 'package:auto_fin/features/setting/di/setting_binding.dart';
import 'package:auto_fin/features/setting/presentation/page/setting_page.dart';
import 'package:auto_fin/features/showroom/car_manage/di/all_car_binding.dart';
import 'package:auto_fin/features/showroom/car_manage/di/car_detail_binding.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/page/add_car_page.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/page/all_car_page.dart';
import 'package:auto_fin/features/showroom/car_manage/di/car_in_auto_binding.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/page/car_in_auto_page.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/page/car_detail_page.dart';
import 'package:auto_fin/features/showroom/profit_manage/di/profit_manage_binding.dart';
import 'package:auto_fin/features/showroom/profit_manage/presentation/page/profit_manage_page.dart';
import 'package:auto_fin/features/showroom/car_manage/di/vehicle_binding.dart';
import 'package:auto_fin/features/showroom/car_manage/presentation/page/vehicle_page.dart';
import 'package:auto_fin/features/splash/di/splash_binding.dart';
import 'package:auto_fin/features/splash/presentation/page/splash_page.dart';
import 'package:get/get.dart';

final appPage = [
  GetPage(
    name: AppRoutes.initial,
    page: () => const SplashPage(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: MainPage.routeName,
    page: () => const MainPage(),
    binding: MainBinding(),
    transition: Transition.fade,
    transitionDuration: const Duration(milliseconds: 800),
  ),
  GetPage(
    name: NotFoundPage.routeName,
    page: () => const NotFoundPage(),
  ),
  GetPage(
    name: AppRoutes.dashboard,
    page: () => const DashboardPage(),
    binding: DashboardBinding(),
  ),
  GetPage(
    name: AppRoutes.signin,
    page: () => const SigninPage(),
  ),
  GetPage(
    name: AppRoutes.signup,
    page: () => const SignupPage(),
  ),
  GetPage(
    name: SettingPage.routeName,
    page: () => const SettingPage(),
    binding: SettingBinding(),
  ),
  GetPage(
    name: AllCarPage.routeName,
    page: () => const AllCarPage(),
    binding: AllCarBinding(),
  ),
  GetPage(
    name: CarInAutoPage.routeName,
    page: () => const CarInAutoPage(),
    binding: CarInAutoBinding(),
  ),
  GetPage(
    name: VehiclePage.routeName,
    page: () => const VehiclePage(),
    binding: VehicleBinding(),
  ),
  GetPage(
    name: ProfitManagePage.routeName,
    page: () => const ProfitManagePage(),
    binding: ProfitManageBinding(),
  ),
  GetPage(
    name: CarDetailPage.routeName,
    page: () => const CarDetailPage(),
    binding: CarDetailBinding(),
  ),
  GetPage(
    name: AddCarPage.routeName,
    page: () => const AddCarPage(),
    binding: AllCarBinding(),
  ),
];
