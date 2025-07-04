import 'package:auto_fin/app_binding.dart';
import 'package:auto_fin/core/config/theme/app_color_scheme.dart';
import 'package:auto_fin/core/config/theme/app_theme.dart';
import 'package:auto_fin/core/lang/translation_service.dart';
import 'package:auto_fin/core/routes/app_pages.dart';
import 'package:auto_fin/core/routes/app_routes.dart';
import 'package:auto_fin/features/notFound/page/not_found_page.dart';
import 'package:auto_fin/features/splash/presentation/page/splash_page.dart';
import 'package:auto_fin/features/theme/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        Rx<AppColorScheme> colorScheme = themeController.appColorScheme;
        return Obx(() {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            translations: LocalizationService(),
            locale: LocalizationService.locale,
            fallbackLocale: LocalizationService.fallbackLocale,
            supportedLocales: const [
              Locale('vi', 'VN'),
              Locale('en', 'US'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            getPages: appPage,
            initialRoute: AppRoutes.initial,
            initialBinding: AppBinding(),
            home: const SplashPage(),
            unknownRoute: GetPage(
              name: NotFoundPage.routeName,
              page: () => const NotFoundPage(),
            ),
            theme: AppTheme.light(colorScheme.value),
            darkTheme: AppTheme.dark(colorScheme.value),
            themeMode: themeController.themeMode.value,
          );
        });
      },
    );
  }
}
