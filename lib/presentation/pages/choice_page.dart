import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class ChoicePage extends StatefulWidget {
  const ChoicePage({super.key});

  @override
  State<ChoicePage> createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage>
    with SingleTickerProviderStateMixin {
  double _contentOpacity = 0.0;
  double _contentOffsetY = 40.0;
  double _logoOpacity = 0.0;
  double _logoOffsetY = 60.0;

  final Duration _animationDuration = const Duration(milliseconds: 800);

  @override
  void initState() {
    super.initState();
    _startAnimations();
  }

  void _startAnimations() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _contentOpacity = 1.0;
        _contentOffsetY = 0.0;
      });

      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) {
          setState(() {
            _logoOpacity = 1.0;
            _logoOffsetY = 0.0;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const _ChoicePageBackground(),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedContainer(
              duration: _animationDuration,
              curve: Curves.easeOutBack,
              transform: Matrix4.translationValues(0, _logoOffsetY, 0),
              child: AnimatedOpacity(
                duration: _animationDuration,
                opacity: _logoOpacity,
                child: SizedBox(
                  // Ukuran maskot
                  height: screenWidth * 0.5,
                  child: Image.asset(
                    'assets/images/logo manpro2.png',
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomLeft,
                  ),
                ),
              ),
            ),
          ),

          // --- LAYER 3: Konten Utama (Teks & Tombol) ---
          // Menggunakan Positioned.fill untuk memastikan area mencakup seluruh layar
          // Lalu Center untuk menengahkan konten
          Positioned.fill(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Center(
                  // INI KUNCINYA: Memusatkan child secara Vertikal & Horizontal
                  child: AnimatedContainer(
                    duration: _animationDuration,
                    curve: Curves.easeOutQuart,
                    transform: Matrix4.translationValues(0, _contentOffsetY, 0),
                    child: AnimatedOpacity(
                      duration: _animationDuration,
                      opacity: _contentOpacity,
                      curve: Curves.easeOut,
                      child: Column(
                        // MainAxisSize.min membuat Column menyusut sesuai tinggi kontennya
                        mainAxisSize: MainAxisSize.min,
                        // MainAxisAlignment.center memusatkan item di dalam column
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          // Header
                          Text(
                            "Connect, Collaborate,\nand Create Together.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: AppColors.deepBrown,
                              height: 1.2,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Subtitle
                          Text(
                            "Your best connections are waiting inside.\nDon't miss out on the opportunity!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.deepBrown.withValues(alpha: 0.6),
                              height: 1.5,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          // Jarak antar teks dan divider
                          const SizedBox(height: 30),

                          // Divider "Get Started"
                          Row(
                            children: [
                              Expanded(
                                child: Divider(
                                  color: AppColors.deepBrown.withValues(
                                    alpha: 0.1,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  "Get Started",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.deepBrown.withValues(
                                      alpha: 0.4,
                                    ),
                                    letterSpacing: 1.0,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: AppColors.deepBrown.withValues(
                                    alpha: 0.1,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 30),

                          // Tombol-tombol
                          _buildLoginButton(),
                          const SizedBox(height: 16),
                          _buildSignUpButton(),

                          // Spacer kosong di bawah agar tidak menabrak kepala maskot terlalu rapat
                          // Jika maskot terlalu besar, tambahkan ini:
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepBrown.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => context.pushNamed('login'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.deepBrown,
          foregroundColor: AppColors.creamyWhite,
          minimumSize: const Size(double.infinity, 56),
          elevation: 0,
          shape: const StadiumBorder(),
        ),
        child: const Text(
          'Log In',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return OutlinedButton(
      onPressed: () => context.pushNamed('register'),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.deepBrown,
        minimumSize: const Size(double.infinity, 56),
        shape: const StadiumBorder(),
        side: BorderSide(
          color: AppColors.deepBrown.withValues(alpha: 0.3),
          width: 1.5,
        ),
        splashFactory: InkRipple.splashFactory,
      ),
      child: const Text(
        'Create an Account',
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _ChoicePageBackground extends StatelessWidget {
  const _ChoicePageBackground();

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        // 1. BAGIAN ATAS (Ellipses)
        Positioned(
          top: -(screenWidth * 0.8),
          right: -(screenWidth * 0.3),
          child: Container(
            width: screenWidth * 1.1,
            height: screenWidth * 1.3,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.vibrantTerracotta,
              boxShadow: [
                BoxShadow(
                  color: AppColors.vibrantTerracotta.withValues(alpha: 0.4),
                  blurRadius: 30.0,
                  offset: const Offset(5, 10),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: -(screenWidth * 1.0),
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
                  offset: const Offset(0, 10),
                ),
              ],
            ),
          ),
        ),

        // 2. BAGIAN BAWAH (Waves)
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: SizedBox(
            height: screenHeight * 0.2,
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                ClipPath(
                  clipper: BottomCurveClipper(offsetX: 0.65, offsetY: 0.05),
                  child: Container(
                    height: screenHeight * 0.18,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          AppColors.vibrantTerracotta.withValues(alpha: 0.8),
                          AppColors.vibrantTerracotta,
                        ],
                      ),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: BottomCurveClipper(offsetX: 0.65, offsetY: 0.8),
                  child: Container(
                    height: screenHeight * 0.1,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.vibrantYellow,
                          AppColors.vibrantYellow.withValues(alpha: 0.9),
                        ],
                      ),
                    ),
                  ),
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
