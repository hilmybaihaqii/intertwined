// lib/presentation/pages/auth/login_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/auth/auth_state.dart';
import '../../../core/constants/app_colors.dart';

import '../../widgets/auth/auth_background.dart';
import '../../widgets/auth/login_form_content.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isPasswordHidden = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  void _performLogin() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  void _performGoogleLogin() {
    FocusManager.instance.primaryFocus?.unfocus();
    // Placeholder logic
    _showCustomSnackBar(
      context,
      'Fitur Login Google segera hadir!',
      isError: false,
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  void _handleAuthStatus(BuildContext blocContext, AuthState state) async {
    if (state is AuthSuccess) {
      ScaffoldMessenger.of(blocContext).hideCurrentSnackBar();

      final prefs = await SharedPreferences.getInstance();
      if (!mounted) return;

      final bool isProfileSetupComplete =
          prefs.getBool('profile_completed') ?? false;
      if (isProfileSetupComplete) {
        context.go('/dashboard');
      } else {
        context.go('/profile-setup');
      }
    } else if (state is AuthFailure) {
      _showCustomSnackBar(blocContext, state.message, isError: true);
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
              isError ? Icons.error_outline : Icons.info_outline,
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
            : Colors.blueAccent,
        behavior: SnackBarBehavior.floating, // Melayang (tidak nempel bawah)
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.creamyWhite,
        resizeToAvoidBottomInset:
            true,
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
                          child: Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: LoginFormContent(
                              scaleFactor: scaleFactor,
                              screenHeight: screenHeight,
                              formKey: _formKey,
                              emailController: _emailController,
                              passwordController: _passwordController,
                              isLoading: false,
                              isPasswordHidden: _isPasswordHidden,
                              onLogin: _performLogin,
                              onGoogleLogin: _performGoogleLogin,
                              onTogglePasswordVisibility:
                                  _togglePasswordVisibility,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

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
                          ),
                          child: const CircularProgressIndicator(
                            color: AppColors.deepBrown,
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
