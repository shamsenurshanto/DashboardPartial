import 'package:get/get.dart';
import 'package:nirupon_pos/app/screens/bin_info.dart';
import 'package:nirupon_pos/app/screens/dashboard.dart';
import 'package:nirupon_pos/app/screens/login.dart';
import 'package:nirupon_pos/app/screens/outlet_info.dart';
import 'package:nirupon_pos/app/screens/registration.dart';
import 'package:nirupon_pos/app/screens/splash_screen.dart';

import '../bindings/dashboard_binding.dart';
import '../screens/business_info.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.DASHBOARD;
  static final routes = [
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreen(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => RegistrationView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.BIN_INFO,
      page: () => BinInfoView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.BUSINESS_INFO,
      page: () => BusinessInfoView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.OUTLET_INFO,
      page: () => OutletInfoView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () =>  DashboardView(),
      binding: DashboardBinding(),
    ),
  ];
}
