import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/profile/profile_cubit.dart';
import '../../bloc/profile/profile_state.dart';
import '../../../core/constants/app_colors.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _logout(BuildContext context) {
    context.read<AuthCubit>().logout();
    if (context.mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    // --- Scaffold & AppBar DIHAPUS ---
    // Widget terluar sekarang adalah Container atau BlocBuilder
    return Container(
      color: AppColors.creamyWhite, // Beri background agar konsisten
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.deepBrown),
            );
          }

          final data = state.profileData;
          final name = data['name'] ?? 'Nama Belum Diisi';
          final nickname = data['nickname'] ?? 'N/A';
          final birthdate = data['birthdate'] ?? 'Belum ada data';
          final personality = data['personality'] ?? 'Belum ada data';
          final major = data['major'] ?? 'N/A';
          final faculty = data['faculty'] ?? 'N/A';
          final bloodType = data['blood_type'] ?? 'Belum ada data';
          final funActivity = data['fun_activity'] ?? 'Belum ada data';

          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Tambahkan tombol Logout di sini jika perlu,
                // karena AppBar-nya sudah hilang
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.logout, color: AppColors.deepBrown),
                    onPressed: () => _logout(context),
                    tooltip: 'Logout',
                  ),
                ),
                const SizedBox(height: 8),

                CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColors.deepBrown.withAlpha(50),
                  child: const Icon(
                    Icons.person_rounded,
                    size: 60,
                    color: AppColors.deepBrown,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.deepBrown,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '@$nickname',
                  style: TextStyle(
                    fontSize: 17,
                    color: AppColors.deepBrown.withAlpha(150),
                  ),
                ),
                const Divider(height: 40, color: Color(0xFFE0E0E0)),
                _buildProfileDetail(
                  Icons.cake_outlined,
                  'Tanggal Lahir',
                  birthdate,
                ),
                _buildProfileDetail(
                  Icons.badge_outlined,
                  'Tipe Kepribadian',
                  personality,
                ),
                _buildProfileDetail(
                  Icons.school_outlined,
                  'Major & Fakultas',
                  '$major - $faculty',
                ),
                _buildProfileDetail(
                  Icons.water_drop_outlined,
                  'Golongan Darah',
                  bloodType,
                ),
                _buildProfileDetail(
                  Icons.sports_soccer_outlined,
                  'Hobi/Aktivitas Fun',
                  funActivity,
                ),
                const SizedBox(height: 20), // Padding ekstra di bawah
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileDetail(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: AppColors.deepBrown, size: 28),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.deepBrown.withAlpha(200),
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            color: AppColors.deepBrown,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
