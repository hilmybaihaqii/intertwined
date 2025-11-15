import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChoicePage extends StatelessWidget {
  const ChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 40.0,
          ), // Padding yang konsisten
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // --- HEADER/BRANDING ---
              const Text(
                'Selamat Datang di',
                style: TextStyle(fontSize: 24, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              const Text(
                'FIND FRIENDS APP',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue, // Warna konsisten
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 15),
              const Text(
                'Masuk atau Daftar untuk melanjutkan petualangan pertemanan Anda.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 60),

              // --- Tombol Login (ElevatedButton) ---
              ElevatedButton(
                onPressed: () {
                  // Menggunakan pushNamed agar Login Page bisa pop() kembali ke sini
                  context.pushNamed('login');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(
                    double.infinity,
                    55,
                  ), // Tinggi konsisten
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ), // Radius konsisten
                  backgroundColor: Colors.blue,
                  elevation: 5,
                ),
                child: const Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // --- Tombol Register (OutlinedButton) ---
              OutlinedButton(
                onPressed: () {
                  // Menggunakan pushNamed agar Register Page bisa pop() kembali ke sini
                  context.pushNamed('register');
                },
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(
                    double.infinity,
                    55,
                  ), // Tinggi konsisten
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ), // Radius konsisten
                  side: const BorderSide(
                    color: Colors.blue,
                    width: 1.5,
                  ), // Border konsisten
                ),
                child: const Text(
                  'Daftar',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
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
