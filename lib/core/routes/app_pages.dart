import 'package:auto_fin/core/routes/app_routes.dart';
import 'package:auto_fin/features/auth/page/signin_page.dart';
import 'package:auto_fin/features/auth/page/signup_page.dart';
import 'package:auto_fin/features/category/presentation/page/category_page.dart';
import 'package:auto_fin/features/dashboard/di/dashboard_binding.dart';
import 'package:auto_fin/features/dashboard/presentation/page/dashboard_page.dart';
import 'package:auto_fin/features/main/di/main_binding.dart';
import 'package:auto_fin/features/main/presentation/page/main_page.dart';
import 'package:auto_fin/features/notFound/page/not_found_page.dart';
import 'package:auto_fin/features/setting/di/setting_binding.dart';
import 'package:auto_fin/features/setting/presentation/page/setting_page.dart';
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
  GetPage(name: NotFoundPage.routeName, page: () => const NotFoundPage()),
  GetPage(
    name: AppRoutes.dashboard,
    page: () => const DashboardPage(),
    binding: DashboardBinding(),
  ),
  GetPage(name: AppRoutes.signin, page: () => const SigninPage()),
  GetPage(name: AppRoutes.signup, page: () => const SignupPage()),
  GetPage(
    name: SettingPage.routeName,
    page: () => const SettingPage(),
    binding: SettingBinding(),
  ),
  GetPage(name: CategoryPage.routeName, page: () => const CategoryPage()),
];
