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
    required this.onRegister,
    required this.onTogglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    final double titleFontSize = 26.0 * scaleFactor;
    final double subtitleFontSize = 14.0 * scaleFactor;
    final double buttonHeight = 48.0 * scaleFactor;
    final double generalTextSize = 13.5 * scaleFactor;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: screenHeight * 0.08),
            Text(
              'Create Account',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w700,
                color: AppColors.deepBrown,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sign up to get started with us!',
              style: TextStyle(
                fontSize: subtitleFontSize,
                color: AppColors.deepBrown.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: screenHeight * 0.04),

            AuthTextField(
              controller: emailController,
              hintText: 'Email Address',
              fontSize: generalTextSize,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'Please enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Password Field
            AuthTextField(
              controller: passwordController,
              hintText: 'Password',
              fontSize: generalTextSize,
              isPassword: true,
              isPasswordHidden: isPasswordHidden,
              onToggleVisibility: onTogglePasswordVisibility,
              prefixIcon: Icons.lock_outline_rounded,
              validator: (value) {
                if (value == null || value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            AuthTextField(
              controller: confirmPasswordController,
              hintText: 'Confirm Password',
              fontSize: generalTextSize,
              isPassword: true,
              isPasswordHidden: isPasswordHidden,
              onToggleVisibility: onTogglePasswordVisibility,
              prefixIcon: Icons.lock_reset_rounded,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (value != passwordController.text) {
                  return 'Passwords do not match';
                }
                return null;
              },
            ),

            SizedBox(height: screenHeight * 0.05),

            _buildRegisterButton(buttonHeight, generalTextSize),

            SizedBox(height: screenHeight * 0.03),

            Center(child: _buildLoginLink(context, generalTextSize)),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildRegisterButton(double buttonHeight, double fontSize) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepBrown.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onRegister,
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, buttonHeight),
          backgroundColor: AppColors.deepBrown,
          disabledBackgroundColor: AppColors.deepBrown.withValues(alpha: 0.4),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: AppColors.creamyWhite,
                  strokeWidth: 2.5,
                ),
              )
            : Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: fontSize * 1.1,
                  color: AppColors.creamyWhite,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
      ),
    );
  }

  Widget _buildLoginLink(BuildContext context, double fontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already have an account? ',
          style: TextStyle(
            color: AppColors.deepBrown.withValues(alpha: 0.6),
            fontSize: fontSize,
            fontFamily: 'Inter',
          ),
        ),
        InkWell(
          onTap: () => context.go('/login'),
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            child: Text(
              'Sign In',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: AppColors.deepBrown,
                fontSize: fontSize,
                decorationColor: AppColors.deepBrown.withValues(alpha: 0.3),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
