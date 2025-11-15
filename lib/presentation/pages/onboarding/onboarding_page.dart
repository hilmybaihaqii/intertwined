// lib/presentation/pages/onboarding/onboarding_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/onboarding_content.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = const [
    {
      "image": "Asset 1",
      "title": "Temukan Teman Sekitar Anda",
      "description":
          "Jaringan pertemanan baru hanya berjarak beberapa langkah dari lokasi Anda saat ini.",
    },
    {
      "image": "Asset 2",
      "title": "Jelajahi Zona Terbatas",
      "description":
          "Hanya di wilayah tertentu Anda dapat terhubung. Rasakan petualangan bertemu orang baru.",
    },
    {
      "image": "Asset 3",
      "title": "Keamanan dan Privasi Terjamin",
      "description":
          "Lokasi Anda hanya dilacak saat Anda berada di zona aman. Privasi adalah prioritas kami.",
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

  @override
  Widget build(BuildContext context) {
    bool isLastPage = _currentPage == onboardingData.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // --- SKIP BUTTON DENGAN PADDING YANG RAPIH ---
            Padding(
              padding: const EdgeInsets.only(top: 10.0, right: 24.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _completeOnboarding,
                  child: Text(
                    isLastPage ? '' : 'Skip',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            // --- KONTEN PAGEVIEW ---
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                // AKTIFKAN SWIPE: Hapus physics: const NeverScrollableScrollPhysics(),
                itemCount: onboardingData.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingContent(
                    imagePath: onboardingData[index]["image"]!,
                    title: onboardingData[index]["title"]!,
                    description: onboardingData[index]["description"]!,
                  );
                },
              ),
            ),

            // --- Bagian Dots dan Kontrol Navigasi ---
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 30.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Tombol Kembali
                  if (_currentPage > 0)
                    TextButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      },
                      child: const Text(
                        'Kembali',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    )
                  else
                    const SizedBox(width: 80),

                  // Indikator Halaman (Dots)
                  Row(
                    children: List.generate(
                      onboardingData.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 150),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        height: 8.0,
                        width: _currentPage == index ? 24.0 : 8.0,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? Colors.blue
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),

                  // Tombol Next / Lanjutkan
                  ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                        vertical: 15,
                      ),
                      backgroundColor: Colors.blue,
                      elevation: 3,
                    ),
                    child: Text(
                      isLastPage ? 'Lanjutkan' : 'Berikutnya',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
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
    );
  }
}
