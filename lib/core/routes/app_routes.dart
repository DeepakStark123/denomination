import 'package:denomination/features/home/presentation/view/history_screen.dart';
import 'package:denomination/features/home/presentation/view/home_screen.dart';
import 'package:denomination/core/routes/route_name.dart';
import 'package:denomination/features/splash/presentation/view/splash_screen.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const splash = RouteName.splash;
  static const home = RouteName.home;
  static const history = RouteName.history;

  static List<GetPage> routes = [
    // Splash Route
    GetPage(
      name: splash, 
      page: () => const SplashScreen(),
    ),
    // Home Route
    GetPage(
      name: home, 
      page: () =>  const HomeScreen(),
    ),
    // History Route
    GetPage(
      name: history,
      page: () => const HistoryScreen(),
    ),
  ];
}
