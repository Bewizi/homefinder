import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/app_text_field.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  static const routeName = '/forgot-password';

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //   logo and text
          Column(
            children: [
              AppText(
                'Forgot Password?',
                style:
                    Theme.of(
                      context,
                    ).textTheme.headlineSmall?.copyWith(
                      color: AppColors.kGray30,
                      fontWeight: FontWeight.w800,
                    ),
              ),
              4.verticalSpacing,
              AppText(
                'We’ll send you a code to securely reset  your password',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.kGrey10),
                textAlign: TextAlign.center,
              ),
            ],
          ),

          24.verticalSpacing,

          //   form
          Form(
            child: Column(
              children: [
                //  phone number
                AppTextField(
                  title: 'Phone Number',
                  hintText: '9000-000-000',
                  keyboardType: TextInputType.phone,
                  prefixIcon: Container(
                    width: 60,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.kGrey5,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppRadius.medium),
                        bottomLeft: Radius.circular(AppRadius.medium),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: AppText(
                      '+234',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.kGrey30,
                      ),
                    ),
                  ),
                ),

                24.verticalSpacing,

                PrimaryButton(
                  'Send OTP Code',
                  pressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
