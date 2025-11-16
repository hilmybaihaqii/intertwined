// lib/presentation/pages/main/home_page.dart

import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.creamyWhite,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.map_outlined,
              size: 80,
              color: AppColors.deepBrown.withAlpha(100),
            ),
            const SizedBox(height: 20),
            const Text(
              'Home Feed',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.deepBrown,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Fitur Geofencing & User Terdekat akan ada di sini.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: AppColors.deepBrown.withAlpha(150),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
