import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/colors.dart';
import 'package:homefinder/features/home/presentation/widgets/amenities.dart';
import 'package:homefinder/features/home/presentation/widgets/bathroom.dart';
import 'package:homefinder/features/home/presentation/widgets/bedroom.dart';
import 'package:homefinder/features/home/presentation/widgets/price_range.dart';
import 'package:homefinder/features/home/presentation/widgets/property_type.dart';

mixin FilterBottomSheet {
  Future<void> showFilterBottomSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height * 0.55,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: AppText(
                  'Filter',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.kGrey30,
                  ),
                ),
                centerTitle: true,
                automaticallyImplyLeading: false,
                forceMaterialTransparency: true,
                actions: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.kGrey80,
                    ),
                    iconSize: AppIconSize.regular,
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const PriceRange(),
                      16.verticalSpacing,
                      const PropertyType(),
                      16.verticalSpacing,
                      const BedRoom(),
                      16.verticalSpacing,
                      const BathRoom(),
                      16.verticalSpacing,
                      const Amenities(),
                      24.verticalSpacing,
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlineButton(
                        'Clear Filters',
                        textColor: AppColors.kGrey30,
                        borderColor: AppColors.kGrey5,
                        bgColor: Colors.white,
                        borderRadius: 12,
                        pressed: () {
                          // TODO: Implement clear filters
                        },
                      ),
                    ),
                    16.horizontalSpacing,
                    Expanded(
                      child: PrimaryButton(
                        'Show Results',
                        color: AppColors.kPrimary,
                        textColor: Colors.white,
                        pressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
