import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _logoOpacity = 0.0;
  double _loadingOpacity = 0.0;
  static const int _splashDurationMs = 2500;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAnimations();
      _navigateAfterDelay();
    });
  }

  void _startAnimations() {
    if (!mounted) return;
    setState(() => _logoOpacity = 1.0);

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) setState(() => _loadingOpacity = 1.0);
    });
  }

  void _navigateAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: _splashDurationMs));
    _checkUserStatusAndNavigate();
  }

  void _checkUserStatusAndNavigate() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;

    final String? authToken = prefs.getString('auth_token');

    if (authToken != null) {
      final bool isProfileComplete = prefs.getBool('profile_complete') ?? false;

      if (isProfileComplete) {
        context.go('/dashboard');
      } else {
        context.go('/profile-setup');
      }
    } else {
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamyWhite,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double width = constraints.maxWidth;
          final double height = constraints.maxHeight;

          final double logoSize = (width * 0.65).clamp(180.0, 300.0);
          final double mainGap = (height * 0.06).clamp(30.0, 60.0);
          final double subGap = (height * 0.02).clamp(10.0, 20.0);
          final double loadingFontSize = (width * 0.038).clamp(12.0, 16.0);

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedOpacity(
                  opacity: _logoOpacity,
                  duration: const Duration(milliseconds: 1500),
                  curve: Curves.easeIn,
                  child: Image.asset(
                    'assets/images/logo manpro.png',
                    height: logoSize,
                    width: logoSize,
                  ),
                ),
                SizedBox(height: mainGap),
                AnimatedOpacity(
                  opacity: _loadingOpacity,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  child: Column(
                    children: [
                      const CircularProgressIndicator(
                        color: AppColors.deepBrown,
                        strokeWidth: 3.0,
                      ),
                      SizedBox(height: subGap),
                      Text(
                        'Loading...',
                        style: TextStyle(
                          fontSize: loadingFontSize,
                          color: AppColors.deepBrown.withAlpha(150),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
