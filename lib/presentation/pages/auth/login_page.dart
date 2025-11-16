import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/auth/auth_state.dart';
import '../../../core/constants/app_colors.dart'; // Pastikan path ini benar

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
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  void _performGoogleLogin() {
    // Panggil metode cubit Anda untuk login/register Google
    // context.read<AuthCubit>().loginWithGoogle();
    // (Silakan hilangkan komentar di atas jika metodenya sudah ada)
  }

  void _handleAuthStatus(BuildContext context, AuthState state) async {
    FocusScope.of(context).unfocus();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamyWhite,
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: _handleAuthStatus,
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
                    children: <Widget>[
                      Text(
                        'Selamat Datang!',
                        style: TextStyle(
                          fontSize: fontSizeTitle,
                          fontWeight: FontWeight.bold,
                          color: AppColors.deepBrown,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        'Masuk untuk melanjutkan.',
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
                      SizedBox(height: height * 0.025),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _isPasswordHidden,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordHidden
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordHidden = !_isPasswordHidden;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password wajib diisi.';
                          }
                          return null;
                        },
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => context.push('/forgot-password'),
                          child: const Text(
                            'Lupa Password?',
                            style: TextStyle(color: AppColors.deepBrown),
                          ),
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          final bool isLoading = state is AuthLoading;
                          return ElevatedButton(
                            onPressed: isLoading ? null : _performLogin,
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, btnHeight),
                              backgroundColor: AppColors.deepBrown,
                              disabledBackgroundColor: AppColors.deepBrown
                                  .withAlpha(100),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 3,
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
                                    'Masuk',
                                    style: TextStyle(
                                      fontSize: fontSizeButton,
                                      color: AppColors.creamyWhite,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          );
                        },
                      ),
                      SizedBox(height: height * 0.04),
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10.0,
                            ),
                            child: Text(
                              'ATAU',
                              style: TextStyle(
                                color: AppColors.deepBrown.withAlpha(150),
                              ),
                            ),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),
                      SizedBox(height: height * 0.04),

                      // Tombol Google
                      OutlinedButton.icon(
                        onPressed: _performGoogleLogin,
                        icon: Image.asset(
                          'assets/images/google.png',
                          height: 22 * scale,
                          width: 22 * scale,
                        ),
                        label: Text(
                          'Masuk dengan Google',
                          style: TextStyle(
                            fontSize: (fontSizeButton * 0.9),
                            color: AppColors.deepBrown,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: AppColors.deepBrown.withAlpha(100),
                            width: 1.5,
                          ),
                          minimumSize: Size(double.infinity, btnHeight),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.02),

                      // Tombol Register
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () => context.go('/register'),
                          child: RichText(
                            text: const TextSpan(
                              text: 'Belum punya akun? ',
                              style: TextStyle(
                                color: AppColors.deepBrown,
                                fontSize: 15,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Daftar di sini',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.deepBrown,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
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
      ),
    );
  }
}
