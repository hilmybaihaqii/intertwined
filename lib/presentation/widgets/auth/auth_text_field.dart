// lib/presentation/widgets/auth/auth_text_field.dart

import 'package:flutter/material.dart';
import 'package:intertwined/core/constants/app_colors.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final double fontSize;
  final bool isPassword;
  final bool isPasswordHidden;
  final VoidCallback? onToggleVisibility;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;

  const AuthTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.fontSize,
    this.isPassword = false,
    this.isPasswordHidden = false,
    this.onToggleVisibility,
    this.validator,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    // Style untuk border
    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.deepBrown.withAlpha(100),
        width: 1.5,
      ),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: AppColors.deepBrown,
        width: 2.0,
      ),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: Colors.redAccent.withAlpha(179),
        width: 1.5,
      ),
    );

    return Material(
      elevation: 1.5,
      shadowColor: AppColors.deepBrown.withAlpha(50),
      borderRadius: BorderRadius.circular(12),
      color: AppColors.creamyWhite,
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && isPasswordHidden,
        style: TextStyle(fontSize: fontSize, color: AppColors.deepBrown),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: AppColors.deepBrown.withAlpha(128),
            fontSize: fontSize,
          ),
          filled: true,
          fillColor: AppColors.creamyWhite,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isPasswordHidden
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.deepBrown.withAlpha(179),
                  ),
                  onPressed: onToggleVisibility,
                )
              : null,
          border: defaultBorder,
          enabledBorder: defaultBorder,
          focusedBorder: focusedBorder,
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
          // --- PERUBAHAN DI SINI ---
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 20.0,
          ),
        ),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }
}
