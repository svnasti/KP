import 'package:flutter/material.dart';
import 'package:shared_expenses_manager/core/models/group.dart';
import 'package:shared_expenses_manager/core/theme/app_colors.dart';
import 'package:shared_expenses_manager/core/utils/formatters.dart';

class GroupListItem extends StatelessWidget {
  const GroupListItem({super.key, required this.group, this.onTap});

  final Group group;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final balanceColor = group.balance < 0
        ? AppColors.negative
        : AppColors.positive;
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      leading: const CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.primaryLight,
        child: Icon(Icons.groups_outlined, color: AppColors.primary, size: 22),
      ),
      title: Text(
        group.name,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(membersLabel(group.members)),
      trailing: Text(
        formatAmount(group.balance, withSign: true),
        style: TextStyle(color: balanceColor, fontWeight: FontWeight.w500),
      ),
    );
  }
}
