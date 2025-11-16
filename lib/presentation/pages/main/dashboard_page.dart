import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../core/constants/app_colors.dart';

// Import semua halamanmu
import 'home_page.dart';
import 'search_page.dart';
import 'scroll_page.dart';
import 'news_page.dart'; 
import 'profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  // 🛑 'List<Widget> _widgetOptions' YANG STATIS DIHAPUS.
  // Itu adalah penyebab freeze.

  // ✅ DIGANTI DENGAN FUNGSI INI
  // Ini adalah metode "Lazy Loading". Halaman HANYA dibuat saat di-klik.
  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return HomePage();
      case 1:
        return SearchPage();
      case 2:
        return ScrollPage();
      case 3:
        return NewsPage();
      case 4:
        // ProfilePage() baru akan dibuat saat kamu klik tab 'Account'
        return ProfilePage();
      default:
        // Halaman default jika terjadi error
        return HomePage();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamyWhite,
      appBar: AppBar(
        title: const Text(
          'Intertwined',
          style: TextStyle(
            color: AppColors.deepBrown,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.creamyWhite,
        elevation: 0,
      ),

      // ✅ 'body' diubah untuk memanggil fungsi _buildPage
      body: _buildPage(_selectedIndex),

      bottomNavigationBar: buildBottomNavBar(),
    );
  }

  // --- Widget BottomNavBar (TIDAK BERUBAH) ---
  Widget buildBottomNavBar() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.creamyWhite,
        border: Border(top: BorderSide(color: Colors.grey[200]!, width: 1)),
        boxShadow: [
          BoxShadow(
            blurRadius: 25,
            color: Colors.black.withAlpha(13),
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          // Padding luar
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          child: GNav(
            gap: 6,
            activeColor: AppColors.creamyWhite,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: AppColors.deepBrown,
            color: AppColors.deepBrown.withAlpha(150),
            tabs: const [
              GButton(icon: Icons.home_outlined, text: 'Home'),
              GButton(icon: Icons.search_outlined, text: 'Search'),
              GButton(icon: Icons.explore_outlined, text: 'Scroll'),
              GButton(icon: Icons.article_outlined, text: 'News'),
              GButton(icon: Icons.person_outline, text: 'Account'),
            ],
            selectedIndex: _selectedIndex,
            onTabChange: _onItemTapped,
          ),
        ),
      ),
    );
  }
}