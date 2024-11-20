import 'package:denomination/config/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    useMaterial3: false,
    primaryColor: AppColors.primarymaincolor,
    fontFamily: 'CircularStd',
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primarymaincolor,
      foregroundColor: AppColors.whiteColor,
    ),
    scaffoldBackgroundColor: AppColors.whiteColor,
    // Circular Progress Indicator Theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primarymaincolor,
    ),
    datePickerTheme: const DatePickerThemeData(
      headerBackgroundColor: AppColors.primarymaincolor,
      headerForegroundColor: AppColors.whiteColor,
      backgroundColor: AppColors.whiteColor,
    ),
    // Input Decoration Theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.whiteColor,
      hintStyle: const TextStyle(
        color: Color(0xffA7A7A7),
        fontWeight: FontWeight.w400,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.greyColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.greyColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: AppColors.primarymaincolor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primarymaincolor,
        elevation: 0,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
    ),
    floatingActionButtonTheme:const FloatingActionButtonThemeData(backgroundColor: AppColors.primarymaincolor)
  );
}
