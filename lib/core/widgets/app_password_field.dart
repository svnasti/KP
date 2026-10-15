import 'package:flutter/material.dart';
import 'package:shared_expenses_manager/core/widgets/app_text_field.dart';

class AppPasswordField extends StatefulWidget {
  const AppPasswordField({
    super.key,
    this.label = 'Пароль',
    this.hint,
    this.controller,
    this.textInputAction,
  });

  final String label;
  final String? hint;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  @override
  State<AppPasswordField> createState() => _AppPasswordFieldState();
}

class _AppPasswordFieldState extends State<AppPasswordField> {
  bool _obscured = true;

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: widget.label,
      hint: widget.hint,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      obscureText: _obscured,
      suffixIcon: IconButton(
        tooltip: _obscured ? 'Показати пароль' : 'Сховати пароль',
        icon: Icon(
          _obscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        ),
        onPressed: () => setState(() => _obscured = !_obscured),
      ),
    );
  }
}
