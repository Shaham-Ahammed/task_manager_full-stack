import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/app_colors.dart';

class AppTextStyles {
  static const TextTheme textTheme = TextTheme(
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
    titleMedium:   TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.white,
    ),
    bodyMedium: TextStyle(fontSize: 16, color: AppColors.textColor),
  );
}
