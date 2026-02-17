import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:homefinder/core/navigation/app_router.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/variables/app_images.dart';
import 'package:homefinder/core/variables/colors.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  static const String routeName = '/get-started';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.kGetStartedBg),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.kGrey80.withValues(alpha: 0),
              AppColors.kBlack,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppText(
                'Discover your Perfect Rental Home Just a Tap Away',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              16.verticalSpacing,
              AppText(
                'Search, compare, and rent your home - fast and easy with '
                'Homefinder. Thousands of listing. Zero hassle.',
                style: Theme.of(context).textTheme.titleSmall,
                textAlign: TextAlign.center,
              ),
              32.verticalSpacing,
              PrimaryButton(
                'Get Started',
                pressed: () {
                  OnboardingRoute().go(context);
                  debugPrint('Pressed');
                },
              ),
              32.verticalSpacing,
              Center(
                child: AppRichText(
                  textAlign: TextAlign.center,
                  spans: [
                    TextSpan(
                      text: 'Already have an account? ',
                      style:
                          Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: AppColors.kWhite,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () {},
                      text: 'Sign In',
                      style:
                          Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color: AppColors.kPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
