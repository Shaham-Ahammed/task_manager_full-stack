import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final bool? required;
  const AppTextField({
    super.key,
    required this.controller,
    this.required = true,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autovalidateMode: AutovalidateMode.onUnfocus,
      validator: (value) {
        if (required == true) {
          if (value == null || value.trim().isEmpty) {
            return 'this field is required';
          }
          return null;
        }
        return null;
      },
      controller: controller,
      style: TextStyle(fontWeight: FontWeight.normal, color: AppColors.white),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.cyan),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.cyan),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.cyan.shade200),
        ),
        labelText: title,
        labelStyle: TextStyle(
          fontWeight: FontWeight.w500,
          color: AppColors.white,
        ),
      ),
    );
  }
}
