import 'package:flutter/material.dart';
import 'package:shared_expenses_manager/core/theme/app_colors.dart';
import 'package:shared_expenses_manager/core/theme/app_theme.dart';

class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({super.key, required this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12,
      children: [
        Expanded(
          child: _SocialButton(
            label: 'Google',
            letter: 'G',
            color: const Color(0xFF4285F4),
            onPressed: onPressed,
          ),
        ),
        Expanded(
          child: _SocialButton(
            label: 'Apple',
            letter: 'A',
            color: AppColors.textDark,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.letter,
    required this.color,
    required this.onPressed,
  });

  final String label;
  final String letter;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: const StadiumBorder(),
        foregroundColor: AppColors.textDark,
        side: const BorderSide(color: AppColors.border),
        textStyle: buttonTextStyle(context),
      ),
      icon: Container(
        width: 24,
        height: 24,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Text(
          letter,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      label: Text(label),
    );
  }
}
