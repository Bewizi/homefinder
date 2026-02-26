import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/variables/colors.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  static const String routeName = '/messages';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
        children: [
          //   fixed
          Column(
            children: [
              Row(
                children: [
                  AppText(
                    'Messages',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.kGrey80,
                    ),
                  ),
                ],
              ),
            ],
          ),

          //   scrollable
        ],
      ),
    );
  }
}
