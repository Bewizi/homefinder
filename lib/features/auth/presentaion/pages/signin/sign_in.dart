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
import 'package:homefinder/core/variables/app_svg.dart';
import 'package:homefinder/core/variables/colors.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  static const String routeName = '/sign-in';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                'Welcome Back',
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
                'Continue your home search in seconds.',
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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

                        8.verticalSpacing,

                        //   forgot password
                        Align(
                          alignment: Alignment.bottomRight,
                          child: AppRichText(
                            textAlign: TextAlign.end,
                            spans: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      ForgotPasswordRoute().go(context),
                                text: 'Forgot password?',
                                style: Theme.of(context).textTheme.bodySmall
                                    ?.copyWith(
                                      color: AppColors.kPrimary,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    24.verticalSpacing,

                    PrimaryButton(
                      'Sign In',
                      pressed: () {},
                    ),
                    16.verticalSpacing,
                    Center(
                      child: AppRichText(
                        textAlign: TextAlign.center,
                        spans: [
                          TextSpan(
                            text: 'Don’t have an account? ',
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
                              ..onTap = () => SignUpRoute().go(context),
                            text: 'Sign Up',
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
          ),
        ],
      ),
    );
  }
}
