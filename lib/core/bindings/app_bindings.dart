import 'package:denomination/database/database_service.dart';
import 'package:denomination/features/home/presentation/controller/history_controller.dart';
import 'package:denomination/features/splash/presentation/controller/splash_controller.dart';
import '../../features/home/presentation/controller/edit_controller.dart';
import '../../features/home/presentation/controller/home_controller.dart';
import 'package:denomination/features/splash/service/splash_service.dart';
import 'package:denomination/features/home/services/home_service.dart';
import 'package:get/get.dart';

class Dependencies extends Bindings {
  @override
  void dependencies() {
    //---Register-Services-----
    Get.lazyPut<HomeService>(() => HomeService());
    Get.lazyPut<SplashService>(() => SplashService());
    Get.lazyPut<DatabaseService>(() => DatabaseService());
    //---Register-Controllers-----
    Get.lazyPut<SplashController>(
        () => SplashController(splashService: Get.find<SplashService>()));
    Get.lazyPut<HomeController>(() => HomeController(
        homeService: Get.find<HomeService>(),
        databaseService: Get.find<DatabaseService>()));
    Get.lazyPut<HistoryController>(
      () => HistoryController(
          homeService: Get.find<HomeService>(),
          databaseService: Get.find<DatabaseService>()),
      fenix: true,
    );
    Get.lazyPut<EditController>(() => EditController(Get.arguments));
  }
}
