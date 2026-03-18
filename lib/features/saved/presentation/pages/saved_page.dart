import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homefinder/core/navigation/app_router.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_card.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';
import 'package:homefinder/features/home/presentation/homes_bloc/homes_bloc.dart';

class SavedPage extends StatelessWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: BlocBuilder<HomesBloc, HomesState>(
        builder: (context, state) {
          if (state is HomesLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is HomesError) {
            return Center(child: AppText(state.message));
          }
          if (state is HomesLoaded) {
            final savedHomes = state.homes.where((h) => h.isFavourite).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText(
                      'Saved',
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.kGrey80,
                      ),
                    ),
                    8.horizontalSpacing,
                    AppText(
                      '${savedHomes.length}',
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppColors.kPrimary,
                      ),
                    ),
                  ],
                ),
                24.verticalSpacing,
                Expanded(
                  child: savedHomes.isEmpty
                      ? const Center(child: AppText('No saved homes yet.'))
                      : ListView.separated(
                          itemCount: savedHomes.length,
                          separatorBuilder: (_, _) => 24.verticalSpacing,
                          itemBuilder: (context, index) {
                            final home = savedHomes[index];
                            return GestureDetector(
                              onTap: () =>
                                  ApartmentViewRoute(id: home.id).push(context),
                              child: AppCard(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            AppRadius.medium,
                                          ),
                                          child: Image.network(
                                            home.image,
                                            fit: BoxFit.cover,
                                            height: 200,
                                            width: double.infinity,
                                          ),
                                        ),
                                        Positioned(
                                          top: 12,
                                          left: 12,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: AppColors.kWhite,
                                              borderRadius:
                                                  BorderRadius.circular(
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
                                                  style: context
                                                      .textTheme
                                                      .bodySmall
                                                      ?.copyWith(
                                                        color:
                                                            AppColors.kGrey80,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 12,
                                          right: 12,
                                          child: IconConButton(
                                            shape: BoxShape.circle,
                                            borderColor: AppColors.kTransparent,
                                            bgColor: AppColors.kWhite,
                                            child: const Icon(
                                              FontAwesomeIcons.solidHeart,
                                              color: AppColors.kPrimary,
                                              size: AppIconSize.small,
                                            ),
                                            pressed: () {
                                              context.read<HomesBloc>().add(
                                                ToggleFavorite(home.id),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    16.verticalSpacing,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: AppText(
                                            home.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: context.textTheme.titleSmall
                                                ?.copyWith(
                                                  color: AppColors.kGrey80,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ),
                                        AppRichText(
                                          spans: [
                                            TextSpan(
                                              text: '#${home.price_per_month}M',
                                              style: context
                                                  .textTheme
                                                  .titleMedium
                                                  ?.copyWith(
                                                    color: AppColors.kPrimary,
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                            ),
                                            TextSpan(
                                              text: '/year',
                                              style: context.textTheme.bodySmall
                                                  ?.copyWith(
                                                    color: AppColors.kGrey40,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    8.verticalSpacing,
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
                                            style: context.textTheme.bodySmall
                                                ?.copyWith(
                                                  color: AppColors.kGrey30,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    16.verticalSpacing,
                                    IntrinsicHeight(
                                      child: Row(
                                        children: [
                                          _buildFeature(
                                            FontAwesomeIcons.bed,
                                            '${home.beds} Bedrooms',
                                            context,
                                          ),
                                          const VerticalDivider(
                                            thickness: 1,
                                            color: AppColors.kGrey5,
                                            width: 24,
                                          ),
                                          _buildFeature(
                                            FontAwesomeIcons.bath,
                                            '${home.baths} Baths',
                                            context,
                                          ),
                                          const VerticalDivider(
                                            thickness: 1,
                                            color: AppColors.kGrey5,
                                            width: 24,
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
                            );
                          },
                        ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildFeature(IconData icon, String text, BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: AppIconSize.small, color: AppColors.kGrey30),
        8.horizontalSpacing,
        AppText(
          text,
          style: context.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppColors.kGrey30,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
