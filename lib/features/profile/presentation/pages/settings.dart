import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/colors.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  static const String routerName = '/settings';

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool textNotifications = false;
  bool emailNotifications = false;
  bool mobileNotifications = true;

  String selectedAppearance = 'Light';

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
          'Settings',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            24.verticalSpacing,
            AppText(
              'Notifications',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.kGrey80,
              ),
            ),
            16.verticalSpacing,
            _buildSwitchTile(
              title: 'Text',
              value: textNotifications,
              onChanged: (val) => setState(() => textNotifications = val),
            ),
            const Divider(height: 1, color: AppColors.kGrey5),
            _buildSwitchTile(
              title: 'Email',
              value: emailNotifications,
              onChanged: (val) => setState(() => emailNotifications = val),
            ),
            const Divider(height: 1, color: AppColors.kGrey5),
            _buildSwitchTile(
              title: 'Mobile',
              value: mobileNotifications,
              onChanged: (val) => setState(() => mobileNotifications = val),
            ),
            const Divider(height: 1, color: AppColors.kGrey5),
            32.verticalSpacing,
            AppText(
              'Appearance',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.kGrey80,
              ),
            ),
            16.verticalSpacing,
            _buildAppearanceTile('Light'),
            const Divider(height: 1, color: AppColors.kGrey5),
            _buildAppearanceTile('Dark'),
            const Divider(height: 1, color: AppColors.kGrey5),
            _buildAppearanceTile('System theme'),
            const Divider(height: 1, color: AppColors.kGrey5),
            24.verticalSpacing,
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile.adaptive(
      contentPadding: EdgeInsets.zero,
      value: value,
      onChanged: onChanged,
      activeTrackColor: AppColors.kPrimary,

      title: AppText(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.kGrey40,
        ),
      ),
    );
  }

  Widget _buildAppearanceTile(String title) {
    final isSelected = selectedAppearance == title;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: () => setState(() => selectedAppearance = title),
      title: AppText(
        title,
        style: context.textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.w500,
          color: AppColors.kGrey40,
        ),
      ),
      trailing: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? AppColors.kPrimary : AppColors.kGrey5,
            width: isSelected ? 6 : 2,
          ),
        ),
      ),
    );
  }
}
