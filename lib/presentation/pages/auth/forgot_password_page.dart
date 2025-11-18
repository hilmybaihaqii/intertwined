// lib/presentation/pages/auth/forgot_password_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Import Konstanta
import '../../../core/constants/app_colors.dart';

// Import widget
import '../../widgets/auth/auth_background.dart';
import '../../widgets/auth/forgot_password_form_content.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  // --- State dan Logic tetap di sini ---
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _performPasswordReset() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(context).unfocus();

    // Simulasi pengiriman
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Link reset password terkirim ke email Anda (Simulasi)'),
        backgroundColor: Colors.green,
      ),
    );

    // Kode ini aman dari 'use_build_context_synchronously'
    // karena tidak ada 'await' sebelumnya.
    context.pop();
  }

  // --- build() Method (Struktur sama persis dengan Login) ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamyWhite,
      body: Stack(
        children: [
          // 1. Widget Latar Belakang (Reusable)
          const AuthBackground(),

          // 2. Widget Konten Form
          SafeArea(
            child: LayoutBuilder(
              builder: (context, safeConstraints) {
                final double viewportHeight = safeConstraints.maxHeight;
                final double screenWidth = safeConstraints.maxWidth;

                const double baseWidth = 375.0;
                final double scaleFactor = (screenWidth / baseWidth).clamp(
                  0.85,
                  1.15,
                );

                return SingleChildScrollView(
                  child: Container(
                    constraints: BoxConstraints(minHeight: viewportHeight),
                    padding: EdgeInsets.symmetric(horizontal: 24 * scaleFactor),
                    child: Center(
                      // Konten di-center secara vertikal
                      child: ForgotPasswordFormContent(
                        scaleFactor: scaleFactor,
                        screenHeight: viewportHeight,
                        formKey: _formKey,
                        emailController: _emailController,
                        onSendLink: _performPasswordReset,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
