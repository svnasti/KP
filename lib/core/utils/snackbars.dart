import 'package:flutter/material.dart';

void showMessage(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}

void showComingSoon(BuildContext context) {
  showMessage(
    context,
    'Ця функція буде реалізована в наступних лабораторних роботах',
  );
}
