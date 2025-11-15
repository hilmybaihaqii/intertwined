import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/auth/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // MENGHILANGKAN APPBAR UNTUK TAMPILAN FULL SCREEN
      // appBar: AppBar(title: const Text('Masuk')),

      // Bungkus body dengan SafeArea untuk menghindari notch/status bar
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: _handleAuthStatus,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 40.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // --- HEADER/BRANDING ---
                  const Text(
                    'Selamat Datang Kembali!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Silakan masuk untuk melanjutkan petualangan pertemanan Anda.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 40),

                  // --- Input Email ---
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Alamat Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email wajib diisi.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // --- Input Password ---
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password wajib diisi.';
                      }
                      return null;
                    },
                  ),

                  // --- TOMBOL LUPA PASSWORD ---
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.pushNamed('forgot_password'),
                      child: const Text(
                        'Lupa Password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // --- Tombol Login ---
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final bool isLoading = state is AuthLoading;
                      return ElevatedButton(
                        onPressed: isLoading ? null : _performLogin,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 55),
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 5,
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text(
                                'Masuk ke Akun',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),

                  // --- Divider atau Pilihan Lain ---
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'ATAU',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Tombol Pindah ke Register (dengan gaya OutlinedButton)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => context.go('/register'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blue, width: 1.5),
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Buat Akun Baru',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
