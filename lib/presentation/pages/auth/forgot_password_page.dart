// lib/presentation/pages/auth/forgot_password_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart'; // Pastikan path ini benar

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
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

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Link reset password terkirim ke email Anda (Simulasi)'),
        backgroundColor: Colors.green,
      ),
    );

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamyWhite,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;
            final double height = constraints.maxHeight;

            const double baseWidth = 375.0;
            final double scale = (width / baseWidth).clamp(0.9, 1.2);

            final double fontSizeTitle = 32 * scale;
            final double fontSizeSubtitle = 16 * scale;
            final double fontSizeButton = 18 * scale;
            final double btnHeight = 55 * scale;
            final double hPadding = 24.0 * (scale > 1.1 ? 1 : scale);

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: hPadding,
                vertical: height * 0.05,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.05),
                    Text(
                      'Lupa Password?',
                      style: TextStyle(
                        fontSize: fontSizeTitle,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBrown,
                      ),
                    ),
                    SizedBox(height: height * 0.01),
                    Text(
                      'Masukkan email Anda untuk menerima link reset password.',
                      style: TextStyle(
                        fontSize: fontSizeSubtitle,
                        color: AppColors.deepBrown.withAlpha(200),
                      ),
                    ),
                    SizedBox(height: height * 0.06),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Alamat Email',
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@')) {
                          return 'Masukkan email yang valid.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: height * 0.04),
                    ElevatedButton(
                      onPressed: _performPasswordReset,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, btnHeight),
                        backgroundColor: AppColors.deepBrown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 3,
                      ),
                      child: Text(
                        'Kirim Link Reset',
                        style: TextStyle(
                          fontSize: fontSizeButton,
                          color: AppColors.creamyWhite,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () => context.pop(),
                        child: Text(
                          'Batal',
                          style: TextStyle(
                            color: AppColors.deepBrown.withAlpha(150),
                            fontWeight: FontWeight.bold,
                            fontSize: 16 * scale,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
