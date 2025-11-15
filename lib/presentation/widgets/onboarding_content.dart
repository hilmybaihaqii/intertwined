// lib/presentation/widgets/onboarding_content.dart

import 'package:flutter/material.dart';

class OnboardingContent extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingContent({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 40.0,
        vertical: 20.0,
      ), // Padding disesuaikan
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Placeholder untuk Gambar
          Container(
            height: 250,
            width: double.infinity,
            color: Colors.blue.withOpacity(0.1),
            child: Center(
              child: Text(
                imagePath,
                style: TextStyle(color: Colors.blue.shade800),
              ),
            ),
          ),
          const SizedBox(height: 50.0),

          // Judul Utama
          Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15.0),

          // Deskripsi
          Text(
            description,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
