import 'package:flutter/material.dart';
import 'package:shared_expenses_manager/core/theme/app_colors.dart';

class ScreenHeading extends StatelessWidget {
  const ScreenHeading({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text(
          title,
          style: textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.textDark,
          ),
        ),
        if (subtitle != null)
          Text(
            subtitle!,
            style: textTheme.bodyMedium?.copyWith(color: AppColors.textGray),
          ),
      ],
    );
  }
}
