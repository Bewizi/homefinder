import 'package:flutter/material.dart';
import 'package:homefinder/core/ui/components/app_text.dart';
import 'package:homefinder/core/variables/app_radius.dart';
import 'package:homefinder/core/variables/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
    this.text, {
    this.disabled = true,
    this.loading = false,
    this.pressed,
    this.color,
    super.key,
  });

  final bool disabled;
  final bool loading;
  final VoidCallback? pressed;
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressed,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: color ?? AppColors.kPrimary,
          borderRadius: BorderRadius.circular(AppRadius.medium),
        ),
        child: AppText(
          text,
          style: Theme.of(
            context,
          ).textTheme.titleSmall?.copyWith(color: AppColors.kWhite),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class OutlineButton extends StatelessWidget {
  const OutlineButton({
    this.disabled = true,
    this.loading = false,
    this.pressed,
    this.text,
    this.bgColor,
    this.textColor,
    this.borderColor,
    super.key,
  });

  final bool disabled;
  final bool loading;
  final VoidCallback? pressed;
  final String? text;
  final Color? bgColor;
  final Color? textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: pressed,
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.kBrand5,
          borderRadius: BorderRadius.circular(AppRadius.lager),
          border: Border.all(color: borderColor ?? AppColors.kPrimary),
        ),
        child: Text(text ?? ''),
      ),
    );
  }
}

// GhostButton
//
// IconButton
//
// LoadingButton
