import 'package:flutter/material.dart';

class AppColors {
  static const Color bg = Color(0xFFF1F5F9);
  static const Color white = Colors.white;
  static const Color bluePrimary = Color(0xFF2563EB);
  static const Color blueDark = Color(0xFF1E40AF);
  static const Color blueLight = Color(0xFFDBEAFE);
  static const Color textMain = Color(0xFF0F172A);
  static const Color textSub = Color(0xFF64748B);
}

final ThemeData appTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: AppColors.bg,
  fontFamily: 'Segoe UI',
  useMaterial3: true,
);

extension ThemeContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
}
