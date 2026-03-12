import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/colors.dart';
import 'package:homefinder/features/home/presentation/widgets/bathroom.dart';
import 'package:homefinder/features/home/presentation/widgets/bedroom.dart';
import 'package:homefinder/features/home/presentation/widgets/property_type.dart';

mixin FilterBottomSheet {
  Future<void> showFilterBottomSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Container(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height * 0.7,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppBar(
                  backgroundColor: AppColors.kPrimary,
                  elevation: 0,
                  title: AppText(
                    'Filter',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w500,
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

                const PropertyType(),

                16.verticalSpacing,

                const BedRoom(),

                16.verticalSpacing,

                const BathRoom(),
              ],
            ),
          ),
        );
      },
    );
  }
}
