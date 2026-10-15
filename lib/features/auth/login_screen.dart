import 'package:flutter/material.dart';
import 'package:shared_expenses_manager/core/theme/app_spacing.dart';
import 'package:shared_expenses_manager/core/widgets/widgets.dart';
import 'package:shared_expenses_manager/features/auth/forgot_password_screen.dart';
import 'package:shared_expenses_manager/features/auth/register_screen.dart';
import 'package:shared_expenses_manager/features/main/main_shell.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _openHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const MainShell()),
      (route) => false,
    );
  }

  void _openForgotPassword(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const ForgotPasswordScreen()),
    );
  }

  void _openRegister(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (_) => const RegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: CenteredContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 18,
              children: [
                const SizedBox(height: AppSpacing.large),
                const ScreenHeading(
                  title: 'Вхід',
                  subtitle: 'Увійдіть, щоб побачити свої групи витрат',
                ),
                const AppTextField(
                  label: 'Email',
                  hint: 'you@example.com',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const AppPasswordField(hint: 'Введіть пароль'),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _openForgotPassword(context),
                    child: const Text('Забули пароль?'),
                  ),
                ),
                PrimaryButton(
                  label: 'Увійти',
                  onPressed: () => _openHome(context),
                ),
                const LabeledDivider(label: 'або продовжити з'),
                SocialLoginRow(onPressed: () => _openHome(context)),
                Center(
                  child: TextButton(
                    onPressed: () => _openRegister(context),
                    child: const Text('Немає акаунту? Зареєструватися'),
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
