import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkUserStatus();
  }

  void _checkUserStatus() async {
    // Memberi waktu 2 detik untuk animasi logo/branding
    await Future.delayed(const Duration(seconds: 2));

    final prefs = await SharedPreferences.getInstance();
    final bool isOnboardingCompleted =
        prefs.getBool('onboarding_completed') ?? false;
    final String? authToken = prefs.getString('auth_token');

    if (!mounted) return; // Pastikan widget masih ada sebelum navigasi

    // 1. Jika ada Token Login -> Dashboard (Auto-Login)
    if (authToken != null) {
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // --- Logo Anda ---
            Image.asset(
              'assets/images/logo manpro.png',
              height: 500,
              width: 500,
            ),
            const SizedBox(height: 20),
            // --- Indikator Loading ---
            const CircularProgressIndicator(color: Colors.blue),
            const SizedBox(height: 10),
            const Text(
              'Memuat aplikasi...',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
