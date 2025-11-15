// lib/core/config/router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// Asumsikan kita akan membuat halaman-halaman ini
import '../../presentation/pages/onboarding/splash_page.dart';
import '../../presentation/pages/onboarding/onboarding_page.dart';
import '../../presentation/pages/choice_page.dart';
import '../../presentation/pages/auth/login_page.dart';
import '../../presentation/pages/auth/register_page.dart';
import '../../presentation/pages/auth/forgot_password_page.dart';
import '../../presentation/pages/main/dashboard_page.dart';
import '../../presentation/pages/onboarding/profile_setup_page.dart';


final GoRouter router = GoRouter(
  // Tentukan rute awal aplikasi (yaitu Splash Screen)
  initialLocation: '/', 
  
  // Daftar semua rute yang ada di aplikasi Anda
  routes: <RouteBase>[
    // Rute utama (Splash Screen)
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
      // Child routes tidak diperlukan untuk Splash, karena ia langsung navigasi
    ),
    
    // Rute Onboarding/Perkenalan
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingPage();
      },
    ),
    
    // Rute Pemilihan Login/Register
    GoRoute(
      path: '/choice',
      name: 'choice',
      builder: (BuildContext context, GoRouterState state) {
        return const ChoicePage();
      },
    ),
    
    // Rute Login
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),
    
    // Rute Register
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterPage();
      },
    ),

    // Rute Pengisian Profil Awal
    GoRoute(
      path: '/profile-setup',
      name: 'profile_setup',
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileSetupPage();
      },
    ),

    GoRoute(
      path: '/forgot-password',
      name: 'forgot_password',
      builder: (BuildContext context, GoRouterState state) {
        return const ForgotPasswordPage(); // Halaman baru yang akan kita buat
      },
    ),
    
    // Rute Dashboard Utama
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardPage();
      },
    ),
  ],
);