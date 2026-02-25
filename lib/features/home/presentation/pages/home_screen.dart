import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_card.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';
import 'package:homefinder/features/home/presentation/bloc/homes_bloc.dart';

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
              // allow the location column to shrink if needed
              Expanded(
                child: Column(
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
                        Expanded(
                          child: AppText(
                            'Lagos, Nigeria',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
          24.verticalSpacing,
          Expanded(
            child: BlocBuilder<HomesBloc, HomesState>(
              builder: (context, state) {
                if (state is HomesLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is HomesError) {
                  return Center(
                    child: AppText(
                      state.message,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  );
                }
                if (state is HomesLoaded) {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText(
                              'Homes Near You',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: AppColors.kGray50,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),

                            GestureDetector(
                              child: AppText(
                                'See all',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: AppColors.kPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          ],
                        ),

                        8.verticalSpacing,

                        //   homes list
                        SizedBox(
                          height: 350,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final home = state.homes[index];
                              return SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.8,
                                child: AppCard(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              AppRadius.medium,
                                            ),
                                            child: Image.asset(
                                              home.image,
                                              fit: BoxFit.cover,
                                              height: 200,
                                              width: double.infinity,
                                            ),
                                          ),
                                          Positioned.fill(
                                            child: Padding(
                                              padding: const EdgeInsets.all(12),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  //   rating
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors.kWhite,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            AppRadius
                                                                .fullRadius,
                                                          ),
                                                    ),
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 8,
                                                          vertical: 4,
                                                        ),
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                          FontAwesomeIcons
                                                              .solidStar,
                                                          color: AppColors
                                                              .kWarning50,
                                                          size:
                                                              AppIconSize.small,
                                                        ),
                                                        4.horizontalSpacing,
                                                        AppText(
                                                          home.rating
                                                              .toString(),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodySmall
                                                              ?.copyWith(
                                                                color: AppColors
                                                                    .kGrey80,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),

                                                  //   heart icon
                                                  IconConButton(
                                                    shape: BoxShape.circle,
                                                    borderColor:
                                                        AppColors.kTransparent,
                                                    bgColor: AppColors.kWhite,
                                                    child: const Icon(
                                                      FontAwesomeIcons.heart,
                                                      // home.isFavorite
                                                      //     ? FontAwesomeIcons.solidHeart
                                                      //     : FontAwesomeIcons.heart,
                                                      color: AppColors.kPrimary,
                                                    ),
                                                    pressed: () {},
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      16.verticalSpacing,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // name: allow shrinking with ellipsis
                                              Expanded(
                                                child: AppText(
                                                  home.name,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall
                                                      ?.copyWith(
                                                        color:
                                                            AppColors.kGrey80,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),

                                              // price
                                              AppRichText(
                                                spans: [
                                                  TextSpan(
                                                    text:
                                                        '#${home.price_per_month}M',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall
                                                        ?.copyWith(
                                                          color: AppColors
                                                              .kPrimary,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 20,
                                                        ),
                                                  ),
                                                  TextSpan(
                                                    text: '/year',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                          color:
                                                              AppColors.kGrey40,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          16.verticalSpacing,

                                          // location
                                          Row(
                                            children: [
                                              const Icon(
                                                FontAwesomeIcons.locationDot,
                                                color: AppColors.kGrey30,
                                                size: AppIconSize.small,
                                              ),
                                              8.horizontalSpacing,
                                              Expanded(
                                                child: AppText(
                                                  home.location,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color:
                                                            AppColors.kGrey30,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),

                                          16.verticalSpacing,

                                          Row(
                                            children: [
                                              // bedrooms
                                              IntrinsicHeight(
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      FontAwesomeIcons.bed,
                                                      size: AppIconSize.regular,
                                                      color: AppColors.kGrey30,
                                                    ),
                                                    8.horizontalSpacing,
                                                    AppText(
                                                      '${home.beds} Bedrooms',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .kGrey30,
                                                          ),
                                                    ),

                                                    const VerticalDivider(
                                                      thickness: 1,
                                                      color: AppColors.kGrey30,

                                                      width: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              // bathrooms
                                              IntrinsicHeight(
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      FontAwesomeIcons.bath,
                                                      size: AppIconSize.regular,
                                                      color: AppColors.kGrey30,
                                                    ),
                                                    8.horizontalSpacing,
                                                    AppText(
                                                      '${home.baths} Baths',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .kGrey30,
                                                          ),
                                                    ),

                                                    const VerticalDivider(
                                                      thickness: 1,
                                                      color: AppColors.kGrey30,

                                                      width: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              // square footage
                                              IntrinsicHeight(
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                      FontAwesomeIcons.ruler,
                                                      size: AppIconSize.regular,
                                                      color: AppColors.kGrey30,
                                                    ),
                                                    8.horizontalSpacing,
                                                    AppText(
                                                      '${home.sqft} sqft',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppColors
                                                                .kGrey30,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (_, _) => 24.horizontalSpacing,
                            itemCount: state.homes.length > 3 ? 3 : state.homes.length,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return Center(
                  child: AppText(
                    'No Data',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
