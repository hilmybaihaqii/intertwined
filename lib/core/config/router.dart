import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Import semua halaman
import '../../presentation/pages/onboarding/splash_page.dart';
import '../../presentation/pages/onboarding/onboarding_page.dart';
import '../../presentation/pages/choice_page.dart';
import '../../presentation/pages/auth/login_page.dart';
import '../../presentation/pages/auth/register_page.dart';
import '../../presentation/pages/auth/forgot_password_page.dart';
import '../../presentation/pages/main/dashboard_page.dart';
import '../../presentation/pages/setup/profile_setup_page.dart';
import '../../presentation/pages/main/message/message_page.dart';
import '../../presentation/pages/main/message/chat_detail_page.dart';

import '../../core/models/match_model.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    // Splash
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
    ),

    // Onboarding
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingPage();
      },
    ),

    // Choice (Login/Register)
    GoRoute(
      path: '/choice',
      name: 'choice',
      builder: (BuildContext context, GoRouterState state) {
        return const ChoicePage();
      },
    ),

    // Auth Routes
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (BuildContext context, GoRouterState state) {
        return const RegisterPage();
      },
    ),
    GoRoute(
      path: '/forgot-password',
      name: 'forgot_password',
      builder: (BuildContext context, GoRouterState state) {
        return const ForgotPasswordPage();
      },
    ),

    // Setup Profile
    GoRoute(
      path: '/profile-setup',
      name: 'profile_setup',
      builder: (BuildContext context, GoRouterState state) {
        return const ProfileSetupPage();
      },
    ),

    // Main Dashboard
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardPage();
      },
    ),

    // Message Page (Baru)
    GoRoute(
      path: '/message',
      name: 'message', // Kasih nama biar rapi
      builder: (context, state) => const MessagePage(),
    ),

    GoRoute(
      path: '/chat-detail',
      name: 'chat_detail',
      builder: (context, state) {
        // Mengambil data user yang dikirim via extra
        final user = state.extra as MatchUser;
        return ChatDetailPage(user: user);
      },
    ),
  ],
);
