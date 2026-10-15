import 'package:flutter/material.dart';
import 'package:shared_expenses_manager/core/theme/app_spacing.dart';
import 'package:shared_expenses_manager/core/utils/snackbars.dart';
import 'package:shared_expenses_manager/core/widgets/widgets.dart';
import 'package:shared_expenses_manager/features/auth/forgot_password_screen.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  void _save(BuildContext context) {
    Navigator.of(context).pop();
    showMessage(context, 'Пароль змінено');
  }

  void _openForgotPassword(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const ForgotPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Зміна пароля')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: CenteredContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 18,
              children: [
                const AppPasswordField(
                  label: 'Поточний пароль',
                  hint: 'Введіть поточний пароль',
                  textInputAction: TextInputAction.next,
                ),
                const AppPasswordField(
                  label: 'Новий пароль',
                  hint: 'Мінімум 8 символів',
                  textInputAction: TextInputAction.next,
                ),
                const AppPasswordField(
                  label: 'Підтвердіть новий пароль',
                  hint: 'Повторіть новий пароль',
                ),
                PrimaryButton(
                  label: 'Зберегти пароль',
                  onPressed: () => _save(context),
                ),
                Center(
                  child: TextButton(
                    onPressed: () => _openForgotPassword(context),
                    child: const Text('Забули поточний пароль?'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
