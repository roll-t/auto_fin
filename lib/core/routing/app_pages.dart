import 'package:auto_find/main/nav/di/navigation_binding.dart';
import 'package:auto_find/main/nav/presentation/page/navigation_page.dart';
import 'package:auto_find/core/ui/widgets/notFound/not_found_page.dart';
import 'package:auto_find/main/showroom/di/showroom_binding.dart';
import 'package:auto_find/main/showroom/features/add_car/di/add_car_binding.dart';
import 'package:auto_find/main/showroom/features/add_car/presentation/page/add_car_page.dart';
import 'package:auto_find/main/showroom/features/car_manage/di/all_car_binding.dart';
import 'package:auto_find/main/showroom/features/car_manage/di/car_detail_binding.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/page/car_manage_page.dart';
import 'package:auto_find/main/showroom/features/car_manage/presentation/page/car_detail_page.dart';
import 'package:auto_find/main/showroom/features/profit_manage/di/profit_manage_binding.dart';
import 'package:auto_find/main/showroom/features/profit_manage/presentation/page/profit_manage_page.dart';
import 'package:auto_find/main/showroom/features/statistic/di/statistic_vehicle_binding.dart';
import 'package:auto_find/main/showroom/features/statistic/presentation/page/statistic_vehicle_page.dart';
import 'package:auto_find/main/splash/di/splash_binding.dart';
import 'package:auto_find/main/splash/presentation/page/splash_page.dart';
import 'package:auto_find/main/user/features/auth/login/di/login_binding.dart';
import 'package:auto_find/main/user/features/auth/login/presentation/page/login_page.dart';
import 'package:auto_find/main/user/features/auth/signin/di/signin_binding.dart';
import 'package:auto_find/main/user/features/auth/signin/presentation/page/signin_page.dart';
import 'package:get/get.dart';

final notFoundPage = GetPage(
  name: NotFoundPage.routeName,
  page: () => const NotFoundPage(),
);

final appPage = [
  GetPage(
    name: "/splash",
    page: () => const SplashPage(),
    binding: SplashBinding(),
  ),
  GetPage(
    name: const NavigationPage().routeName,
    page: () => const NavigationPage(),
    binding: NavigationBinding(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 400),
  ),
  GetPage(
    name: const LoginPage().routeName,
    page: () => const LoginPage(),
    binding: LoginBinding(),
  ),
  GetPage(
    name: const SigninPage().routeName,
    page: () => const SigninPage(),
    binding: SigninBinding(),
  ),
  GetPage(
    name: NotFoundPage.routeName,
    page: () => const NotFoundPage(),
  ),
  GetPage(
    name: const ProfitManagePage().routeName,
    page: () => const ProfitManagePage(),
    bindings: [
      ShowroomBinding(),
      ProfitManageBinding(),
    ],
  ),
  GetPage(
      name: const AddCarPage().routeName,
      page: () => const AddCarPage(),
      bindings: [
        ShowroomBinding(),
        AddCarBinding(),
      ]),
  GetPage(
      name: const CarManagePage().routeName,
      page: () => const CarManagePage(),
      bindings: [
        ShowroomBinding(),
        AllCarBinding(),
      ]),
  GetPage(
    name: const CarDetailPage().routeName,
    page: () => const CarDetailPage(),
    binding: CarDetailBinding(),
  ),
  GetPage(
    name: const StatisticVehiclePage().routeName,
    page: () => const StatisticVehiclePage(),
    bindings: [
      StatisticVehicleBinding(),
      ShowroomBinding(),
    ],
  ),
];
