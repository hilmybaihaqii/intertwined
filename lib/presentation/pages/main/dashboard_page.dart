import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../../../core/constants/app_colors.dart';

// Pastikan semua file ini ada di folder 'main'
import 'home_page.dart';
import 'search_page.dart';
import 'scroll_page.dart';
import 'news_page.dart.dart'; // Error Anda ada di sini. Pastikan path-nya benar.
import 'profile_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    ScrollPage(),
    NewsPage(),
    ProfilePage(),
  ];

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
      body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.creamyWhite,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              // FIX: Mengganti withOpacity(.1) dengan withAlpha(26)
              color: Colors.black.withAlpha(26),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 8.0,
            ),
            child: GNav(
              gap: 8,
              activeColor: AppColors.creamyWhite,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
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
      ),
    );
  }
}
