// lib/presentation/widgets/auth/login_form_content.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intertwined/core/constants/app_colors.dart';
import './auth_text_field.dart';

class LoginFormContent extends StatelessWidget {
  final double scaleFactor;
  final double screenHeight;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isLoading;
  final bool isPasswordHidden;
  final VoidCallback onLogin;
  final VoidCallback onGoogleLogin;
  final VoidCallback onTogglePasswordVisibility;

  const LoginFormContent({
    super.key,
    required this.scaleFactor,
    required this.screenHeight,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isLoading,
    required this.isPasswordHidden,
    required this.onLogin,
    required this.onGoogleLogin,
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
            SizedBox(height: screenHeight * 0.1),

            Text(
              'Welcome Back!',
              style: TextStyle(
                fontSize: titleFontSize,
                fontWeight: FontWeight.w700,
                color: AppColors.deepBrown,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Please sign in to access your account',
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
            AuthTextField(
              controller: passwordController,
              hintText: 'Password',
              fontSize: generalTextSize,
              isPassword: true,
              isPasswordHidden: isPasswordHidden,
              onToggleVisibility: onTogglePasswordVisibility,
              prefixIcon: Icons.lock_outline_rounded,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required';
                }
                return null;
              },
            ),

            _buildForgotPasswordButton(context, generalTextSize),
            SizedBox(height: screenHeight * 0.025),
            _buildLoginButton(buttonHeight, generalTextSize),
            SizedBox(height: screenHeight * 0.03),
            _buildOrDivider(generalTextSize),
            SizedBox(height: screenHeight * 0.03),
            _buildGoogleLoginButton(buttonHeight, generalTextSize),
            SizedBox(height: screenHeight * 0.02),
            Center(child: _buildRegisterLink(context, generalTextSize)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton(BuildContext context, double fontSize) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: TextButton(
          onPressed: () => context.push('/forgot-password'),
          style: TextButton.styleFrom(
            visualDensity: VisualDensity.compact,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          ),
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              color: AppColors.deepBrown.withValues(alpha: 0.7),
              fontWeight: FontWeight.w600,
              fontSize: fontSize * 0.9,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(double buttonHeight, double fontSize) {
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
        onPressed: isLoading ? null : onLogin,
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
                'Log In',
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

  Widget _buildOrDivider(double fontSize) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: AppColors.deepBrown.withValues(alpha: 0.2),
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            'or continue with',
            style: TextStyle(
              color: AppColors.deepBrown.withValues(alpha: 0.5),
              fontSize: fontSize * 0.85,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: AppColors.deepBrown.withValues(alpha: 0.2),
            thickness: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildGoogleLoginButton(double buttonHeight, double fontSize) {
    return OutlinedButton(
      onPressed: isLoading ? null : onGoogleLogin,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: AppColors.deepBrown.withValues(alpha: 0.15),
          width: 1.5,
        ),
        minimumSize: Size(double.infinity, buttonHeight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.transparent, // Agar background tetap bersih
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/google.png', height: 22, width: 22),
          const SizedBox(width: 12),
          Text(
            'Google',
            style: TextStyle(
              fontSize: fontSize,
              color: AppColors.deepBrown,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterLink(BuildContext context, double fontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Don\'t have an account? ',
          style: TextStyle(
            color: AppColors.deepBrown.withValues(alpha: 0.6),
            fontSize: fontSize,
            fontFamily: 'Inter',
          ),
        ),
        InkWell(
          onTap: () => context.go('/register'),
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            child: Text(
              'Sign Up',
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
