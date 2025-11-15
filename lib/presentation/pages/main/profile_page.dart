// lib/presentation/pages/main/profile_page.dart (KODE DIPERBAIKI)

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../bloc/profile/profile_cubit.dart';
import '../../bloc/profile/profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    // 1. Hapus token otentikasi (WAJIB)
    await prefs.remove('auth_token');

    // 2. Hapus flag onboarding (agar melihat intro lagi)
    await prefs.remove('onboarding_completed');

    // 3. JANGAN HAPUS: 'profile_completed' harus tetap TRUE agar Login berikutnya langsung ke Dashboard
    await prefs.remove('profile_completed');

    if (context.mounted) {
      // Arahkan ke rute awal (Splash Page, yang akan menavigasi ke Onboarding)
      context.go('/onboarding');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: 'Logout',
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final data = state.profileData;
          final name = data['name'] ?? 'Nama Belum Diisi';
          final nickname = data['nickname'] ?? 'N/A';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const CircleAvatar(
                  radius: 60,
                  child: Icon(Icons.person, size: 60),
                ),
                const SizedBox(height: 20),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '@$nickname',
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const Divider(height: 40),

                _buildProfileDetail(
                  context,
                  Icons.cake,
                  'Tanggal Lahir',
                  data['birthdate'] ?? 'Belum ada data',
                ),
                _buildProfileDetail(
                  context,
                  Icons.badge,
                  'Tipe Kepribadian',
                  data['personality'] ?? 'Belum ada data',
                ),
                _buildProfileDetail(
                  context,
                  Icons.school,
                  'Major & Fakultas',
                  '${data['major'] ?? 'N/A'} - ${data['faculty'] ?? 'N/A'}',
                ),
                _buildProfileDetail(
                  context,
                  Icons.favorite,
                  'Golongan Darah',
                  data['blood_type'] ?? 'Belum ada data',
                ),
                _buildProfileDetail(
                  context,
                  Icons.sports_soccer,
                  'Hobi/Aktivitas Fun',
                  data['fun_activity'] ?? 'Belum ada data',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileDetail(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
    );
  }
}
