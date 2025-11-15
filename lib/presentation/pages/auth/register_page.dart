import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/auth/auth_state.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _performRegister() {
    if (_formKey.currentState!.validate()) {
      // Panggil method register dari AuthCubit
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

      // Setelah Register sukses: Redireksi ke halaman LOGIN (sesuai alur)
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
      // Tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Pendaftaran Gagal: ${state.message}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // MENGHILANGKAN APPBAR UNTUK TAMPILAN FULL SCREEN
      // appBar: AppBar(title: const Text('Daftar Akun Baru')),
      body: SafeArea(
        // Bungkus body dengan SafeArea
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
                    'Buat Akun Baru',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Daftarkan diri Anda untuk bergabung dengan komunitas kami.',
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
                      if (value == null || value.length < 6) {
                        return 'Password minimal 6 karakter.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),

                  // --- Tombol Register ---
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      final bool isLoading = state is AuthLoading;
                      return ElevatedButton(
                        onPressed: isLoading ? null : _performRegister,
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
                                'Daftar Akun',
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
                          'SUDAH PUNYA AKUN?',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // Tombol Pindah ke Login (OutlinedButton)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => context.go('/login'),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blue, width: 1.5),
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Masuk ke Akun Saya',
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
