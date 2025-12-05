// lib/presentation/pages/auth/register_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/auth/auth_state.dart';
import '../../../core/constants/app_colors.dart';

import '../../widgets/auth/auth_background.dart';
import '../../widgets/auth/register_form_content.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _performRegister() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  // --- FUNGSI AUTH STATUS DENGAN FIX LINTER ---
  Future<void> _handleAuthStatus(BuildContext context, AuthState state) async {
    if (state is AuthSuccess) {
      _showCustomSnackBar(
        context,
        'Registration Successful! Please log in.',
        isError: false,
      );

      // Tunggu 2 detik
      await Future.delayed(const Duration(seconds: 2));

      // FIX: Cek context.mounted (milik parameter) bukan mounted (milik state)
      if (!context.mounted) return;

      context.go('/login');
    } else if (state is AuthFailure) {
      _showCustomSnackBar(context, state.message, isError: true);
    }
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
              isError ? Icons.error_outline : Icons.check_circle_outline,
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
        body: BlocListener<AuthCubit, AuthState>(
          listener: _handleAuthStatus,
          child: Stack(
            children: [
              const AuthBackground(),

              SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double screenHeight = constraints.maxHeight;
                    final double screenWidth = constraints.maxWidth;

                    const double baseWidth = 375.0;
                    final double scaleFactor = (screenWidth / baseWidth).clamp(
                      0.85,
                      1.15,
                    );

                    return SizedBox(
                      height: screenHeight,
                      width: screenWidth,
                      child: Center(
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: RegisterFormContent(
                            scaleFactor: scaleFactor,
                            screenHeight: screenHeight,
                            formKey: _formKey,
                            emailController: _emailController,
                            passwordController: _passwordController,
                            confirmPasswordController:
                                _confirmPasswordController,
                            isLoading: false,
                            isPasswordHidden: _isPasswordHidden,
                            onRegister: _performRegister,
                            onTogglePasswordVisibility:
                                _togglePasswordVisibility,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Loading Overlay
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return Container(
                      color: Colors.black.withValues(alpha: 0.3),
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(
                                color: AppColors.deepBrown,
                              ),
                              SizedBox(height: 16),
                              Text(
                                "Creating Account...",
                                style: TextStyle(
                                  color: AppColors.deepBrown,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
