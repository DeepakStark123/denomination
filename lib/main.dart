import 'package:denomination/core/bindings/app_bindings.dart';
import 'package:denomination/core/routes/app_routes.dart';
import 'package:denomination/config/app_constants.dart';
import 'package:denomination/config/theme.dart';
import 'package:denomination/database/database_service.dart';
import 'package:get/route_manager.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseService().database; // Initialize Db 
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appName,
      theme: AppTheme.lightTheme,
      initialBinding: Dependencies(),
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.routes,
    );
  }
}
