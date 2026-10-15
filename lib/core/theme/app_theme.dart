import 'package:flutter/material.dart';
import 'package:shared_expenses_manager/core/theme/app_colors.dart';

OutlineInputBorder _inputBorder(Color color, {double width = 1}) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: color, width: width),
  );
}

TextStyle? buttonTextStyle(BuildContext context) {
  return Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 16);
}

ThemeData buildAppTheme() {
  final colorScheme = ColorScheme.fromSeed(seedColor: AppColors.primary)
      .copyWith(primary: AppColors.primary, onPrimary: Colors.white);
  final base = ThemeData(useMaterial3: true, colorScheme: colorScheme);

  return base.copyWith(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarThemeData(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.textDark,
      elevation: 0,
      scrolledUnderElevation: 1,
      titleTextStyle: base.textTheme.titleLarge?.copyWith(
        color: AppColors.textDark,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
    ),
    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: Colors.white,
      hintStyle: const TextStyle(color: AppColors.textGray),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: _inputBorder(AppColors.border),
      enabledBorder: _inputBorder(AppColors.border),
      focusedBorder: _inputBorder(AppColors.primary, width: 1.5),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: const StadiumBorder(),
      ),
    ),
    navigationBarTheme: const NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: AppColors.primaryLight,
    ),
  );
}
