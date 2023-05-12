import 'package:get/get.dart';
import 'package:rsud/ui/history/history_screen.dart';
import 'package:rsud/ui/home/home_screen.dart';
import 'package:rsud/ui/splash_screen/splash_screen.dart';

class AppRoute {
  AppRoute._();

  static final List<GetPage<dynamic>> routeList = [
    GetPage(name: AppRoute.init, page: () => const SplashScreen()),
    GetPage(name: AppRoute.home, page: () => const HomeScreen()),
    GetPage(name: AppRoute.history, page: () => const HistoryScreen())
  ];

  static const init = '/';
  static const home = '/home';
  static const history = '/history';

}
