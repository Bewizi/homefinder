import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';

class BathRoom extends StatefulWidget {
  const BathRoom({super.key});

  @override
  State<BathRoom> createState() => _BathRoomState();
}

class _BathRoomState extends State<BathRoom> {
  int activeIndex = 0;

  static const List<String> homeFilter = [
    'All',
    '01',
    '02',
    '03',
    '04',
    '05',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Bathroom',
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.kGray50,
            fontWeight: FontWeight.w600,
          ),
        ),
        8.verticalSpacing,
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.06,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final item = homeFilter[index];
              final isActive = activeIndex == index;
              return OutlineButton(
                item,
                borderColor: isActive ? AppColors.kPrimary : AppColors.kGrey5,
                bgColor: isActive ? AppColors.kBrand5 : AppColors.kWhite,
                textColor: isActive ? AppColors.kPrimary : AppColors.kGrey30,
                borderRadius: AppRadius.medium,
                pressed: () {
                  setState(() {
                    activeIndex = index;
                  });
                },
              );
            },
            separatorBuilder: (_, _) => 8.horizontalSpacing,
            itemCount: homeFilter.length,
          ),
        ),
      ],
    );
  }
}
