import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
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
      body: Column(
        children: [
          Column(
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
            ],
          ),
        ],
      ),
    );
  }
}
