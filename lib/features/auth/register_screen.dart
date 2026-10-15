import 'package:flutter/material.dart';
import 'package:shared_expenses_manager/core/theme/app_colors.dart';
import 'package:shared_expenses_manager/core/theme/app_spacing.dart';
import 'package:shared_expenses_manager/core/widgets/widgets.dart';
import 'package:shared_expenses_manager/features/main/main_shell.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _agreed = false;

  void _register() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const MainShell()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final onRegister = _agreed ? _register : null;
    final smallGray = Theme.of(context).textTheme.bodySmall
        ?.copyWith(color: AppColors.textGray);
    final link = smallGray?.copyWith(color: AppColors.primary);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: CenteredContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 18,
              children: [
                const SizedBox(height: AppSpacing.normal),
                const ScreenHeading(
                  title: 'Реєстрація',
                  subtitle: 'Створіть обліковий запис, щоб почати ділити витрати з друзями',
                ),
                const AppTextField(
                  label: 'Ім’я',
                  hint: 'Введіть ваше ім’я',
                  textInputAction: TextInputAction.next,
                ),
                const AppTextField(
                  label: 'Email',
                  hint: 'you@example.com',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                ),
                const AppPasswordField(hint: 'Мінімум 8 символів'),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: _agreed,
                      onChanged: (value) =>
                          setState(() => _agreed = value ?? false),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text.rich(
                          TextSpan(
                            style: smallGray,
                            children: [
                              const TextSpan(text: 'Я погоджуюсь з '),
                              TextSpan(
                                text: 'Правилами користування',
                                style: link,
                              ),
                              const TextSpan(text: ' та '),
                              TextSpan(
                                text: 'Політикою конфіденційності',
                                style: link,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                PrimaryButton(label: 'Зареєструватися', onPressed: onRegister),
                const LabeledDivider(label: 'або продовжити з'),
                SocialLoginRow(onPressed: onRegister),
                Center(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Вже маєте акаунт? Увійти'),
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
