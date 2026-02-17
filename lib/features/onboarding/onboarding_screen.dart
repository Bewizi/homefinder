import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/variables/app_images.dart';
import 'package:homefinder/core/variables/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  static const String routeName = '/onboarding';

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> pages = [
    {
      'image': AppImages.kAmico,
      'title': 'Direct Rentals Made Easy',
      'description':
          'Homefinder connects you with verified landlords, so you can find '
          'your next home with trust, transparency, and no hidden costs.',
    },
    {
      'image': AppImages.kAmico2,
      'title': "See It Like You're There",
      'description':
          'Each listing comes with a detailed video tour showcasing the house. '
          'You can also schedule in-person tour to inspect the space '
          'at no cost.',
    },
    {
      'image': AppImages.kAmico3,
      'title': 'Rent Smarter, All in One App',
      'description':
          'Homefinder gives you full control of your rental journey. Explore '
          'listings, chat with landlords, make payment, send move-out notice, '
          'all within the app.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);
  }

  Future<void> _goToNext() async {
    if (_currentIndex < pages.length - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _onFinish();
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

  void _onFinish() {
    // const GetStartedRoute().go(context);
  }

  void _onSkip() {
    _onFinish();
  }

  @override
  Widget build(BuildContext context) {
    final isFirst = _currentIndex == 0;
    final isLast = _currentIndex == pages.length - 1;

    return AppScaffold(
      body: Column(
        children: [
          // Skip button
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 16, right: 24),
              child: GestureDetector(
                onTap: _onSkip,
                child: AppText(
                  'Skip',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.kPrimary,
                  ),
                ),
              ),
            ),
          ),

          // Page content
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: pages.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) {
                final page = pages[index];
                return _buildPage(
                  page['image']!,
                  page['title']!,
                  page['description']!,
                );
              },
            ),
          ),

          // Bottom: arrows + indicators
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Left arrow
                _NavArrowButton(
                  icon: Icons.arrow_back,
                  onTap: isFirst ? null : _goToPrevious,
                ),

                // Page indicators
                Row(
                  children: List.generate(
                    pages.length,
                    (index) => _PageIndicator(isActive: index == _currentIndex),
                  ),
                ),

                // Right arrow
                _NavArrowButton(
                  icon: Icons.arrow_forward,
                  onTap: _goToNext,
                  isPrimary: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(String image, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              fit: BoxFit.contain,
              height: 280,
            ),
            32.verticalSpacing,
            AppText(
              title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: AppColors.kGray40,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            16.verticalSpacing,
            AppText(
              description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.kGray40,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final bool isActive;

  const _PageIndicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.kPrimary
            : AppColors.kPrimary.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _NavArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  final bool isPrimary;

  const _NavArrowButton({
    required this.icon,
    this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onTap == null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: isPrimary
              ? AppColors.kPrimary
              : isDisabled
              ? AppColors.kPrimary.withValues(alpha: 0.1)
              : AppColors.kPrimary.withValues(alpha: 0.15),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isPrimary
              ? Colors.white
              : isDisabled
              ? AppColors.kPrimary.withValues(alpha: 0.3)
              : AppColors.kPrimary,
          size: 20,
        ),
      ),
    );
  }
}
