// lib/presentation/pages/splash_page.dart

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart'; // Pastikan path ini benar

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // State untuk mengontrol animasi fade-in
  double _logoOpacity = 0.0;
  double _loadingOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    // 1. Memicu animasi fade-in
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Logo muncul lebih dulu
        setState(() {
          _logoOpacity = 1.0;
        });
        // Loading muncul 0.5 detik setelah logo
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            setState(() {
              _loadingOpacity = 1.0;
            });
          }
        });
      }
    });

    // 2. Menjalankan logika navigasi
    _checkUserStatus();
  }

  void _checkUserStatus() async {
    // Memberi waktu 2 detik untuk branding (total durasi)
    // Anda bisa sesuaikan ini, misal jadi 2500ms agar pas dengan animasi
    await Future.delayed(const Duration(milliseconds: 2500));

    final prefs = await SharedPreferences.getInstance();
    final bool isOnboardingCompleted =
        prefs.getBool('onboarding_completed') ?? false;
    final String? authToken = prefs.getString('auth_token');

    if (!mounted) return; // Pastikan widget masih ada sebelum navigasi

    // 1. Jika ada Token Login -> Dashboard (Auto-Login)
    if (authToken != null) {
      // Pastikan Anda punya rute '/dashboard' di router Anda
      context.go('/dashboard');

      // 2. Jika TIDAK ADA Token Login
      //    A. Jika Onboarding BELUM PERNAH selesai -> Onboarding Page
    } else if (!isOnboardingCompleted) {
      context.go('/onboarding');

      //    B. Jika Onboarding SUDAH PERNAH selesai -> Choice Page (Login/Register)
    } else {
      context.go('/choice');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Menggunakan warna background utama aplikasi
      backgroundColor: AppColors.creamyWhite,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- Logo Anda (dengan animasi fade-in) ---
            AnimatedOpacity(
              opacity: _logoOpacity,
              duration: const Duration(
                milliseconds: 1500,
              ), // Durasi fade-in logo
              curve: Curves.easeIn,
              child: Image.asset(
                'assets/images/logo manpro.png', // Pastikan path logo ini benar
                height: 250, // Ukuran disesuaikan agar lebih proporsional
                width: 250,
              ),
            ),
            const SizedBox(height: 50),

            // --- Indikator Loading (dengan animasi fade-in) ---
            AnimatedOpacity(
              opacity: _loadingOpacity,
              duration: const Duration(
                milliseconds: 500,
              ), // Durasi fade-in loading
              curve: Curves.easeIn,
              child: Column(
                children: [
                  const CircularProgressIndicator(
                    // Menggunakan warna tema aplikasi
                    color: AppColors.deepBrown,
                    strokeWidth: 3.0,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Loading...',
                    style: TextStyle(
                      fontSize: 14,
                      // Menggunakan warna tema aplikasi (sedikit pudar)
                      color: AppColors.deepBrown.withAlpha(150),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
