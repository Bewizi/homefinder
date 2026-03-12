import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/extensions/app_spacing_extension.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/colors.dart';
import 'package:intl/intl.dart';

class PriceRange extends StatefulWidget {
  const PriceRange({super.key});

  @override
  State<PriceRange> createState() => _PriceRangeState();
}

class _PriceRangeState extends State<PriceRange> {
  RangeValues _currentRangeValues = const RangeValues(100000, 10000000);
  final currencyFormat = NumberFormat.currency(symbol: '₦', decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(
          'Price Range',
          style: context.textTheme.bodySmall?.copyWith(
            color: AppColors.kGray50,
            fontWeight: FontWeight.w600,
          ),
        ),
        16.verticalSpacing,
        RangeSlider(
          values: _currentRangeValues,
          min: 0,
          max: 20000000,
          divisions: 100,
          activeColor: AppColors.kPrimary,
          inactiveColor: AppColors.kBrand5,
          labels: RangeLabels(
            currencyFormat.format(_currentRangeValues.start),
            currencyFormat.format(_currentRangeValues.end),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _currentRangeValues = values;
            });
          },
        ),
        16.verticalSpacing,
        Row(
          children: [
            Expanded(
              child: _PriceInputField(
                value: currencyFormat.format(_currentRangeValues.start),
              ),
            ),
            16.horizontalSpacing,
            Expanded(
              child: _PriceInputField(
                value: currencyFormat.format(_currentRangeValues.end),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PriceInputField extends StatelessWidget {
  const _PriceInputField({required this.value});
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.kGrey5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: AppText(
        value,
        style: context.textTheme.bodyMedium?.copyWith(
          color: AppColors.kGrey30,
        ),
      ),
    );
  }
}

// amenities.dart
// -50 +57
// price_range.dart
// +90
