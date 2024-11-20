import 'package:denomination/core/routes/app_routes.dart';
import 'package:denomination/features/splash/service/splash_service.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final SplashService splashService;
  SplashController({required this.splashService});

  onAppStart() {
    Future.delayed(const Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.home);
    });
  }
}
