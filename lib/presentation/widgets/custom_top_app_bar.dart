import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class CustomTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onMessageTap;
  final VoidCallback? onProfileTap;

  const CustomTopAppBar({super.key, this.onMessageTap, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.creamyWhite,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: false,

      // 1. Toolbar Height (Diperbesar agar lega)
      toolbarHeight: 90,

      // 2. Judul (Intertwined)
      title: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 12.0),
        child: const Text(
          'Intertwined',
          style: TextStyle(
            color: AppColors.deepBrown,
            fontWeight: FontWeight.w900,
            fontSize: 28,
            letterSpacing: -1.0,
            height: 1.0,
          ),
        ),
      ),

      // 3. Tombol Aksi (Kanan)
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, right: 24.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- 1. Message Button (UBAH IKON DI SINI) ---
              _buildAestheticIconButton(
                // Menggunakan ikon Chat Bubble
                icon: Icons.chat_bubble_outline_rounded,
                onTap: onMessageTap ?? () {},
                hasBadge: true, // Ada titik merah (pesan belum dibaca)
              ),

              const SizedBox(width: 14),

              // --- 2. Profile Button ---
              _buildAestheticIconButton(
                icon: Icons.person_outline_rounded,
                onTap: onProfileTap ?? () {},
                hasBadge: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAestheticIconButton({
    required IconData icon,
    required VoidCallback onTap,
    bool hasBadge = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          // Container Bulat
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.deepBrown.withValues(alpha: 0.08),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.deepBrown.withValues(alpha: 0.06),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Icon(icon, color: AppColors.deepBrown, size: 24),
          ),

          // Titik Merah (Badge)
          if (hasBadge)
            Positioned(
              top: 4,
              right: 4,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.vibrantTerracotta,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
