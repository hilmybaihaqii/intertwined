// lib/presentation/pages/choice_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart'; // Pastikan path ini benar

class ChoicePage extends StatefulWidget {
  const ChoicePage({super.key});

  @override
  State<ChoicePage> createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  // Variabel untuk state animasi
  double _contentOpacity = 0.0;
  double _contentOffsetY = 30.0; // Mulai 30px di bawah
  double _logoOpacity = 0.0;
  double _logoOffsetY = 50.0; // Mulai 50px di bawah
  final _animationDuration = const Duration(milliseconds: 600);

  @override
  void initState() {
    super.initState();
    // Menjalankan animasi setelah frame pertama selesai di-render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Memicu animasi konten utama
      setState(() {
        _contentOpacity = 1.0;
        _contentOffsetY = 0.0;
      });

      // Memicu animasi logo dengan sedikit delay
      Future.delayed(const Duration(milliseconds: 200), () {
        if (mounted) {
          setState(() {
            _logoOpacity = 1.0;
            _logoOffsetY = 0.0;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.creamyWhite,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // --- Layer 1 & 2: Background Atas dan Bawah ---
          const _ChoicePageBackground(),

          // --- Layer 3: Konten (Teks & Tombol) ---
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              // Bungkus dengan AnimatedOpacity dan AnimatedContainer untuk animasi
              child: AnimatedOpacity(
                opacity: _contentOpacity,
                duration: _animationDuration,
                curve: Curves.easeOutCubic,
                child: AnimatedContainer(
                  duration: _animationDuration,
                  curve: Curves.easeOutCubic,
                  // Menggunakan transform untuk animasi slide-up
                  transform: Matrix4.translationValues(0, _contentOffsetY, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Spacer untuk mendorong konten ke tengah
                      SizedBox(height: screenHeight * 0.3),

                      // Teks Header
                      Text(
                        "Your best connections are waiting for you inside.\nDon't miss out!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color: AppColors.deepBrown,
                          height: 1.4,
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.08), // Jarak dinamis
                      Text(
                        "Sign In With:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.deepBrown.withAlpha(200),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Tombol Log In
                      ElevatedButton(
                        onPressed: () {
                          context.pushNamed('login');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.deepBrown,
                          foregroundColor: AppColors.creamyWhite,
                          minimumSize: const Size(double.infinity, 55),
                          shape: const StadiumBorder(),
                          elevation: 3,
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Tombol Sign Up
                      OutlinedButton(
                        onPressed: () {
                          context.pushNamed('register');
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: AppColors.creamyWhite,
                          foregroundColor: AppColors.deepBrown,
                          minimumSize: const Size(double.infinity, 55),
                          shape: const StadiumBorder(),
                          side: BorderSide(
                            color: AppColors.deepBrown,
                            width: 1.0,
                          ),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Spacer dan Logo DIHAPUS dari Column ini
                    ],
                  ),
                ),
              ),
            ),
          ),

          // --- Layer 4: Logo (Maskot) ---
          // Diletakkan di Positioned agar bisa di atas background bawah
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              opacity: _logoOpacity,
              duration: _animationDuration,
              curve: Curves.easeOutCubic,
              child: AnimatedContainer(
                duration: _animationDuration,
                curve: Curves.easeOutCubic,
                transform: Matrix4.translationValues(0, _logoOffsetY, 0),
                height: 200,
                child: Image.asset(
                  'assets/images/logo manpro2.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- WIDGET BARU UNTUK BACKGROUND ---
// Ini membuat build method utama Anda jauh lebih bersih
class _ChoicePageBackground extends StatelessWidget {
  const _ChoicePageBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Elips Latar Belakang ATAS
        _buildOverlappingEllipses(context),
      ],
    );
  }

  // --- Widget Elips dari Onboarding (ATAS) ---
  Widget _buildOverlappingEllipses(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
          top: -(screenWidth * 0.8),
          right: -(screenWidth * 0.3),
          child: Container(
            width: screenWidth * 1.1,
            height: screenWidth * 1.3,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 203, 119, 102), // Terracotta
              borderRadius: BorderRadius.circular(screenWidth * 0.95),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(5, 5),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -(screenWidth * 1.0),
          right: -(screenWidth * 0),
          child: Container(
            width: screenWidth * 1.3,
            height: screenWidth * 1.3,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color.fromARGB(
                    255,
                    255,
                    255,
                    255,
                  ), // Mulai dari putih/krem
                  const Color.fromARGB(
                    255,
                    232,
                    196,
                    52,
                  ), // Menuju kuning solid
                ],
                begin: Alignment.topLeft,
                end: Alignment.centerRight,
                stops: const [0.0, 0.7],
              ),
              borderRadius: BorderRadius.circular(screenWidth * 0.75),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 15.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
