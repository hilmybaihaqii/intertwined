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
  final IconData? prefixIcon;

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
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(16);

    final outlineBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(
        color: AppColors.deepBrown.withValues(alpha: 0.1),
        width: 1.0,
      ),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: const BorderSide(color: AppColors.deepBrown, width: 1.5),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: borderRadius,
      borderSide: BorderSide(
        color: Colors.redAccent.withValues(alpha: 0.8),
        width: 1.0,
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: AppColors.deepBrown.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && isPasswordHidden,
        keyboardType: keyboardType,
        style: TextStyle(
          fontSize: fontSize,
          color: AppColors.deepBrown,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: AppColors.deepBrown,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.lightGrey,
          hintText: hintText,
          hintStyle: TextStyle(
            // GANTI: withOpacity -> withValues
            color: AppColors.deepBrown.withValues(alpha: 0.4),
            fontSize: fontSize,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18.0,
            horizontal: 20.0,
          ),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(left: 16, right: 10),
                  child: Icon(
                    prefixIcon,
                    color: AppColors.deepBrown.withValues(alpha: 0.6),
                    size: 22,
                  ),
                )
              : null,
          suffixIcon: isPassword
              ? Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: IconButton(
                    icon: Icon(
                      isPasswordHidden
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.deepBrown.withValues(alpha: 0.5),
                      size: 22,
                    ),
                    onPressed: onToggleVisibility,
                  ),
                )
              : null,
          border: outlineBorder,
          enabledBorder: outlineBorder,
          focusedBorder: focusedBorder,
          errorBorder: errorBorder,
          focusedErrorBorder: errorBorder,
        ),
        validator: validator,
      ),
    );
  }
}
