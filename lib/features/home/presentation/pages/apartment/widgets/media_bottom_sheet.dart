import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_button.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';
import 'package:homefinder/features/home/domain/homes_domain.dart';

class MediaBottomSheet extends StatefulWidget {
  final HomesDomain apartment;
  final int initialIndex;

  const MediaBottomSheet({
    super.key,
    required this.apartment,
    this.initialIndex = 0,
  });

  @override
  State<MediaBottomSheet> createState() => _MediaBottomSheetState();
}

class _MediaBottomSheetState extends State<MediaBottomSheet>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: widget.initialIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.9,
      decoration: const BoxDecoration(
        color: AppColors.kWhite,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.lager * 2),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  widget.apartment.name,
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            labelColor: AppColors.kPrimary,
            unselectedLabelColor: AppColors.kGrey30,
            indicatorColor: AppColors.kPrimary,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: 'Picture'),
              Tab(text: 'Videos'),
              Tab(text: 'Location Map'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMediaList(
                  widget.apartment.images,
                  ['Exterior-Front View', 'Interior -Sitting Room', 'Bedroom'],
                  false,
                ),
                _buildMediaList(
                  widget.apartment.images,
                  ['Interior', 'Exterior'],
                  true,
                ),
                const Center(child: AppText('Location Map View')),
              ],
            ),
          ),
          _buildBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildMediaList(
    List<String> images,
    List<String> captions,
    bool isVideo,
  ) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: captions.length,
      separatorBuilder: (context, index) => 24.verticalSpacing,
      itemBuilder: (context, index) {
        final image = images[index % images.length];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.small),
                  child: Image.asset(
                    image,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                if (isVideo)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.kWhite,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: AppColors.kBlack,
                    ),
                  ),
              ],
            ),
            8.verticalSpacing,
            AppText(
              captions[index],
              style: context.textTheme.bodyMedium?.copyWith(
                color: AppColors.kGrey40,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.kWhite,
        boxShadow: [
          BoxShadow(
            color: AppColors.kBlack.withValues(alpha: 0.05),
            offset: const Offset(0, -4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AppRichText(
            spans: [
              TextSpan(
                text: '#${widget.apartment.price_per_month}',
                style: context.textTheme.headlineSmall?.copyWith(
                  color: AppColors.kPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: '/year',
                style: context.textTheme.bodySmall?.copyWith(
                  color: AppColors.kGrey30,
                ),
              ),
            ],
          ),
          PrimaryButton(
            width: MediaQuery.sizeOf(context).width * 0.3,
            'Message',
            pressed: () {},
            color: AppColors.kPrimary,
            textColor: AppColors.kWhite,
          ),
        ],
      ),
    );
  }
}
