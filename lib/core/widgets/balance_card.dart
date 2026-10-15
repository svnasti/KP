import 'package:flutter/material.dart';
import 'package:shared_expenses_manager/core/theme/app_colors.dart';
import 'package:shared_expenses_manager/core/utils/formatters.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key, required this.label, required this.amount});

  final String label;
  final int amount;

  @override
  Widget build(BuildContext context) {
    final isNegative = amount < 0;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isNegative ? AppColors.negativeLight : AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodySmall
                ?.copyWith(color: AppColors.textGray),
          ),
          Text(
            formatAmount(amount, withSign: true),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: isNegative ? AppColors.negative : AppColors.positive,
            ),
          ),
        ],
      ),
    );
  }
}
