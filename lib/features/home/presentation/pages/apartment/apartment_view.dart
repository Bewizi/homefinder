import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/colors.dart';
import 'package:homefinder/features/home/data/homes_data.dart';
import 'package:homefinder/features/home/domain/homes_domain.dart';
import 'package:homefinder/features/home/presentation/widgets/navigation_arrow.dart';
import 'package:homefinder/features/home/presentation/widgets/page_indicator.dart';

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
      padding: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  itemCount: apartment!.images.length,
                  onPageChanged: _onPageChanged,
                  itemBuilder: (context, index) {
                    return _buildPage(apartment!.images[index]);
                  },
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

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                ],
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
        Icon(icon, size: 18, color: AppColors.kGrey80),
        const SizedBox(width: 4),
        AppText(
          text,
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.kGrey80,
          ),
        ),
      ],
    );
  }

  Widget _buildAmenity(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: AppText(
        label,
        style: context.textTheme.bodySmall,
      ),
    );
  }
}
