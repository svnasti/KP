import 'package:flutter/material.dart';
import 'package:shared_expenses_manager/core/theme/app_colors.dart';
import 'package:shared_expenses_manager/core/theme/app_spacing.dart';
import 'package:shared_expenses_manager/core/widgets/widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  List<Widget> _buildForm() {
    return [
      Text(
        'Введіть email, і ми надішлемо посилання для відновлення паролю',
        style: Theme.of(context).textTheme.bodyMedium
            ?.copyWith(color: AppColors.textGray),
      ),
      AppTextField(
        label: 'Email',
        hint: 'you@example.com',
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
      ),
      PrimaryButton(
        label: 'Надіслати посилання',
        onPressed: () => setState(() => _sent = true),
      ),
    ];
  }

  List<Widget> _buildConfirmation() {
    final email = _emailController.text.trim();
    final target = email.isEmpty ? 'вказану адресу' : email;
    return [
      const SizedBox(height: AppSpacing.large),
      const Icon(
        Icons.mark_email_read_outlined,
        size: 72,
        color: AppColors.primary,
      ),
      Text(
        'Перевірте пошту',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineSmall
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
      Text(
        'Ми надіслали посилання для відновлення паролю на $target',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyMedium
            ?.copyWith(color: AppColors.textGray),
      ),
      PrimaryButton(
        label: 'Повернутися до входу',
        onPressed: () => Navigator.of(context).pop(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Відновлення паролю')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: CenteredContent(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 18,
              children: _sent ? _buildConfirmation() : _buildForm(),
            ),
          ),
        ),
      ),
    );
  }
}
