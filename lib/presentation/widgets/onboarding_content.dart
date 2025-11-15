// lib/presentation/widgets/onboarding_content.dart

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class OnboardingContent extends StatefulWidget {
  final String subtitle;
  final String title;
  final String description;
  final String imagePath;
  final int index; // Index halaman ini
  final int currentPage; // Halaman yang sedang aktif

  const OnboardingContent({
    super.key,
    required this.subtitle,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.index,
    required this.currentPage,
  });

  @override
  State<OnboardingContent> createState() => _OnboardingContentState();
}

class _OnboardingContentState extends State<OnboardingContent> {
  // Kita akan menganimasikan setiap elemen secara terpisah
  bool _animateSubtitle = false;
  bool _animateTitle = false;
  bool _animateDescription = false;

  @override
  void initState() {
    super.initState();
    // Jika halaman ini sudah aktif saat pertama kali dibuat, langsung animasikan
    if (widget.index == widget.currentPage) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _runAnimation());
    }
  }

  @override
  void didUpdateWidget(covariant OnboardingContent oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Cek jika halaman ini BARU SAJA menjadi aktif
    if (widget.currentPage == widget.index &&
        oldWidget.currentPage != widget.index) {
      _resetAnimation(); // Reset dulu
      // Beri delay singkat sebelum menjalankan animasi lagi
      Future.delayed(const Duration(milliseconds: 50), () => _runAnimation());
    }
    // Jika halaman ini menjadi tidak aktif
    else if (widget.currentPage != widget.index &&
        oldWidget.currentPage == widget.index) {
      _resetAnimation();
    }
  }

  /// Menjalankan animasi secara berurutan (staggered)
  void _runAnimation() {
    // Gunakan Future.delayed untuk memberi jeda antar animasi
    Future.delayed(const Duration(milliseconds: 50), () {
      if (mounted) setState(() => _animateSubtitle = true);
    });
    Future.delayed(const Duration(milliseconds: 200), () {
      // 150ms setelah subtitle
      if (mounted) setState(() => _animateTitle = true);
    });
    Future.delayed(const Duration(milliseconds: 350), () {
      // 150ms setelah title
      if (mounted) setState(() => _animateDescription = true);
    });
  }

  /// Mereset semua state animasi
  void _resetAnimation() {
    if (mounted) {
      setState(() {
        _animateSubtitle = false;
        _animateTitle = false;
        _animateDescription = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 24.0), // Padding dari atas (dots)
          // 1. Judul Kecil (Subtitle) dengan animasi
          _FadeInSlideUp(
            isAnimated: _animateSubtitle,
            child: Text(
              widget.subtitle,
              style: const TextStyle(fontSize: 22, color: AppColors.deepBrown),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 5.0),

          // 2. Judul Besar (Title) dengan animasi
          _FadeInSlideUp(
            isAnimated: _animateTitle,
            child: Text(
              widget.title,
              style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: AppColors.deepBrown,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 10.0),

          // 3. Deskripsi dengan animasi
          _FadeInSlideUp(
            isAnimated: _animateDescription,
            child: Text(
              widget.description,
              style: const TextStyle(fontSize: 16, color: AppColors.deepBrown),
              textAlign: TextAlign.left,
            ),
          ),

          const SizedBox(height: 40.0), // Padding di akhir scroll
        ],
      ),
    );
  }
}

/// Widget Helper untuk animasi Fade-in + Slide-up yang rapi
class _FadeInSlideUp extends StatelessWidget {
  final Widget child;
  final bool isAnimated;

  // --- PERUBAHAN DI SINI ---
  // Hapus 'duration' dan 'offsetY' dari konstruktor
  const _FadeInSlideUp({required this.child, required this.isAnimated});

  @override
  Widget build(BuildContext context) {
    // --- PERUBAHAN DI SINI ---
    // Tentukan nilainya langsung di dalam build method
    const Duration duration = Duration(milliseconds: 500);
    const double offsetY = 20.0;

    return AnimatedOpacity(
      opacity: isAnimated ? 1.0 : 0.0,
      duration: duration,
      // Kurva animasi yang lebih halus (tidak kaku)
      curve: Curves.easeOutCubic,
      child: AnimatedContainer(
        duration: duration,
        curve: Curves.easeOutCubic,
        // Geser dari bawah (offsetY) ke posisi normal (0)
        transform: Matrix4.translationValues(0, isAnimated ? 0 : offsetY, 0),
        child: child,
      ),
    );
  }
}
