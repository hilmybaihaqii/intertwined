// lib/presentation/widgets/auth/forgot_password.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intertwined/core/constants/app_colors.dart';
import './auth_text_field.dart';

class ForgotPasswordFormContent extends StatelessWidget {
  final double scaleFactor;
  final double screenHeight;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final VoidCallback onSendLink;
  final bool isLoading;

  const ForgotPasswordFormContent({
    super.key,
    required this.scaleFactor,
    required this.screenHeight,
    required this.formKey,
    required this.emailController,
    required this.onSendLink,
    this.isLoading = false,
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
            SizedBox(height: screenHeight * 0.1),

            Text(
              'Forgot Password?',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w700,
                color: AppColors.deepBrown,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Don\'t worry! It happens. Please enter the email associated with your account.',
              style: TextStyle(
                fontSize: subtitleFontSize,
                color: AppColors.deepBrown.withValues(alpha: 0.6),
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
            SizedBox(height: screenHeight * 0.05),

            AuthTextField(
              controller: emailController,
              hintText: 'Email Address',
              fontSize: generalTextSize,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.mark_email_unread_outlined,
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'Please enter a valid email address';
                }
                return null;
              },
            ),
            SizedBox(height: screenHeight * 0.05),

            _buildSendLinkButton(buttonHeight, generalTextSize),

            SizedBox(height: screenHeight * 0.02),

            _buildCancelButton(context, generalTextSize),

            SizedBox(height: screenHeight * 0.05),
          ],
        ),
      ),
    );
  }

  Widget _buildSendLinkButton(double buttonHeight, double fontSize) {
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
        onPressed: isLoading ? null : onSendLink,
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
                'Send Reset Code',
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

  Widget _buildCancelButton(BuildContext context, double fontSize) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () => context.pop(),
        style: TextButton.styleFrom(
          foregroundColor: AppColors.deepBrown.withValues(alpha: 0.5),
          splashFactory: NoSplash.splashFactory,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.arrow_back_rounded, size: 18),
            const SizedBox(width: 8),
            Text(
              'Back to Login',
              style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
