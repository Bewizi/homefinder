import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          //   location and notification
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    'Location',
                    style: Theme.of(
                      context,
                    ).textTheme.bodySmall?.copyWith(color: AppColors.kGray30),
                  ),
                  8.verticalSpacing,
                  Row(
                    children: [
                      //   location icon and address
                      const Icon(
                        FontAwesomeIcons.locationDot,
                        color: AppColors.kPrimary,
                        size: AppIconSize.medium,
                      ),
                      4.horizontalSpacing,
                    ],
                  ),
                ],
              ),

              Container(
                width: AppIconContainerSize.medium,
                height: AppIconContainerSize.medium,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.kGrey5),
                  borderRadius: BorderRadius.circular(AppRadius.medium),
                ),
                child: IconButton(
                  icon: const Badge(
                    child: Icon(
                      FontAwesomeIcons.solidBell,
                      color: AppColors.kGrey80,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
