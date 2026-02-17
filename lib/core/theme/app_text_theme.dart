import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:homefinder/core/variables/colors.dart';

TextTheme appTextTheme = GoogleFonts.dmSansTextTheme(
  const TextTheme(
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      color: AppColors.kWhite,
    ),

    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.kWhite,
    ),

    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
    ),
  ),
);
