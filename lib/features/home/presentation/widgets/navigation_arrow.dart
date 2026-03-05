import 'package:flutter/material.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/colors.dart';

class NavigationArrow extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const NavigationArrow({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppIconContainerSize.medium,
      height: AppIconContainerSize.medium,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            AppColors.kWhite,
            AppColors.kGrey10.withValues(alpha: 0.5),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: AppColors.kGrey40,
          size: 20,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
