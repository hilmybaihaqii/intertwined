// lib/presentation/pages/auth/forgot_password_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_colors.dart';

import '../../widgets/auth/auth_background.dart';
import '../../widgets/auth/forgot_password_form_content.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _performPasswordReset() async {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });

    _showCustomSnackBar(
      context,
      'Reset link sent! Please check your inbox.',
      isError: false,
    );

    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) context.pop();
    });
  }

  void _showCustomSnackBar(
    BuildContext context,
    String message, {
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.mark_email_read_outlined,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: isError
            ? Colors.redAccent.withValues(alpha: 0.9)
            : Colors.green.withValues(alpha: 0.9),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.creamyWhite,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            const AuthBackground(),

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

                  return SizedBox(
                    height: viewportHeight,
                    width: screenWidth,
                    child: Center(
                      child: SingleChildScrollView(
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: ForgotPasswordFormContent(
                          scaleFactor: scaleFactor,
                          screenHeight: viewportHeight,
                          formKey: _formKey,
                          emailController: _emailController,
                          onSendLink: _performPasswordReset,
                          isLoading: _isLoading,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
