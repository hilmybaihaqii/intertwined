// lib/presentation/pages/auth/forgot_password_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // APPBAR DIHILANGKAN
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 40.0,
          ), // Padding disesuaikan
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Tombol Kembali Eksplisit di ATAS DIHAPUS ---

              // --- HEADER/BRANDING ---
              const Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Masukkan alamat email Anda. Kami akan mengirimkan instruksi untuk mengatur ulang password Anda.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 40),

              // --- Form Input Email ---
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Alamat Email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 30),

              // --- Tombol Reset Password ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Simulasi aksi: Kembali ke halaman Login setelah aksi
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Link reset password terkirim (Simulasi)',
                        ),
                      ),
                    );
                    context.pop();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  child: const Text(
                    'Kirim Link Reset',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // --- Tombol Kembali Batal (TextButton) DIKEMBALIKAN ---
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () => context.pop(),
                  child: const Text(
                    'Batal dan Kembali ke Login',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
