// lib/presentation/widgets/auth/forgot_password_form_content.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intertwined/core/constants/app_colors.dart'; // Sesuaikan path
import './auth_text_field.dart';

class ForgotPasswordFormContent extends StatelessWidget {
  final double scaleFactor;
  final double screenHeight;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final VoidCallback onSendLink;

  const ForgotPasswordFormContent({
    super.key,
    required this.scaleFactor,
    required this.screenHeight,
    required this.formKey,
    required this.emailController,
    required this.onSendLink,
  });

  @override
  Widget build(BuildContext context) {
    // Ukuran yang konsisten
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
            'Lost Your Password?',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.deepBrown,
              height: 1.2,
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            'Enter your email to receive a password reset link.',
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
          SizedBox(height: screenHeight * 0.04),

          // Send Link Button
          _buildSendLinkButton(buttonHeight, generalTextSize),
          SizedBox(height: screenHeight * 0.02),

          // Cancel Button
          _buildCancelButton(context, generalTextSize),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }

  Widget _buildSendLinkButton(double buttonHeight, double fontSize) {
    return ElevatedButton(
      onPressed: onSendLink,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, buttonHeight),
        backgroundColor: AppColors.deepBrown,
        disabledBackgroundColor: AppColors.deepBrown.withAlpha(100),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 3,
        shadowColor: AppColors.deepBrown.withAlpha(102),
      ),
      child: Text(
        'Send Reset Link',
        style: TextStyle(
          fontSize: fontSize * 1.1,
          color: AppColors.creamyWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context, double fontSize) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () => context.pop(), // Langsung pop
        child: Text(
          'Cancel',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppColors.deepBrown.withAlpha(150),
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
