import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_expenses_manager/core/data/mock_data.dart';
import 'package:shared_expenses_manager/core/theme/app_colors.dart';
import 'package:shared_expenses_manager/core/theme/app_spacing.dart';
import 'package:shared_expenses_manager/core/utils/snackbars.dart';
import 'package:shared_expenses_manager/core/widgets/widgets.dart';
import 'package:shared_expenses_manager/features/auth/login_screen.dart';
import 'package:shared_expenses_manager/features/profile/change_password_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController(text: MockData.userName);
  final _emailController = TextEditingController(text: MockData.userEmail);
  final _paymentController = TextEditingController(
    text: MockData.paymentDetails,
  );

  bool _pushEnabled = true;
  bool _expenseAlertsEnabled = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _paymentController.dispose();
    super.dispose();
  }

  Future<void> _copyPaymentDetails() async {
    await Clipboard.setData(ClipboardData(text: _paymentController.text));
    if (!mounted) return;
    showMessage(context, 'Реквізити скопійовано');
  }

  void _openChangePassword() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const ChangePasswordScreen()),
    );
  }

  Future<void> _confirmLogout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Вийти з акаунта?'),
        content: const Text('Ви зможете увійти знову за email та паролем.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Скасувати'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Вийти'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
      (route) => false,
    );
  }

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: Theme.of(context).textTheme.titleMedium
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildSettingsCard() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            ListTile(
              title: const Text(
                'Валюта за замовчуванням',
                style: TextStyle(fontSize: 15),
              ),
              trailing: const Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: [
                  Text('UAH', style: TextStyle(color: AppColors.textGray)),
                  Icon(Icons.chevron_right, color: AppColors.textGray),
                ],
              ),
              onTap: () => showComingSoon(context),
            ),
            const Divider(height: 1),
            SwitchListTile(
              title: const Text(
                'Push-сповіщення',
                style: TextStyle(fontSize: 15),
              ),
              value: _pushEnabled,
              onChanged: (value) => setState(() => _pushEnabled = value),
            ),
            const Divider(height: 1),
            SwitchListTile(
              title: const Text(
                'Сповіщення про нові витрати',
                style: TextStyle(fontSize: 15),
              ),
              value: _expenseAlertsEnabled,
              onChanged: (value) =>
                  setState(() => _expenseAlertsEnabled = value),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профіль')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.medium),
          child: CenteredContent(
            maxWidth: 480,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 18,
              children: [
                Column(
                  spacing: 8,
                  children: [
                    const UserAvatar(initials: MockData.userInitials, size: 96),
                    TextButton(
                      onPressed: () => showComingSoon(context),
                      child: const Text('Змінити фото'),
                    ),
                  ],
                ),
                AppTextField(label: 'Ім’я', controller: _nameController),
                AppTextField(
                  label: 'Email',
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                _sectionTitle('Платіжні реквізити'),
                AppTextField(
                  label: 'Номер картки або посилання на банку',
                  controller: _paymentController,
                  suffixIcon: IconButton(
                    tooltip: 'Копіювати',
                    icon: const Icon(
                      Icons.copy_outlined,
                      color: AppColors.primary,
                    ),
                    onPressed: _copyPaymentDetails,
                  ),
                ),
                Text(
                  'Інші учасники зможуть скопіювати ці реквізити, щоб швидко повернути вам кошти',
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: AppColors.textGray),
                ),
                _sectionTitle('Налаштування'),
                _buildSettingsCard(),
                SecondaryButton(
                  label: 'Змінити пароль',
                  onPressed: _openChangePassword,
                ),
                SecondaryButton(
                  label: 'Вийти з акаунта',
                  icon: Icons.logout,
                  destructive: true,
                  onPressed: _confirmLogout,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
