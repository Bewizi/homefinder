import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:homefinder/features/auth/presentaion/auth_bloc/auth_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  static const routeName = '/sign-up';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneNumberController.dispose();
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
                'Create Your Account',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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
                        //  full name
                        AppTextField(
                          controller: _fullNameController,
                          title: 'Full Name',
                          hintText: 'John Doe',
                          keyboardType: TextInputType.name,
                          prefixIcon: const Icon(
                            FontAwesomeIcons.user,
                            size: AppIconSize.regular,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your full name';
                            }
                            return null;
                          },
                        ),
                        16.verticalSpacing,

                        //  phone number
                        AppTextField(
                          controller: _phoneNumberController,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                        ),
                        16.verticalSpacing,

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
                        24.verticalSpacing,

                        PrimaryButton(
                          state is AuthLoading ? 'Signing Up...' : 'Sign Up',
                          loading: state is AuthLoading,
                          pressed: state is AuthLoading
                              ? null
                              : () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthBloc>().add(
                                      CreateAccount(
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text
                                            .trim(),
                                        fullName: _fullNameController.text
                                            .trim(),
                                        phoneNumber: _phoneNumberController.text
                                            .trim(),
                                      ),
                                    );
                                  }
                                },
                        ),
                        16.verticalSpacing,
                        Center(
                          child: RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Already have an account? ',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: AppColors.kGrey70,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => SignInRoute().go(context),
                                  text: 'Sign In',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
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
              );
            },
          ),
        ],
      ),
    );
  }
}
