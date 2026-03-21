import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:homefinder/core/data/dummy_data/dummy_homes.dart';
import 'package:homefinder/core/navigation/app_router.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_card.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';
import 'package:homefinder/features/home/presentation/homes_bloc/homes_bloc.dart';
import 'package:homefinder/features/home/presentation/pages/recommended_homes_view.dart';
import 'package:homefinder/features/home/presentation/pages/see_all_homes.dart';
import 'package:homefinder/features/home/presentation/widgets/mixins/access_location.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AccessLocation {
  int activeIndex = 0;
  String _currentAddress = 'Fetching location...';

  @override
  void initState() {
    super.initState();
    displayLocation();
  }

  Future<void> displayLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() => _currentAddress = 'Location services disabled');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() => _currentAddress = 'Permission denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() => _currentAddress = 'Permission permanently denied');
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        setState(() {
          _currentAddress = '${place.locality}, ${place.country}';
        });
      }
    } catch (e) {
      setState(() => _currentAddress = 'Address not found');
    }
  }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
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
                    GestureDetector(
                      onTap: () async {
                        await showAccessLocationBottomSheet(context);
                        displayLocation();
                      },
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.locationDot,
                            color: AppColors.kPrimary,
                            size: AppIconSize.medium,
                          ),
                          4.horizontalSpacing,
                          Expanded(
                            child: AppText(
                              _currentAddress,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: AppColors.kGrey30,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                        ],
                      ),
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<HomesBloc, HomesState>(
                    builder: (context, state) {
                      if (state is HomesError) {
                        return Center(
                          child: AppText(
                            state.message,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        );
                      }

                      final isLoading = state is HomesLoading;
                      final displayHomes = state is HomesLoaded
                          ? state.homes
                          : List.generate(5, (index) => dummyHome);

                      if (state is HomesLoaded && state.homes.isEmpty) {
                        return const Center(child: AppText('No homes found'));
                      }
                      return Column(
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
                                onTap: () =>
                                    context.push(SeeAllHomes.routeName),
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
                          SizedBox(
                            height: 350,
                            child: Skeletonizer(
                              enabled: isLoading,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final home = displayHomes[index];
                                  return SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.8,
                                    child: GestureDetector(
                                      onTap: () {
                                        ApartmentViewRoute(
                                          id: home.id,
                                        ).push(context);
                                      },
                                      child: AppCard(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        AppRadius.medium,
                                                      ),
                                                  child: Image.network(
                                                    home.image,
                                                    fit: BoxFit.cover,
                                                    height: 200,
                                                    width: double.infinity,
                                                  ),
                                                ),
                                                Positioned.fill(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                          12,
                                                        ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            color: AppColors
                                                                .kWhite,
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
                                                                    AppIconSize
                                                                        .small,
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
                                                        IconConButton(
                                                          shape:
                                                              BoxShape.circle,
                                                          borderColor: AppColors
                                                              .kTransparent,
                                                          bgColor:
                                                              AppColors.kWhite,
                                                          child: Icon(
                                                            home.isFavourite
                                                                ? FontAwesomeIcons
                                                                      .solidHeart
                                                                : FontAwesomeIcons
                                                                      .heart,
                                                            color: AppColors
                                                                .kPrimary,
                                                          ),
                                                          pressed: () {
                                                            context
                                                                .read<
                                                                  HomesBloc
                                                                >()
                                                                .add(
                                                                  ToggleFavorite(
                                                                    home.id,
                                                                  ),
                                                                );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            16.verticalSpacing,
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
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
                                                AppRichText(
                                                  spans: [
                                                    TextSpan(
                                                      text:
                                                          '#${home.price_per_month.toStringAsFixed(2)}M',
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
                                                            color: AppColors
                                                                .kGrey40,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ],
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
                                            IntrinsicHeight(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  _buildFeature(
                                                    FontAwesomeIcons.bed,
                                                    '${home.beds} Beds',
                                                    context,
                                                  ),
                                                  const VerticalDivider(
                                                    thickness: 1,
                                                    color: AppColors.kGrey30,
                                                    width: 16,
                                                  ),
                                                  _buildFeature(
                                                    FontAwesomeIcons.bath,
                                                    '${home.baths} Baths',
                                                    context,
                                                  ),
                                                  const VerticalDivider(
                                                    thickness: 1,
                                                    color: AppColors.kGrey30,
                                                    width: 16,
                                                  ),
                                                  _buildFeature(
                                                    FontAwesomeIcons.ruler,
                                                    '${home.sqft} sqft',
                                                    context,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                separatorBuilder: (_, _) =>
                                    24.horizontalSpacing,
                                itemCount: displayHomes.length > 3
                                    ? 3
                                    : displayHomes.length,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  24.verticalSpacing,
                  const RecommendedHomesView(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text, BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: AppIconSize.regular, color: AppColors.kGrey30),
        8.horizontalSpacing,
        AppText(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.kGrey30,
          ),
        ),
      ],
    );
  }
}
