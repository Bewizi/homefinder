import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  static const String routeName = '/profile';

  static const List<Map<String, dynamic>> profileOptions = [
    {
      'icon': Icons.person_outline,
      'text': 'My Account',
      'route': '/users-account',
    },
    {'icon': Icons.settings_outlined, 'text': 'Settings', 'route': '/settings'},
    {
      'icon': Icons.apartment_outlined,
      'text': 'Apartment',
    },
    {
      'icon': Icons.account_balance_wallet_outlined,
      'text': 'My Payments',
    },
    {
      'icon': Icons.headset_mic_outlined,
      'text': 'Support',
    },
    {
      'icon': Icons.logout,
      'text': 'Logout',
      'color': AppColors.kDestructive5,
      'iconColor': AppColors.kDestructive60,
      'textColor': AppColors.kDestructive50,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.verticalSpacing,
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
                  _buildStat(context),
                ],
              ),
            ),
            32.verticalSpacing,

            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: profileOptions.length,
              separatorBuilder: (context, index) => 16.verticalSpacing,
              itemBuilder: (context, index) {
                final option = profileOptions[index];
                return ProfileOption(
                  option['text'] as String,
                  option['icon'] as IconData,
                  iconContainerColor: option['color'] as Color?,
                  iconColor: option['iconColor'] as Color?,
                  textColor: option['textColor'] as Color?,
                  onTap: () async {
                    final route = option['route'] as String?;
                    if (route != null) {
                      await context.push(route);
                    }
                  },
                );
              },
            ),
            24.verticalSpacing,
          ],
        ),
      ),
    );
  }

  Widget _buildStat(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.kSuccess5,
        border: Border.all(color: AppColors.kSuccess10, width: 2),
        borderRadius: BorderRadius.circular(AppRadius.fullRadius),
      ),
      child: AppText(
        'HomeFinder',
        style: context.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.kSuccess50,
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  const ProfileOption(
    this.text,
    this.icon, {
    this.iconContainerColor,
    this.iconColor,
    this.textColor,
    this.onTap,
    super.key,
  });

  final Color? iconContainerColor;
  final Color? iconColor;
  final Color? textColor;
  final String text;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 0,
      horizontalTitleGap: 16,
      leading: Container(
        width: AppIconContainerSize.medium,
        height: AppIconContainerSize.medium,
        decoration: BoxDecoration(
          color: iconContainerColor ?? AppColors.kBrand5,
          borderRadius: BorderRadius.circular(AppRadius.fullRadius),
        ),
        child: Icon(
          icon,
          color: iconColor ?? AppColors.kPrimary,
          size: 20,
        ),
      ),
      title: AppText(
        text,
        style: context.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: textColor ?? AppColors.kGrey80,
        ),
      ),
    );
  }
}
