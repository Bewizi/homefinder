import 'package:flutter/material.dart';
import 'package:homefinder/core/navigation/app_router.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/variables/app_images.dart';
import 'package:homefinder/core/variables/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const String routeName = '/splashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 5),
      () {
        if (mounted) {
          GetStartedRoute().go(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: AppColors.kPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.kLogoWhite,
              width: 100,
              height: 100,
            ),
            AppText(
              'Homefinder',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
