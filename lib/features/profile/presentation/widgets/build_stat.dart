import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';

Widget buildStat(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    decoration: BoxDecoration(
      color: AppColors.kSuccess5,
      border: Border.all(color: AppColors.kSuccess10, width: 2),
      borderRadius: BorderRadius.circular(AppRadius.fullRadius),
    ),
    child: AppText(
      'HomeFinder',
      style: context.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.kSuccess50,
      ),
    ),
  );
}
