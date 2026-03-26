import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/app_text_field.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/colors.dart';
import 'package:homefinder/features/profile/presentation/widgets/build_stat.dart';

class UsersAccount extends StatefulWidget {
  const UsersAccount({super.key});

  static const String routeName = '/users-account';

  @override
  State<UsersAccount> createState() => _UsersAccountState();
}

class _UsersAccountState extends State<UsersAccount> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appbar: AppBar(
        forceMaterialTransparency: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const AppText(
          'My Account',
        ),
        titleTextStyle: context.textTheme.headlineSmall?.copyWith(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: AppColors.kGrey80,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1763757321139-e7e4de128cd9?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzZ8fGhlYWRzaG90JTIwYmxhY2slMjBwZW9wbGV8ZW58MHx8MHx8fDA%3D',
                    ),
                  ),
                  16.verticalSpacing,
                  AppText(
                    'Arlene McCoy',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.kGrey80,
                    ),
                  ),
                  4.verticalSpacing,
                  buildStat(context),
                ],
              ),
            ),
            32.verticalSpacing,
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //  full name
                  const AppTextField(
                    title: 'Full Name',
                    hintText: 'Arlene McCoy',
                    keyboardType: TextInputType.name,
                    prefixIcon: Icon(
                      FontAwesomeIcons.user,
                      size: AppIconSize.regular,
                    ),
                  ),
                  16.verticalSpacing,

                  //  email address
                  const AppTextField(
                    title: 'Email Address',
                    hintText: 'arlenemccoy@gmail.com',
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
                    suffixIcon: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppText(
                            'Change',
                            style: context.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.kPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  16.verticalSpacing,

                  //  phone number
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AppTextField(
                        title: 'Phone Number',
                        hintText: '9000-000-000',
                        keyboardType: TextInputType.phone,
                        prefixIcon: Icon(Icons.phone),
                      ),
                      8.verticalSpacing,
                      AppText(
                        'You won’t be able to call landlord if this is empty',
                        style: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.kGrey40,
                        ),
                      ),
                    ],
                  ),

                  16.verticalSpacing,
                  const AppTextField(
                    title: 'Location',
                    hintText: 'Lagos, Nigeria',
                    prefixIcon: Icon(Icons.location_on),
                    suffixIcon: Icon(Icons.map_outlined),
                  ),
                  32.verticalSpacing,

                  PrimaryButton(
                    'Save changes',
                    pressed: () {},
                  ),
                  24.verticalSpacing,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
