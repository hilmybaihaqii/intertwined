// lib/presentation/widgets/auth/auth_background.dart

import 'package:flutter/material.dart';
import 'package:intertwined/core/constants/app_colors.dart'; // Sesuaikan path import

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        // --- BAGIAN ATAS (SUDAH DIGANTI) ---
        _buildOverlappingEllipses(context),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ClipPath(
                clipper: BottomCurveClipper(offsetX: 0.7, offsetY: 0.1),
                child: Container(
                  color: AppColors.vibrantTerracotta,
                  height: screenHeight * 0.2,
                ),
              ),
              ClipPath(
                clipper: BottomCurveClipper(offsetX: 0.7, offsetY: 1.0),
                child: Container(
                  color: AppColors.vibrantYellow,
                  height: screenHeight * 0.1,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Widget Elips dari ChoicePage (ATAS) ---
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
              // Menggunakan warna baru dari AppColors
              color: AppColors.vibrantTerracotta,
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
                  // Menggunakan warna dari AppColors & standar
                  Colors.white, // Sesuai kode (255, 255, 255)
                  AppColors.vibrantYellow, // Sesuai kode (232, 196, 52)
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

class BottomCurveClipper extends CustomClipper<Path> {
  final double offsetX;
  final double offsetY;

  BottomCurveClipper({this.offsetX = 0.5, this.offsetY = 1.0});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.6);
    path.quadraticBezierTo(
      size.width * offsetX,
      size.height * (offsetY * -0.05),
      size.width,
      size.height * 0.5,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
