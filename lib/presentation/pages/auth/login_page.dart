// lib/presentation/pages/auth/login_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Import BLoC dan State Anda
import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/auth/auth_state.dart';
import '../../../core/constants/app_colors.dart';

// Import widget yang baru kita buat
import '../../widgets/auth/auth_background.dart';
import '../../widgets/auth/login_form_content.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // --- State dan Logic (Tidak Berubah) ---
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
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  void _performGoogleLogin() {
    FocusScope.of(context).unfocus();
    // context.read<AuthCubit>().loginWithGoogle();
    print("Login with Google pressed!"); // Placeholder
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Login dengan Google belum diimplementasikan!'),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  void _handleAuthStatus(BuildContext context, AuthState state) async {
    if (state is AuthSuccess) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Gagal: ${state.message}'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  // --- build() Method (DIREVISI) ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamyWhite, // Pastikan warna bg sesuai
      body: BlocListener<AuthCubit, AuthState>(
        listener: _handleAuthStatus,
        child: Stack(
          children: [
            // 1. Widget Latar Belakang (Tetap)
            const AuthBackground(),

            // 2. Widget Konten Form (Direvisi untuk centering)
            SafeArea(
              child: LayoutBuilder(
                // LayoutBuilder di dalam SafeArea untuk mendapatkan tinggi viewport yang benar
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
                      // Paksa container untuk setidaknya setinggi viewport
                      constraints: BoxConstraints(minHeight: viewportHeight),
                      // Pindahkan padding ke sini
                      padding: EdgeInsets.symmetric(
                        horizontal: 24 * scaleFactor,
                      ),
                      // Gunakan Center untuk memposisikan konten di tengah
                      child: Center(
                        child: BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            // Kirim screenHeight asli untuk referensi spasi
                            return LoginFormContent(
                              scaleFactor: scaleFactor,
                              screenHeight: viewportHeight,
                              formKey: _formKey,
                              emailController: _emailController,
                              passwordController: _passwordController,
                              isLoading: state is AuthLoading,
                              isPasswordHidden: _isPasswordHidden,
                              onLogin: _performLogin,
                              onGoogleLogin: _performGoogleLogin,
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
