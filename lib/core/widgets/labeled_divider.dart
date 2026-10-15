import 'package:flutter/material.dart';
import 'package:shared_expenses_manager/core/theme/app_colors.dart';

class LabeledDivider extends StatelessWidget {
  const LabeledDivider({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        const Expanded(child: Divider()),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall
              ?.copyWith(color: AppColors.textGray),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}
