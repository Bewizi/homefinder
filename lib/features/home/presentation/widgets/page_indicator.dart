import 'package:flutter/material.dart';
import 'package:homefinder/core/variables/colors.dart';

class PageIndicator extends StatelessWidget {
  final bool isActive;

  const PageIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.kPrimary : AppColors.kWhite,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
