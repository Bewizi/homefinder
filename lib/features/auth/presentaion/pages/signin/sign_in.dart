import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:homefinder/core/navigation/app_router.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/app_text_field.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/app_svg.dart';
import 'package:homefinder/core/variables/colors.dart';
import 'package:homefinder/features/auth/presentaion/auth_bloc/auth_bloc.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  static const String routeName = '/sign-in';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
          BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Authenticated) {
                HomeRoute().go(context);
              }

              if (state is AuthError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: AppText(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              return Expanded(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //  email address
                        AppTextField(
                          controller: _emailController,
                          title: 'Email Address',
                          hintText: 'Example@gmail.com',
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.envelope,
                            size: AppIconSize.regular,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email address';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        16.verticalSpacing,

                        //  password
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTextField(
                              controller: _passwordController,
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
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
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
                                      ..onTap = () => context.push(
                                        ForgotPasswordRoute.path,
                                      ),
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
                          state is AuthLoading ? 'Signing In...' : 'Sign In',
                          loading: state is AuthLoading,
                          pressed: state is AuthLoading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                      Login(
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text
                                            .trim(),
                                      ),
                                    );
                                  }
                                },
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
              );
            },
          ),
        ],
      ),
    );
  }
}
