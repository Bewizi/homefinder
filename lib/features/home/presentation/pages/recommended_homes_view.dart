import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_card.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';
import 'package:homefinder/features/home/presentation/recommended_homes_bloc/recommended_homes_bloc.dart';

class RecommendedHomesView extends StatelessWidget {
  const RecommendedHomesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendedHomesBloc, RecommendedHomesState>(
      builder: (context, state) {
        if (state is RecommendedHomesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is RecommendedHomesError) {
          return Center(
            child: AppText(
              state.message,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          );
        }

        if (state is RecommendedHomesLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                'Recommended Homes',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.kGray50,
                  fontWeight: FontWeight.w500,
                ),
              ),
              8.verticalSpacing,
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final recommendedHome = state.recommendedHomes[index];
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
                                recommendedHome.image,
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
                                            recommendedHome.rating.toString(),
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
                                    recommendedHome.name,
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
                                      text:
                                          '#${recommendedHome.price_per_month}M',
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
                                    recommendedHome.location,
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
                                  '${recommendedHome.beds} Bedrooms',
                                  context,
                                ),
                                const VerticalDivider(
                                  thickness: 1,
                                  color: AppColors.kGrey30,
                                  width: 16,
                                ),
                                _buildFeature(
                                  FontAwesomeIcons.bath,
                                  '${recommendedHome.baths} Baths',
                                  context,
                                ),
                                const VerticalDivider(
                                  thickness: 1,
                                  color: AppColors.kGrey30,
                                  width: 16,
                                ),
                                _buildFeature(
                                  FontAwesomeIcons.ruler,
                                  '${recommendedHome.sqft} sqft',
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
                itemCount: state.recommendedHomes.length,
              ),
            ],
          );
        }

        return Center(
          child: AppText(
            'No Data',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        );
      },
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
