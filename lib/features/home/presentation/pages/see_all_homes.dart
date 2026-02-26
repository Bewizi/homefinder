import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_card.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/app_text_field.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';
import 'package:homefinder/features/home/presentation/homes_bloc/homes_bloc.dart';

class SeeAllHomes extends StatefulWidget {
  const SeeAllHomes({super.key});

  static const String routeName = '/see-all-homes';

  @override
  State<SeeAllHomes> createState() => _SeeAllHomesState();
}

class _SeeAllHomesState extends State<SeeAllHomes> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // search for home base on the name
              Expanded(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: const AppTextField(
                    hintText: 'search by city, street.....',
                    prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
                  ),
                ),
              ),

              8.horizontalSpacing,
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppRadius.medium,
                  ),
                  border: Border.all(
                    width: 2,
                    color: AppColors.kGrey5,
                  ),
                ),
                child: const Icon(
                  FontAwesomeIcons.sliders,
                ),
              ),
            ],
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
                  return ListView.separated(
                    itemBuilder: (context, index) {
                      final home = state.homes[index];
                      return AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        //   rating
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.kWhite,
                                            borderRadius: BorderRadius.circular(
                                              AppRadius.fullRadius,
                                            ),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
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
                                                home.rating.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall
                                                    ?.copyWith(
                                                      color: AppColors.kGrey80,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        //   heart icon
                                        IconConButton(
                                          shape: BoxShape.circle,
                                          borderColor: AppColors.kTransparent,
                                          bgColor: AppColors.kWhite,
                                          child: const Icon(
                                            FontAwesomeIcons.heart,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: AppText(
                                        home.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(
                                              color: AppColors.kGrey80,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                    AppRichText(
                                      spans: [
                                        TextSpan(
                                          text: '#${home.price_per_month}M',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall
                                              ?.copyWith(
                                                color: AppColors.kPrimary,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 20,
                                              ),
                                        ),
                                        TextSpan(
                                          text: '/year',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                color: AppColors.kGrey40,
                                                fontWeight: FontWeight.w500,
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
                                              color: AppColors.kGrey30,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                                16.verticalSpacing,
                                Row(
                                  children: [
                                    _buildFeature(
                                      FontAwesomeIcons.bed,
                                      '${home.beds} Bedrooms',
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
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (_, _) => 16.verticalSpacing,
                    itemCount: state.homes.length,
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

  Widget _buildFeature(IconData icon, String text, BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: AppIconSize.regular,
          color: AppColors.kGrey30,
        ),
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
