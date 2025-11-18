// lib/presentation/widgets/auth/login_form_content.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intertwined/core/constants/app_colors.dart'; // Sesuaikan path
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
    // --- Ukuran yang disesuaikan (lebih kecil) ---
    final double titleFontSize = 28.0 * scaleFactor;
    final double buttonHeight = 50.0 * scaleFactor;
    final double generalTextSize = 14.0 * scaleFactor;

    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: screenHeight * 0.12),
          Text(
            'Hello, Nice to see you again!',
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.w700,
              color: AppColors.deepBrown,
              height: 1.2,
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
              if (value == null || value.isEmpty) {
                return 'Password wajib diisi.';
              }
              return null;
            },
          ),
          _buildForgotPasswordButton(context, generalTextSize),
          SizedBox(height: screenHeight * 0.02), // Dikurangi
          // Login Button
          _buildLoginButton(buttonHeight, generalTextSize),
          SizedBox(height: screenHeight * 0.03), // Dikurangi
          // Divider "ATAU"
          _buildOrDivider(generalTextSize),
          SizedBox(height: screenHeight * 0.03), // Dikurangi
          // Google Login Button
          _buildGoogleLoginButton(buttonHeight, generalTextSize),
          SizedBox(height: screenHeight * 0.02),

          // Register Link
          _buildRegisterLink(context, generalTextSize),
          SizedBox(height: screenHeight * 0.05),
        ],
      ),
    );
  }

  Widget _buildForgotPasswordButton(BuildContext context, double fontSize) {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => context.push('/forgot-password'),
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: AppColors.deepBrown,
            fontWeight: FontWeight.w600,
            fontSize: fontSize * 0.9,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(double buttonHeight, double fontSize) {
    return ElevatedButton(
      onPressed: isLoading ? null : onLogin,
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
              'Login',
              style: TextStyle(
                fontSize: fontSize * 1.1,
                color: AppColors.creamyWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
    );
  }

  Widget _buildOrDivider(double fontSize) {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.deepBrown.withAlpha(100))),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            'OR',
            style: TextStyle(
              color: AppColors.deepBrown.withAlpha(150),
              fontSize: fontSize * 0.9,
            ),
          ),
        ),
        Expanded(child: Divider(color: AppColors.deepBrown.withAlpha(100))),
      ],
    );
  }

  Widget _buildGoogleLoginButton(double buttonHeight, double fontSize) {
    return OutlinedButton.icon(
      onPressed: isLoading ? null : onGoogleLogin,
      icon: Image.asset(
        'assets/images/google.png',
        height: fontSize * 1.5,
        width: fontSize * 1.5,
      ),
      label: Text(
        'Sign In With Google',
        style: TextStyle(
          fontSize: fontSize,
          color: AppColors.deepBrown,
          fontWeight: FontWeight.bold,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: AppColors.deepBrown.withAlpha(100), width: 1.5),
        minimumSize: Size(double.infinity, buttonHeight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        disabledBackgroundColor: AppColors.creamyWhite.withAlpha(150),
      ),
    );
  }

  Widget _buildRegisterLink(BuildContext context, double fontSize) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () => context.go('/register'),
        child: RichText(
          text: TextSpan(
            text: 'Dont have an account yet? ',
            style: TextStyle(color: AppColors.deepBrown, fontSize: fontSize),
            children: <TextSpan>[
              TextSpan(
                text: 'Sign Up',
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
