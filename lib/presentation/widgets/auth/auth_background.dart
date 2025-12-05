// lib/presentation/widgets/auth/auth_background.dart

import 'package:flutter/material.dart';
import 'package:intertwined/core/constants/app_colors.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: const Color(0xFFFDFDFD),
      width: screenWidth,
      height: screenHeight,
      child: Stack(
        children: [
          _buildOverlappingEllipses(context),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              height: screenHeight * 0.25,
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  ClipPath(
                    clipper: BottomCurveClipper(offsetX: 0.65, offsetY: 0.05),
                    child: Container(
                      height: screenHeight * 0.20,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.vibrantTerracotta.withValues(alpha: 0.7),
                            AppColors.vibrantTerracotta,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.vibrantTerracotta.withValues(
                              alpha: 0.3,
                            ),
                            blurRadius: 20,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                    ),
                  ),

                  ClipPath(
                    clipper: BottomCurveClipper(offsetX: 0.65, offsetY: 0.8),
                    child: Container(
                      height: screenHeight * 0.12,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.vibrantYellow,
                            AppColors.vibrantYellow.withValues(alpha: 0.9),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 15,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlappingEllipses(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
          top: -(screenWidth * 0.85),
          right: -(screenWidth * 0.35),
          child: Container(
            width: screenWidth * 1.2,
            height: screenWidth * 1.4,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.vibrantTerracotta,
              boxShadow: [
                BoxShadow(
                  color: AppColors.vibrantTerracotta.withValues(alpha: 0.4),
                  blurRadius: 30.0,
                  spreadRadius: 5.0,
                  offset: const Offset(10, 10),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          top: -(screenWidth * 1.05),
          right: -(screenWidth * 0.05),
          child: Container(
            width: screenWidth * 1.35,
            height: screenWidth * 1.35,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.white,
                  AppColors.vibrantYellow.withValues(alpha: 0.9),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.2, 0.9],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20.0,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: AppColors.vibrantYellow.withValues(alpha: 0.2),
                  blurRadius: 40.0,
                  spreadRadius: -5.0,
                  offset: const Offset(0, 10),
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
    path.moveTo(0, size.height * 0.4);
    path.quadraticBezierTo(
      size.width * offsetX,
      size.height * (offsetY * -0.1),
      size.width,
      size.height * 0.6,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
