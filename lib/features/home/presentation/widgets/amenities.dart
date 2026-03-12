import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/colors.dart';

class Amenities extends StatefulWidget {
  const Amenities({super.key});

  @override
  State<Amenities> createState() => _AmenitiesState();
}

class _AmenitiesState extends State<Amenities> {
  final List<String> amenitiesList = [
    'Air Conditioning',
    'Unit Laundry',
    'Gym',
    'Elevator',
    'Doorman',
    'Garage',
    'Dishwasher',
    'Hardwood Floors',
  ];

  final Set<String> selectedAmenities = {
    'Air Conditioning',
    'Garage',
    'Dishwasher',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Amenities',
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.kGray50,
            fontWeight: FontWeight.w600,
          ),
        ),
        8.verticalSpacing,
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4,
            crossAxisSpacing: 8,
            mainAxisSpacing: 4,
          ),
          itemCount: amenitiesList.length,
          itemBuilder: (context, index) {
            final amenity = amenitiesList[index];
            final isSelected = selectedAmenities.contains(amenity);
            return Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value ?? false) {
                          selectedAmenities.add(amenity);
                        } else {
                          selectedAmenities.remove(amenity);
                        }
                      });
                    },
                    checkColor: AppColors.kPrimary,
                    activeColor: AppColors.kBrand5,

                    side: const BorderSide(color: AppColors.kGrey5, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                8.horizontalSpacing,
                Expanded(
                  child: AppText(
                    amenity,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: AppColors.kGrey30,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
