import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';
import 'package:homefinder/features/home/data/homes_data.dart';
import 'package:homefinder/features/home/domain/homes_domain.dart';
import 'package:homefinder/features/home/presentation/widgets/navigation_arrow.dart';
import 'package:homefinder/features/home/presentation/widgets/page_indicator.dart';
import 'package:homefinder/features/home/presentation/widgets/pricing_table.dart';

class ApartmentView extends StatefulWidget {
  final String id;

  const ApartmentView({super.key, required this.id});

  @override
  State<ApartmentView> createState() => _ApartmentViewState();
}

class _ApartmentViewState extends State<ApartmentView> {
  HomesDomain? apartment;
  bool isLoading = true;
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> amenitiesList = [
    'Elevator',
    'Doorman',
    'Garage',
    'Air Conditioning',
    'Hardwood Floors',
    'Gym',
    'Dishwasher',
    'In-unit Laundry',
  ];

  @override
  void initState() {
    super.initState();
    _loadApartment();
  }

  Future<void> _loadApartment() async {
    final homes = await HomesData().getAllHomes();
    setState(() {
      apartment = homes.firstWhere((e) => e.id == widget.id);
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
  }

  Future<void> _goToNext() async {
    if (_currentIndex < apartment!.images.length - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _goToPrevious() async {
    if (_currentIndex > 0) {
      await _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const AppScaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (apartment == null) {
      return const AppScaffold(
        body: Center(child: AppText('Apartment not found')),
      );
    }

    return AppScaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        height: MediaQuery.sizeOf(context).height * 0.095,
        decoration: BoxDecoration(
          color: AppColors.kWhite,
          boxShadow: [
            BoxShadow(
              color: AppColors.kBlack.withValues(alpha: 0.1),
              offset: const Offset(0, -4),
              blurRadius: 16,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppRichText(
                spans: [
                  TextSpan(
                    text: '#${apartment!.price_per_month}',
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: AppColors.kPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  TextSpan(
                    text: '/year',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColors.kGrey30,
                    ),
                  ),
                ],
              ),

              PrimaryButton(
                width: MediaQuery.sizeOf(context).width * 0.3,
                'Message',
                pressed: () {},
                color: AppColors.kPrimary,
                textColor: AppColors.kWhite,
              ),
            ],
          ),
        ),
      ),
      padding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                if (apartment!.images.isNotEmpty)
                  PageView.builder(
                    controller: _pageController,
                    itemCount: apartment!.images.length,
                    onPageChanged: _onPageChanged,
                    itemBuilder: (context, index) {
                      return _buildPage(apartment!.images[index]);
                    },
                  ),
                if (apartment!.images.isEmpty)
                  Image.asset(
                    width: double.infinity,
                    apartment!.image,
                    height: 300,
                    fit: BoxFit.cover,
                  ),

                Positioned(
                  top: 8,
                  left: 16,
                  right: 16,
                  child: _buildTopBar(),
                ),

                // Centered Navigation Arrows
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NavigationArrow(
                          icon: Icons.arrow_back_ios_outlined,
                          onPressed: _goToPrevious,
                        ),
                        NavigationArrow(
                          icon: Icons.arrow_forward_ios_outlined,
                          onPressed: _goToNext,
                        ),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      apartment!.images.length,
                      (index) =>
                          PageIndicator(isActive: index == _currentIndex),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // apartment type and rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // apartment type
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.kBrand5,
                            borderRadius: BorderRadius.circular(
                              AppRadius.medium,
                            ),
                          ),

                          child: AppText(
                            apartment!.type,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: AppColors.kPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        _buildStat(Icons.star_outlined, '${apartment!.rating}'),
                      ],
                    ),

                    16.verticalSpacing,

                    // apartment name
                    AppText(
                      apartment!.name,
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.kGrey80,
                      ),
                    ),

                    8.verticalSpacing,

                    //   address
                    Row(
                      children: [
                        //   icon
                        const Icon(
                          Icons.location_on_outlined,
                          color: AppColors.kGrey40,
                          size: 18,
                        ),
                        8.horizontalSpacing,
                        AppText(
                          apartment!.location,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.kGrey40,
                          ),
                        ),
                      ],
                    ),

                    16.verticalSpacing,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildFeature(
                          FontAwesomeIcons.bed,
                          '${apartment!.beds} Bedrooms',
                          context,
                        ),
                        const VerticalDivider(
                          thickness: 1,
                          color: AppColors.kGrey30,
                          width: 16,
                        ),
                        _buildFeature(
                          FontAwesomeIcons.bath,
                          '${apartment!.baths} Baths',
                          context,
                        ),
                        const VerticalDivider(
                          thickness: 1,
                          color: AppColors.kGrey30,
                          width: 16,
                        ),
                        _buildFeature(
                          FontAwesomeIcons.ruler,
                          '${apartment!.sqft} sqft',
                          context,
                        ),
                      ],
                    ),

                    //   apartment description
                    32.verticalSpacing,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          'Details',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: AppColors.kGrey80,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        8.verticalSpacing,
                        AppText(
                          apartment!.description,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.kGrey40,
                            height: 2,
                          ),
                        ),
                      ],
                    ),

                    // amenities
                    32.verticalSpacing,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          'Amenities',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: AppColors.kGrey80,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        8.verticalSpacing,
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final amenity in amenitiesList)
                              _buildAmenity(amenity),
                          ],
                        ),
                      ],
                    ),

                    //   pricing breakdown
                    32.verticalSpacing,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          'Pricing Breakdown',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: AppColors.kGrey80,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        8.verticalSpacing,
                        const PricingTable(),
                      ],
                    ),

                    //   landlord details
                    32.verticalSpacing,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText(
                          'Landlord Details',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: AppColors.kGrey80,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        8.verticalSpacing,
                        _buildLandlordDetails(),
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

  Widget _buildPage(
    String image,
  ) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Image.asset(
        image,
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: AppColors.kWhite,
          ),
          onPressed: () => Navigator.pop(context),
        ),

        Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.ios_share,
                color: AppColors.kWhite,
              ),
              onPressed: () {},
            ),
            16.horizontalSpacing,
            IconButton(
              icon: const Icon(
                Icons.favorite_border,
                color: AppColors.kWhite,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStat(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.kWarning50),
        8.horizontalSpacing,

        AppRichText(
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.kGrey40,
            fontWeight: FontWeight.w600,
          ),
          spans: [
            TextSpan(
              text: text,
            ),
            const TextSpan(text: '/5.0'),
          ],
        ),
      ],
    );
  }

  Widget _buildAmenity(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.kGrey5),
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: AppText(
        label,
        style: context.textTheme.bodySmall,
      ),
    );
  }

  Widget _buildLandlordDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        border: Border.all(color: AppColors.kGray30),
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //landlord image
          ClipOval(
            child: Image.network(
              'https://images.unsplash.com/photo-1529111290557-82f6d5c6cf85?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8ODZ8fGJsYWNrJTIwcGVvcGxlfGVufDB8fDB8fHww',
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
          ),
          16.verticalSpacing,
          //landlord name
          AppText(
            'Eleanor Pena',
            style: context.textTheme.titleMedium?.copyWith(
              color: AppColors.kGrey80,
              fontWeight: FontWeight.w700,
            ),
          ),
          8.verticalSpacing,
          Container(
            width: MediaQuery.sizeOf(context).width * 0.25,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.kSuccess5,
              borderRadius: BorderRadius.circular(AppRadius.fullRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.verified_outlined,
                  color: AppColors.kSuccess50,
                  size: AppIconSize.small,
                ),
                4.horizontalSpacing,
                AppText(
                  'Verified',
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.kSuccess50,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          16.verticalSpacing,
          //landlord description
          AppText(
            'Trusted landlord known for prompt communication, well-maintained properties, and a tenant-first approach.',
            style: context.textTheme.bodySmall?.copyWith(
              color: AppColors.kGrey40,
            ),
            textAlign: TextAlign.center,
          ),
          16.verticalSpacing,
          //landlord contact
          PrimaryButton(
            'Contact',
            pressed: () {},
            color: AppColors.kBrand5,
            textColor: AppColors.kPrimary,
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
