import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/colors.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  static const String routeName = '/otp';

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.kGrey5),
      borderRadius: BorderRadius.circular(12),
    ),
    textStyle: const TextStyle(
      fontSize: 28,
      color: AppColors.kGrey30,
      fontWeight: FontWeight.w800,
    ),
  );

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
                'OTP Verification',
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
                'We just sent a code to your number. Please enter it below to verify your account',
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
                Pinput(
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  validator: (s) {
                    return s == '222222' ? null : 'Pin is incorrect';
                  },
                  onCompleted: print,
                ),
                24.verticalSpacing,

                PrimaryButton(
                  'Continue',
                  pressed: () {},
                ),

                24.verticalSpacing,

                Row(
                  children: [
                    AppText(
                      '00:28 Sec',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.kGray50,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    AppText(
                      'Resend OTP',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.kPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
