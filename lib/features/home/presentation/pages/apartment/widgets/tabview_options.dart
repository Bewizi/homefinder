import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';

class TabviewOptions extends StatelessWidget {
  final VoidCallback? onPicturesTap;
  final VoidCallback? onVideosTap;
  final VoidCallback? onLocationTap;

  const TabviewOptions({
    super.key,
    this.onPicturesTap,
    this.onVideosTap,
    this.onLocationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.kBrand5,
        borderRadius: BorderRadius.circular(AppRadius.fullRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.kBlack.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption(
            context,
            'Pictures',
            isSelected: true,
            onTap: onPicturesTap,
          ),
          _buildOption(context, 'Videos', onTap: onVideosTap),
          _buildOption(context, 'Location Map', onTap: onLocationTap),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context,
    String label, {
    bool isSelected = false,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.kWhite : AppColors.kTransparent,
          borderRadius: BorderRadius.circular(AppRadius.fullRadius),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.kBlack.withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: AppText(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: isSelected ? AppColors.kBlack : AppColors.kGrey40,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
