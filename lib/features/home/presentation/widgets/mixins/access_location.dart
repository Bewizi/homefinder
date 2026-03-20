import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/colors.dart';

mixin AccessLocation {
  Future<void> showAccessLocationBottomSheet(BuildContext context) async {
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
          height: MediaQuery.sizeOf(context).height * 0.45,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
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

              AppText(
                'Access Location',
                style: context.textTheme.headlineSmall?.copyWith(
                  color: AppColors.kGray40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              16.verticalSpacing,
              AppText(
                'Enable location access to find homes near you faster and more accurately',
                style: context.textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              32.verticalSpacing,
              PrimaryButton(
                'Allow location access',
                pressed: () {},
              ),
              16.verticalSpacing,
              OutlineButton(
                'Enter location manually',
                pressed: () {},
                bgColor: AppColors.kTransparent,
                borderColor: AppColors.kGrey30,
                textColor: AppColors.kGrey30,
              ),
            ],
          ),
        );
      },
    );
  }
}
