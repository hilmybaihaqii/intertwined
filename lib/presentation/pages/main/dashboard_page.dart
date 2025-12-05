import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter
import '../../../core/constants/app_colors.dart';

// Import Custom Widgets
import '../../widgets/custom_bottom_nav.dart';
import '../../widgets/custom_top_app_bar.dart';

// Import Pages
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

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const HomePage();
      case 1:
        return const SearchPage();
      case 2:
        return const ScrollPage();
      case 3:
        return const NewsPage();
      case 4:
        return const ProfilePage();
      default:
        return const HomePage();
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
      extendBody: true,

      // --- CUSTOM TOP APP BAR ---
      appBar: CustomTopAppBar(
        onMessageTap: () {
          // NAVIGASI KE HALAMAN MESSAGE
          // Pastikan route '/message' sudah ada di GoRouter config
          context.push('/message');
        },
        onProfileTap: () {
          _onItemTapped(4);
        },
      ),

      body: _buildPage(_selectedIndex),

      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onItemSelected: _onItemTapped,
      ),
    );
  }
}
