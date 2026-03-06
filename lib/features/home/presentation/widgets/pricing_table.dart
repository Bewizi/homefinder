import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/ui/extensions/app_theme_extension.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';

class PricingTable extends StatelessWidget {
  const PricingTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.kGrey5),
        borderRadius: BorderRadius.circular(AppRadius.medium),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.medium),
        child: Table(
          border: const TableBorder.symmetric(
            inside: BorderSide(color: AppColors.kGrey5),
          ),
          columnWidths: const {
            0: FlexColumnWidth(1.2),
            1: FlexColumnWidth(1.5),
            2: FlexColumnWidth(1.1),
          },
          children: [
            _buildRow(context, [
              'Item',
              'Description',
              'Amount',
            ], isHeader: true),
            _buildRow(context, ['Annual Rent', 'Base rent', '₦2,850,000']),
            _buildRow(context, ['Legal Agreement', '5% of rent', '₦162,500']),
            _buildRow(context, [
              'Caution Fee',
              'Refundable deposit',
              '₦75,000',
            ]),
            _buildRow(context, [
              'Service Charge',
              'Covers maintenance',
              '₦162,500',
            ]),
          ],
        ),
      ),
    );
  }

  TableRow _buildRow(
    BuildContext context,
    List<String> cells, {
    bool isHeader = false,
  }) {
    return TableRow(
      children: cells
          .map(
            (text) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: AppText(
                text,
                style: context.textTheme.bodySmall?.copyWith(
                  fontWeight: isHeader ? FontWeight.w600 : FontWeight.w400,
                  color: isHeader ? AppColors.kGrey80 : AppColors.kGrey40,
                  fontSize: 12,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
