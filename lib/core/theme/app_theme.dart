import 'package:flutter/material.dart';
import 'package:homefinder/core/theme/app_text_theme.dart';
import 'package:homefinder/core/variables/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.kWhite,
    useMaterial3: true,
    textTheme: appTextTheme,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,

      primary: AppColors.kPrimary,
      onPrimary: AppColors.kWhite,

      secondary: AppColors.kBrand5,
      onSecondary: AppColors.kGrey70,

      error: AppColors.kDestructive50,
      onError: AppColors.kGrey70,

      surface: AppColors.kWhite,
      onSurface: AppColors.kGrey70,
    ),
  );
}
