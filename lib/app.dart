import 'package:flutter/material.dart';
import 'package:shared_expenses_manager/core/theme/app_theme.dart';
import 'package:shared_expenses_manager/features/auth/login_screen.dart';

class SharedExpensesApp extends StatelessWidget {
  const SharedExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Менеджер спільних витрат',
      theme: buildAppTheme(),
      home: const LoginScreen(),
    );
  }
}
