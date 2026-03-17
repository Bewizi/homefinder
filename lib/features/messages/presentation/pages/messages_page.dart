import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:homefinder/core/navigation/app_router.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/app_text_field.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/app_iconsize.dart';
import 'package:homefinder/core/variables/colors.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  static const String routeName = '/messages';

  static const List<Map<String, dynamic>> messages = [
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1529111290557-82f6d5c6cf85?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8ODZ8fGJsYWNrJTIwcGVvcGxlfGVufDB8fDB8fHww',
      'name': 'Eleanor Pena',
      'message': 'Thanks for confirming! See you on then',
      'isOnline': true,
      'time': '06:25',
      'unreadCount': '3',
    },
    {
      'imageUrl':
          'https://plus.unsplash.com/premium_photo-1692873058087-02e40f29d3df?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mzd8fGhlYWRzaG90JTIwbmlnZXJpYW4lMjBibGFjayUyMHBlb3BsZXxlbnwwfHwwfHx8MA%3D%3D',
      'name': 'Floyd Miles',
      'message': 'Lorem ipsum do eiusmod tempor ut la...',
      'isOnline': true,
      'time': '05:35',
      'unreadCount': '2',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1739566583814-fcead808e96f?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGhlYWRzaG90JTIwbmlnZXJpYW4lMjBibGFjayUyMHBlb3BsZXxlbnwwfHwwfHx8MA%3D%3D',
      'name': 'Cameron Williamson',
      'message': 'Lorem ipsum dolor sit amet, consequen...',
      'isOnline': false,
      'time': '03:25',
      'unreadCount': null,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1531123414780-f74242c2b052?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjJ8fGJsYWNrJTIwcGVvcGxlfGVufDB8fDB8fHww',
      'name': 'Marvin McKinney',
      'message': 'Lorem ipsum dolor sit amet, consequen...',
      'isOnline': false,
      'time': '02:45',
      'unreadCount': null,
    },
    {
      'imageUrl':
          'https://plus.unsplash.com/premium_photo-1723683613486-a15861aa678a?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NDl8fGJsYWNrJTIwcGVvcGxlfGVufDB8fDB8fHww',
      'name': 'Kristin Watson',
      'message': 'Lorem ipsum dolor sit amet, consequen...',
      'isOnline': false,
      'time': '01:45',
      'unreadCount': '2',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1504199367641-aba8151af406?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NjZ8fGJsYWNrJTIwcGVvcGxlfGVufDB8fDB8fHww',
      'name': 'Dianne Russell',
      'message': 'Lorem ipsum dolor sit amet, consequen...',
      'isOnline': true,
      'time': '01:15',
      'unreadCount': '2',
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1507152927179-bc4ebfef7103?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NzB8fGJsYWNrJTIwcGVvcGxlfGVufDB8fDB8fHww',
      'name': 'Annette Black',
      'message': 'Lorem ipsum dolor sit amet, consequen...',
      'isOnline': false,
      'time': '01:10',
      'unreadCount': null,
    },
    {
      'imageUrl':
          'https://images.unsplash.com/photo-1502764613149-7f1d229e230f?w=600&auto=format&fit=crop&q=60&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8ODR8fGJsYWNrJTIwcGVvcGxlfGVufDB8fDB8fHww',
      'name': 'Ralph Edwards',
      'message': 'Lorem ipsum dolor sit amet, consequen...',
      'isOnline': true,
      'time': '12:15',
      'unreadCount': null,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // 1. Calculate total unread messages
    final totalUnread = messages.fold<int>(0, (sum, msg) {
      final countStr = msg['unreadCount'] as String?;
      if (countStr != null && countStr.isNotEmpty) {
        return sum + (int.tryParse(countStr) ?? 0);
      }
      return sum;
    });

    return AppScaffold(
      body: Column(
        children: [
          //   fixed Header
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      AppText(
                        'Messages',
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.kGrey80,
                        ),
                      ),
                      // 2. Display the dynamic total unread count
                      if (totalUnread > 0) ...[
                        8.horizontalSpacing,
                        _buildBadgeText(context, totalUnread.toString()),
                      ],
                    ],
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.kGray30),
                    ),
                    child: const Center(
                      child: Icon(FontAwesomeIcons.plus),
                    ),
                  ),
                ],
              ),
              24.verticalSpacing,
              const AppTextField(
                hintText: 'search',
                prefixIcon: Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: AppIconSize.regular,
                ),
              ),
            ],
          ),

          16.verticalSpacing,

          //   Scrollable List
          Expanded(
            child: ListView.separated(
              itemCount: messages.length,
              separatorBuilder: (context, index) => 16.verticalSpacing,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessageCard(
                  context,
                  message['imageUrl'] as String,
                  message['name'] as String,
                  message['message'] as String,
                  time: message['time'] as String,
                  unreadCount: message['unreadCount'] as String?,
                  isOnline: message['isOnline'] as bool,
                  () => context.push(MessageViewRoute.path),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadgeText(BuildContext context, String unreadMessages) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      constraints: const BoxConstraints(
        minWidth: 20,
        minHeight: 20,
      ),
      decoration: BoxDecoration(
        color: AppColors.kBrand5,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Center(
        widthFactor: 1,
        heightFactor: 1,
        child: AppText(
          unreadMessages,
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.kPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageCard(
    BuildContext context,
    String imageUrl,
    String name,
    String message,
    VoidCallback? onTap, {
    required String time,
    required String? unreadCount,
    required bool isOnline,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          //   image with indicator
          Stack(
            children: [
              ClipOval(
                child: Image.network(
                  imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 2,
                bottom: 2,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color: isOnline ? AppColors.kSuccess50 : AppColors.kGrey30,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.kWhite,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),

          16.horizontalSpacing,

          //   landlord's name and message
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  name,
                  style: context.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.kGray50,
                  ),
                ),
                4.verticalSpacing,
                AppText(
                  message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColors.kGray30,
                  ),
                ),
              ],
            ),
          ),

          //   time and unread messages
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AppText(
                time,
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.kGray30,
                ),
              ),
              8.verticalSpacing,
              // Show badge only if count is not null and not empty
              if (unreadCount != null &&
                  unreadCount.isNotEmpty &&
                  unreadCount != '0')
                _buildBadgeText(context, unreadCount),
            ],
          ),
        ],
      ),
    );
  }
}
