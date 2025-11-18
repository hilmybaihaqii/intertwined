// lib/presentation/pages/auth/register_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Import BLoC, State, dan Konstanta
import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/auth/auth_state.dart';
import '../../../core/constants/app_colors.dart';

// Import widget yang baru kita buat dan yang sudah ada
import '../../widgets/auth/auth_background.dart';
import '../../widgets/auth/register_form_content.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // --- State dan Logic tetap di sini ---
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
    FocusScope.of(context).unfocus();
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

  void _handleAuthStatus(BuildContext context, AuthState state) {
    FocusScope.of(context).unfocus();

    if (state is AuthSuccess) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Pendaftaran Berhasil! Silakan masuk dengan akun baru Anda.',
          ),
          backgroundColor: Colors.green,
        ),
      );
      
      // Perbaikan 'use_build_context_synchronously'
      if (!mounted) return;
      context.go('/login');
      
    } else if (state is AuthFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pendaftaran Gagal: ${state.message}'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  // --- build() Method (Struktur sama persis dengan Login) ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamyWhite,
      body: BlocListener<AuthCubit, AuthState>(
        listener: _handleAuthStatus,
        child: Stack(
          children: [
            // 1. Widget Latar Belakang (Reusable)
            const AuthBackground(),

            // 2. Widget Konten Form (Direvisi untuk centering)
            SafeArea(
              child: LayoutBuilder(
                builder: (context, safeConstraints) {
                  final double viewportHeight = safeConstraints.maxHeight;
                  final double screenWidth = safeConstraints.maxWidth;

                  const double baseWidth = 375.0;
                  final double scaleFactor = (screenWidth / baseWidth).clamp(0.85, 1.15);

                  return SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                        minHeight: viewportHeight,
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24 * scaleFactor),
                      child: Center(
                        child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            // Render widget konten yang baru
                            return RegisterFormContent(
                              scaleFactor: scaleFactor,
                              screenHeight: viewportHeight,
                              formKey: _formKey,
                              emailController: _emailController,
                              passwordController: _passwordController,
                              confirmPasswordController: _confirmPasswordController,
                              isLoading: state is AuthLoading,
                              isPasswordHidden: _isPasswordHidden,
                              onRegister: _performRegister,
                              onTogglePasswordVisibility:
                                  _togglePasswordVisibility,
                            );
                          },
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