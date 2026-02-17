import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/variables/colors.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(backgroundColor: AppColors.kPrimary, body: Center());
  }
}
