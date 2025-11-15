// lib/presentation/pages/onboarding/onboarding_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/onboarding_content.dart';
import '../../../core/constants/app_colors.dart'; // Pastikan path ini benar

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  // Data onboarding sesuai urutan yang Anda berikan
  final List<Map<String, String>> onboardingData = const [
    {
      "subtitle": "Welcome to",
      "title": "Intertwined",
      "description":
          "A space for genuine campus connections. Find like-minded friends based on your personality and interest compatibility.",
      "image": "",
    },
    {
      "subtitle": "Express Yourself",
      "title": "Fully",
      "description":
          "Find a new circle of friends in the most relevant place to your daily life. Your campus world will become more colorful!",
      "image": "",
    },
    {
      "subtitle": "Explore Your Campus",
      "title": "Community",
      "description":
          "Temukan lingkaran pertemanan baru di tempat yang paling relevan dengan keseharianmu! Dunia kampusmu jadi lebih berwarna!",
      "image": "",
    },
  ];

  @override
  void initState() {
    super.initState();
    _checkInitialStatus();
  }

  void _checkInitialStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final bool isOnboardingCompleted =
        prefs.getBool('onboarding_completed') ?? false;

    if (isOnboardingCompleted && mounted) {
      context.go('/choice');
    }
  }

  void _nextPage() {
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_completed', true);

    if (mounted) {
      context.go('/choice');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Widget untuk simulasi elips tumpang tindih (DENGAN GRADASI)
  Widget _buildOverlappingEllipses(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // Elips Terracotta (sesuai kode Anda)
        Positioned(
          top: -(screenWidth * 0.8),
          right: -(screenWidth * 0.3),
          child: Container(
            width: screenWidth * 1.1,
            height: screenWidth * 1.7,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 203, 119, 102),
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

        // Elips Kuning dengan Gradien (sesuai kode Anda)
        Positioned(
          top: -(screenWidth * 1.0),
          right: -(screenWidth * 0),
          child: Container(
            width: screenWidth * 1.3,
            height: screenWidth * 1.7,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  // FIX: Menghapus .withOpacity(1) yang deprecated
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
                stops: const [0.0, 0.7], // Atur pemberhentian gradasi
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

  // Widget untuk Dots Indicator (Paginator)
  Widget _buildDotsIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        onboardingData.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          width: 8.0,
          decoration: BoxDecoration(
            // FIX: Mengganti .withOpacity(0.3) dengan .withAlpha(77)
            color: _currentPage == index
                ? AppColors.deepBrown
                : AppColors.deepBrown.withAlpha(77), // (255 * 0.3 = 76.5 -> 77)
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }

  // --- BUILD METHOD YANG SUDAH DIPERBAIKI ---
  @override
  Widget build(BuildContext context) {
    bool isLastPage = _currentPage == onboardingData.length - 1;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.creamyWhite,
      body: Stack(
        children: <Widget>[
          // --- 1. LATAR BELAKANG ELIPS ---
          _buildOverlappingEllipses(context),

          // --- 2. KONTEN (Di atas elips) ---
          SafeArea(
            child: Column(
              children: <Widget>[
                // POSISI DOTS (didorong ke bawah secara responsif)
                Padding(
                  padding: EdgeInsets.only(
                    top:
                        screenHeight *
                        0.53, // 53% dari atas layar (sesuai kode Anda)
                  ),
                  child: _buildDotsIndicator(), // Paginator (Dots)
                ),

                // Konten Slider (PageView)
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: onboardingData.length,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      final data = onboardingData[index];

                      // FIX OVERFLOW: Bungkus dengan SingleChildScrollView
                      return SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: OnboardingContent(
                          subtitle: data["subtitle"]!,
                          title: data["title"]!,
                          description: data["description"]!,
                          imagePath: data["image"]!,
                          // --- PERUBAHAN UNTUK ANIMASI ---
                          index: index,
                          currentPage: _currentPage,
                          // --- AKHIR PERUBAHAN ---
                        ),
                      );
                    },
                  ),
                ),

                // --- 3. KONTROL NAVIGASI (Bottom Controls) ---
                Padding(
                  // Padding horizontal 40.0 agar konsisten dengan konten
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 30.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // Tombol Kembali (Transparan)
                      Visibility(
                        visible: _currentPage > 0,
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: ElevatedButton(
                          onPressed: () {
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          },
                          // Style konsisten dengan tombol Next
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 45,
                              vertical: 25,
                            ),
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: AppColors.deepBrown,
                            elevation: 0,
                          ),
                          child: const Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // Tombol Next / Lanjutkan (Solid)
                      ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 45,
                            vertical: 25,
                          ),
                          backgroundColor: AppColors.deepBrown, // Warna tombol
                          elevation: 3,
                        ),
                        child: Text(
                          isLastPage ? 'Lets Go!' : 'Next',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.creamyWhite, // Warna teks
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
