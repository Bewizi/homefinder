import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_card.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/app_images.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;

  List<String> homeFilter = const [
    'All',
    'Apartment',
    'Bungalow',
    'Duplex',
    'Villa',
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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

              const IconConButton(
                borderRadius: AppRadius.medium,
                bgColor: AppColors.kWhite,
                borderColor: AppColors.kGrey5,
                child: Badge(
                  child: Icon(
                    FontAwesomeIcons.solidBell,
                    color: AppColors.kGrey80,
                  ),
                ),
              ),
            ],
          ),
          24.verticalSpacing,
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.06,

            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final item = homeFilter[index];
                final isActive = activeIndex == index;
                return OutlineButton(
                  item,

                  borderColor: isActive
                      ? AppColors.kTransparent
                      : AppColors.kGrey5,
                  bgColor: isActive ? AppColors.kPrimary : AppColors.kWhite,
                  textColor: isActive ? AppColors.kWhite : AppColors.kGrey30,
                  borderRadius: AppRadius.medium,
                  pressed: () {
                    setState(() {
                      activeIndex = index;
                    });
                  },
                );
              },
              separatorBuilder: (_, _) => 8.horizontalSpacing,
              itemCount: homeFilter.length,
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(AppRadius.medium),
                          child: Image.asset(
                            AppImages.kStarlightResidence,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //   rating
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.kWhite,
                                    borderRadius: BorderRadius.circular(
                                      AppRadius.fullRadius,
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(
                                    4,
                                  ),

                                  child: Row(
                                    children: [
                                      const Icon(
                                        FontAwesomeIcons.solidStar,
                                        color: AppColors.kWarning50,
                                        size: AppIconSize.small,
                                      ),
                                      4.horizontalSpacing,
                                      AppText(
                                        '4.95',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: AppColors.kGrey80,
                                              fontWeight: FontWeight.w700,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),

                                //   heart icon
                                const IconConButton(
                                  shape: BoxShape.circle,
                                  borderColor: AppColors.kTransparent,
                                  child: Icon(
                                    FontAwesomeIcons.heart,
                                    color: AppColors.kPrimary,
                                  ),
                                ),
                                // AppText('YouTube'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    16.verticalSpacing,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          'Starlight Residence',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(
                                color: AppColors.kGrey80,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        16.verticalSpacing,
                        Row(
                          children: [
                            const Icon(
                              FontAwesomeIcons.locationDot,
                              color: AppColors.kGrey30,
                              size: AppIconSize.small,
                            ),
                            8.horizontalSpacing,
                            AppText(
                              'Oyin Jolayemi Street, Lagos',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(
                                    color: AppColors.kGrey30,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
