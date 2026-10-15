import 'package:flutter/material.dart';
import 'package:shared_expenses_manager/core/theme/app_colors.dart';
import 'package:shared_expenses_manager/core/theme/app_theme.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.destructive = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool destructive;

  @override
  Widget build(BuildContext context) {
    final color = destructive ? AppColors.negative : AppColors.primary;
    final style = OutlinedButton.styleFrom(
      minimumSize: const Size.fromHeight(48),
      shape: const StadiumBorder(),
      foregroundColor: color,
      side: BorderSide(color: color, width: 1.5),
      textStyle: buttonTextStyle(context),
    );

    if (icon == null) {
      return OutlinedButton(
        style: style,
        onPressed: onPressed,
        child: Text(label),
      );
    }
    return OutlinedButton.icon(
      style: style,
      onPressed: onPressed,
      icon: Icon(icon, size: 20),
      label: Text(label),
    );
  }
}
