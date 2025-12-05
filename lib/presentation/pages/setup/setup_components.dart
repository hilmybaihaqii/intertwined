import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class SetupShell extends StatelessWidget {
  final int totalSteps;
  final int currentStep;
  final PageController pageController;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final List<Widget> children;
  final String mascotTalk;
  final String mascotAsset;

  const SetupShell({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    required this.pageController,
    required this.onNext,
    required this.onBack,
    required this.children,
    required this.mascotTalk,
    required this.mascotAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.sunnyYellow,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _NavBtn(icon: Icons.arrow_back_ios_new, onTap: onBack),
                  Column(
                    children: [
                      Text(
                        "Step ${currentStep + 1} of $totalSteps",
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: AppColors.deepBrown,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 60,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        alignment: Alignment.centerLeft,
                        child: AnimatedFractionallySizedBox(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutQuad,
                          widthFactor: (currentStep + 1) / totalSteps,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.deepBrown,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _NavBtn(icon: Icons.arrow_forward_ios, onTap: onNext),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(36),
                      ),
                      border: const Border(
                        top: BorderSide(color: AppColors.deepBrown, width: 4),
                        left: BorderSide(color: AppColors.deepBrown, width: 4),
                        right: BorderSide(color: AppColors.deepBrown, width: 4),
                        bottom: BorderSide.none,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.deepBrown.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                  ),

                  // --- OVAL 1 (KECIL) ---
                  Positioned(
                    bottom: -40,
                    left: -50,
                    width: 280,
                    height: 180,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.vibrantTerracotta,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(140, 180),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.deepBrown.withValues(alpha: 0.6),
                            blurRadius: 30,
                            spreadRadius: 0,
                            offset: const Offset(10, 15),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // --- OVAL 2 (BESAR) ---
                  Positioned(
                    bottom: -60,
                    left: 140,
                    right: -30,
                    height: 180,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.vibrantYellow,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.elliptical(180, 200),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.deepBrown.withValues(alpha: 1.0),
                            blurRadius: 30,
                            spreadRadius: 0,
                            offset: const Offset(10, 15),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    padding: const EdgeInsets.fromLTRB(24, 30, 24, 160),
                    child: PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: children,
                    ),
                  ),

                  // --- LOGO / MASKOT ---
                  Positioned(
                    bottom: 100,
                    left: 0,
                    child: SafeArea(
                      top: false,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          _BreathingWidget(
                            child: Image.asset(
                              mascotAsset,
                              height: 250,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.android,
                                size: 100,
                                color: AppColors.deepBrown,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom: 170,
                              left: 0,
                            ),
                            child: _ChatBubble(text: mascotTalk),
                          ),
                        ],
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

class StepTemplate extends StatelessWidget {
  final String title;
  final Widget content;
  const StepTemplate({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: 1),
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
          builder: (context, val, child) => Opacity(
            opacity: val,
            child: Transform.translate(
              offset: Offset(0, 10 * (1 - val)),
              child: child,
            ),
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: AppColors.deepBrown,
              height: 1.1,
            ),
          ),
        ),
        const Spacer(flex: 1),
        content,
        const Spacer(flex: 3),
      ],
    );
  }
}

class AestheticTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool isNumber;

  const AestheticTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.isNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepBrown.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.deepBrown,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontWeight: FontWeight.w600,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 22,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24),
            borderSide: const BorderSide(
              color: AppColors.deepBrown,
              width: 2.5,
            ),
          ),
        ),
      ),
    );
  }
}

class BouncyOptionCard extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final IconData? icon;

  const BouncyOptionCard({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutBack,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.deepBrown : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.transparent : Colors.grey.shade300,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.deepBrown.withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey,
                size: 22,
              ),
              const SizedBox(width: 10),
            ],
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.w800,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavBtn extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _NavBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(50),
        splashColor: AppColors.deepBrown.withValues(alpha: 0.1),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.deepBrown, width: 2.5),
            boxShadow: [
              BoxShadow(
                color: AppColors.deepBrown.withValues(alpha: 0.1),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(icon, size: 22, color: AppColors.deepBrown),
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  const _ChatBubble({required this.text});
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.elasticOut,
      builder: (context, val, child) => Transform.scale(
        scale: val,
        alignment: Alignment.bottomLeft,
        child: child,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          border: Border.all(color: AppColors.deepBrown, width: 2.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.deepBrown.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: AppColors.deepBrown,
          ),
        ),
      ),
    );
  }
}

class _BreathingWidget extends StatefulWidget {
  final Widget child;
  const _BreathingWidget({required this.child});
  @override
  State<_BreathingWidget> createState() => _BreathingWidgetState();
}

class _BreathingWidgetState extends State<_BreathingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..repeat(reverse: true);

    _anim = Tween<double>(
      begin: 0,
      end: 8,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutSine));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Transform.translate(
        offset: Offset(0, -_anim.value),
        child: widget.child,
      ),
    );
  }
}
