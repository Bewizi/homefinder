import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/components/layouts/app_scaffold.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/colors.dart';
import 'package:homefinder/features/home/data/homes_data.dart';
import 'package:homefinder/features/home/domain/homes_domain.dart';

class ApartmentView extends StatefulWidget {
  final String id;
  const ApartmentView({super.key, required this.id});

  @override
  State<ApartmentView> createState() => _ApartmentViewState();
}

class _ApartmentViewState extends State<ApartmentView> {
  HomesDomain? apartment;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadApartment();
  }

  Future<void> _loadApartment() async {
    final homes = await HomesData().getAllHomes();
    setState(() {
      apartment = homes.firstWhere((e) => e.id == widget.id);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const AppScaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (apartment == null) {
      return const AppScaffold(
        body: Center(child: AppText('Apartment not found')),
      );
    }

    return AppScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Image with Overlays
            Stack(
              children: [
                Image.asset(
                  apartment!.image,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                const Positioned(
                  top: 40,
                  right: 20,
                  child: Row(
                    children: [
                      Icon(Icons.share, color: Colors.white),
                      SizedBox(width: 16),
                      Icon(Icons.favorite_border, color: Colors.white),
                    ],
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Type and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.kPrimary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: AppText(
                          apartment!.type,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: AppColors.kPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 18,
                          ),
                          const SizedBox(width: 4),
                          AppText(
                            '${apartment!.rating}/5.0',
                            style: context.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Name and Location
                  AppText(
                    apartment!.name,
                    style: context.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      AppText(
                        apartment!.location,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Stats (Beds, Baths, Sqft)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStat(Icons.bed, '${apartment!.beds} Bedrooms'),
                      _buildStat(Icons.bathtub, '${apartment!.baths} Baths'),
                      _buildStat(Icons.square_foot, '${apartment!.sqft} sqft'),
                    ],
                  ),

                  const SizedBox(height: 24),
                  AppText(
                    'Details',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    'A beautiful, modern apartment in the heart of downtown. Recently renovated with high-end finishes and appliances. Featuring an open floor plan, large windows providing plenty of natural light, and a spacious balcony with city views. Building amenities include a fitness center, rooftop lounge, and 24-hour concierge service.',
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),
                  AppText(
                    'Amenities',
                    style: context.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildAmenity('Elevator'),
                      _buildAmenity('Doorman'),
                      _buildAmenity('Garage'),
                      _buildAmenity('Air Conditioning'),
                      _buildAmenity('Gym'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.kGrey80),
        const SizedBox(width: 4),
        AppText(
          text,
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.kGrey80,
          ),
        ),
      ],
    );
  }

  Widget _buildAmenity(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: AppText(
        label,
        style: context.textTheme.bodySmall,
      ),
    );
  }
}
