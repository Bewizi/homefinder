import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:homefinder/core/navigation/app_router.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';
import 'package:homefinder/features/auth/presentaion/auth_bloc/auth_bloc.dart';
import 'package:homefinder/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:homefinder/features/profile/presentation/bloc/profile_event.dart';
import 'package:homefinder/features/profile/presentation/bloc/profile_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  static const String routeName = '/profile';

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      'isLogout': true,
      'color': AppColors.kDestructive5,
      'iconColor': AppColors.kDestructive60,
      'textColor': AppColors.kDestructive50,
    },
  ];

  @override
  void initState() {
    super.initState();

    context.read<ProfileBloc>().add(LoadProfile());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          SignInRoute().go(context);
        }
      },
      child: AppScaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              24.verticalSpacing,
              Center(
                child: BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) {
                    String name = 'User';
                    String? avatarUrl;

                    if (state is ProfileLoaded) {
                      name = state.profile.fullName;
                      avatarUrl = state.profile.avatarUrl;
                    }

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                            avatarUrl ??
                                'https://images.unsplash.com/photo-1763757321139-e7e4de128cd9?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzZ8fGhlYWRzaG90JTIwYmxhY2slMjBwZW9wbGV8ZW58MHx8MHx8fDA%3D',
                          ),
                        ),
                        16.verticalSpacing,
                        AppText(
                          name,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.kGrey80,
                          ),
                        ),
                        4.verticalSpacing,
                        _buildStat(context),
                      ],
                    );
                  },
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
                    onTap: () {
                      if (option['isLogout'] == true) {
                        _showLogoutDialog(context);
                      } else {
                        final route = option['route'] as String?;
                        if (route != null) {
                          context.push(route);
                        }
                      }
                    },
                  );
                },
              ),
              24.verticalSpacing,
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const AppText('Logout'),
        content: AppText(
          'Are you sure you want to logout?',
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: AppColors.kGrey80,
          ),
        ),
        actions: [
          TextButton(
            isSemanticButton: false,
            onPressed: () => Navigator.pop(context),
            child: AppText(
              'Cancel',
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.kGrey80,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthBloc>().add(Logout());
            },
            child: AppText(
              'Logout',
              style: context.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.kDestructive50,
              ),
            ),
          ),
        ],
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
