import 'package:flutter/material.dart';
import 'package:shared_expenses_manager/core/theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: FilledButton.styleFrom(textStyle: buttonTextStyle(context)),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
