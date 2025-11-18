// lib/presentation/widgets/auth/register_form_content.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intertwined/core/constants/app_colors.dart';
import '../../widgets/auth/auth_text_field.dart';

class RegisterFormContent extends StatelessWidget {
  final double scaleFactor;
  final double screenHeight;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isLoading;
  final bool isPasswordHidden;
  final VoidCallback onRegister;
  final VoidCallback onTogglePasswordVisibility;

  const RegisterFormContent({
    super.key,
    required this.scaleFactor,
    required this.screenHeight,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.isLoading,
    required this.isPasswordHidden,
    required this.onRegister, // Baru
    required this.onTogglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    final double titleFontSize = 28.0 * scaleFactor;
    final double subTitleFontSize = 15.0 * scaleFactor;
    final double buttonHeight = 50.0 * scaleFactor;
    final double generalTextSize = 14.0 * scaleFactor;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: screenHeight * 0.1),
          Text(
            'Create New Account',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.deepBrown,
              height: 1.2,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            'Please register your account to start',
            style: TextStyle(
              fontSize: subTitleFontSize,
              color: AppColors.deepBrown.withAlpha(200),
            ),
          ),
          SizedBox(height: screenHeight * 0.04),

          // Email Field
          AuthTextField(
            controller: emailController,
            hintText: 'Email',
            fontSize: generalTextSize,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty || !value.contains('@')) {
                return 'Masukkan email yang valid.';
              }
              return null;
            },
          ),
          SizedBox(height: screenHeight * 0.015),

          // Password Field
          AuthTextField(
            controller: passwordController,
            hintText: 'Password',
            fontSize: generalTextSize,
            isPassword: true,
            isPasswordHidden: isPasswordHidden,
            onToggleVisibility: onTogglePasswordVisibility,
            validator: (value) {
              if (value == null || value.length < 6) {
                return 'Password minimal 6 karakter.';
              }
              return null;
            },
          ),
          SizedBox(height: screenHeight * 0.015),

          // Confirm Password Field
          AuthTextField(
            controller: confirmPasswordController,
            hintText: 'Konfirmasi Password',
            fontSize: generalTextSize,
            isPassword: true,
            isPasswordHidden: isPasswordHidden,
            onToggleVisibility: onTogglePasswordVisibility,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Konfirmasi password wajib diisi.';
              }
              if (value != passwordController.text) {
                return 'Password tidak cocok.';
              }
              return null;
            },
          ),
          SizedBox(height: screenHeight * 0.04),

          // Register Button
          _buildRegisterButton(buttonHeight, generalTextSize),
          SizedBox(height: screenHeight * 0.03),

          // Login Link
          _buildLoginLink(context, generalTextSize),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }

  Widget _buildRegisterButton(double buttonHeight, double fontSize) {
    return ElevatedButton(
      onPressed: isLoading ? null : onRegister,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, buttonHeight),
        backgroundColor: AppColors.deepBrown,
        disabledBackgroundColor: AppColors.deepBrown.withAlpha(100),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 3,
        shadowColor: AppColors.deepBrown.withAlpha(102),
      ),
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: AppColors.creamyWhite,
                strokeWidth: 2.5,
              ),
            )
          : Text(
              'Create Account',
              style: TextStyle(
                fontSize: fontSize * 1.1,
                color: AppColors.creamyWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }

  Widget _buildLoginLink(BuildContext context, double fontSize) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () => context.go('/login'),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Already have an account?',
            style: TextStyle(color: AppColors.deepBrown, fontSize: fontSize),
            children: <TextSpan>[
              TextSpan(
                text: ' Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.deepBrown,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
