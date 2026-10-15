import 'package:flutter/material.dart';
import 'package:shared_expenses_manager/core/models/expense.dart';
import 'package:shared_expenses_manager/core/theme/app_colors.dart';
import 'package:shared_expenses_manager/core/utils/formatters.dart';

class ExpenseListItem extends StatelessWidget {
  const ExpenseListItem({super.key, required this.expense});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        radius: 20,
        backgroundColor: Colors.white,
        child: Icon(
          Icons.receipt_long_outlined,
          color: AppColors.textGray,
          size: 20,
        ),
      ),
      title: Text(
        expense.title,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(expense.subtitle),
      trailing: Text(
        formatAmount(expense.amount),
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }
}
