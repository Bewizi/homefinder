import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homefinder/core/navigation/app_router.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/app_text_field.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/app_svg.dart';
import 'package:homefinder/core/variables/colors.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static const routeName = '/sign-up';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          //   logo and text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppSvg.kLogoBlue,
                width: 64,
                height: 64,
              ),
              4.verticalSpacing,
              AppText(
                'Create Your Account',
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
                'Your next home is just a few clicks away',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: AppColors.kGrey10),
              ),
            ],
          ),

          24.verticalSpacing,

          //   form
          Expanded(
            child: SingleChildScrollView(
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //  full name
                    const AppTextField(
                      title: 'Full Name',
                      hintText: 'John Doe',
                      keyboardType: TextInputType.name,
                      prefixIcon: Icon(
                        FontAwesomeIcons.user,
                        size: AppIconSize.regular,
                      ),
                    ),
                    16.verticalSpacing,

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
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.kGrey30,
                              ),
                        ),
                      ),
                    ),
                    16.verticalSpacing,

                    //  email address
                    const AppTextField(
                      title: 'Email Address',
                      hintText: 'Example@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Icon(
                        FontAwesomeIcons.envelope,
                        size: AppIconSize.regular,
                      ),
                    ),
                    16.verticalSpacing,

                    //  password
                    AppTextField(
                      title: 'Password',
                      hintText: '*****************',
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: const Icon(
                        FontAwesomeIcons.lock,
                        size: AppIconSize.regular,
                      ),
                      obscureText: !isPasswordVisible,
                      onSuffixIconTap: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      suffixIcon: Icon(
                        isPasswordVisible
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        size: AppIconSize.regular,
                      ),
                    ),
                    24.verticalSpacing,

                    PrimaryButton(
                      'Sign Up',
                      pressed: () {},
                    ),
                    16.verticalSpacing,
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Already have an account? ',
                              style:
                                  Theme.of(
                                    context,
                                  ).textTheme.bodySmall?.copyWith(
                                    color: AppColors.kGrey70,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => SignInRoute().go(context),
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
}
