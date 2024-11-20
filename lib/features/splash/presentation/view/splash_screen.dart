import 'package:denomination/config/app_images.dart';
import 'package:denomination/features/splash/presentation/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashController = Get.find<SplashController>();
    splashController.onAppStart();
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppImages.appIcon,
          height: 200,
          width: 200,
        ),
      ),
    );
  }
}
