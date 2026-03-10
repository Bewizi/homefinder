import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/app_inset.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';

class MessageView extends StatelessWidget {
  const MessageView({super.key});

  static const String routeName = '/message-view';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      // padding: EdgeInsets.zero,
      appbar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://mockmind-api.uifaces.co/content/human/102.jpg',
              ),
            ),
            8.horizontalSpacing,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  'Eleanor Pena',
                  style: context.textTheme.titleSmall?.copyWith(
                    color: AppColors.kGrey80,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                8.verticalSpacing,
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.kSuccess50,
                        shape: BoxShape.circle,
                      ),
                    ),
                    4.horizontalSpacing,
                    AppText(
                      'Available',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: AppColors.kSuccess50,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(
              Icons.call_outlined,
              size: 18,
              color: AppColors.kGray50,
            ),
            label: AppText(
              'Call',
              style: context.textTheme.titleSmall?.copyWith(
                color: AppColors.kGray50,
                fontWeight: FontWeight.w700,
              ),
            ),
            style: OutlinedButton.styleFrom(
              shape: const StadiumBorder(),
              side: const BorderSide(color: AppColors.kGrey10),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              color: AppColors.kGrey10,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: AppInset.screenSymmetric,
              children: [
                const Center(
                  child: Text('Today', style: TextStyle(color: Colors.grey)),
                ),
                16.verticalSpacing,
                // Add your chat bubbles here
              ],
            ),
          ),

          //   message input text
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.kGrey80.withValues(alpha: 0.10),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                    spreadRadius: -4,
                  ),
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(12),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.fullRadius),
                    borderSide: const BorderSide(color: AppColors.kGrey5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.fullRadius),
                    borderSide: const BorderSide(color: AppColors.kGrey5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.fullRadius),
                    borderSide: const BorderSide(color: AppColors.kGrey5),
                  ),
                  fillColor: AppColors.kWhite,
                  hintText: 'Write your message here...',
                  prefixIcon: const Icon(Icons.add, color: AppColors.kGrey30),
                  suffixIcon: const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FontAwesomeIcons.microphone,
                          color: AppColors.kGrey30,
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.send_outlined, color: AppColors.kPrimary),
                      ],
                    ),
                  ),
                  hintStyle: context.textTheme.titleSmall?.copyWith(
                    color: AppColors.kGrey40,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
