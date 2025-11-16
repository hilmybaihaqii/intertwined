import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/auth/auth_state.dart';
import '../../../core/constants/app_colors.dart';

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
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
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
                        'Buat Akun Baru',
                        style: TextStyle(
                          fontSize: fontSizeTitle,
                          fontWeight: FontWeight.bold,
                          color: AppColors.deepBrown,
                        ),
                      ),
                      SizedBox(height: height * 0.01),
                      Text(
                        'Daftar untuk memulai petualangan baru.',
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
                          if (value == null || value.length < 6) {
                            return 'Password minimal 6 karakter.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.025),
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _isPasswordHidden,
                        decoration: InputDecoration(
                          labelText: 'Konfirmasi Password',
                          prefixIcon: const Icon(Icons.lock_clock_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Konfirmasi password wajib diisi.';
                          }
                          if (value != _passwordController.text) {
                            return 'Password tidak cocok.';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: height * 0.05),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          final bool isLoading = state is AuthLoading;
                          return ElevatedButton(
                            onPressed: isLoading ? null : _performRegister,
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
                                    'Daftar Akun',
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => context.go('/login'),
                            child: RichText(
                              text: const TextSpan(
                                text: 'Sudah punya akun? ',
                                style: TextStyle(
                                  color: AppColors.deepBrown,
                                  fontSize: 15,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Masuk di sini',
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
                        ],
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
