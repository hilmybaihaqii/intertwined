import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart'; // Pastikan path ini benar

// FIX 1: Ganti nama class dari _SimulatedUser menjadi SimulatedUser (publik)
class SimulatedUser {
  final String name;
  final String major;
  final String hobbies;
  final String distance;
  final String status;

  const SimulatedUser({
    required this.name,
    required this.major,
    required this.hobbies,
    required this.distance,
    required this.status,
  });
}

class ScrollPage extends StatelessWidget {
  const ScrollPage({super.key});

  // FIX 2: Buat list menggunakan class SimulatedUser, bukan Map
  final List<SimulatedUser> simulatedUsers = const [
    SimulatedUser(
      name: "David",
      major: "Informatika",
      hobbies: "Mendaki, Coding",
      distance: "1.2 km",
      status: "Sedang mencari teman ngopi.",
    ),
    SimulatedUser(
      name: "Eva",
      major: "Arsitektur",
      hobbies: "Menggambar, Fotografi",
      distance: "500 m",
      status: "Baru selesai kelas, ingin makan siang.",
    ),
    SimulatedUser(
      name: "Fahmi",
      major: "Manajemen",
      hobbies: "Bisnis, Gym",
      distance: "3.5 km",
      status: "Mencari teman diskusi bisnis.",
    ),
    SimulatedUser(
      name: "Gina",
      major: "Seni Rupa",
      hobbies: "Melukis, Musik",
      distance: "800 m",
      status: "Menyambut siapa saja yang suka seni.",
    ),
  ];

  void _refreshUsers(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Memuat data pengguna baru...')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.creamyWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Explore',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepBrown,
                      ),
                    ),
                    Text(
                      'Temukan pengguna lain di sekitarmu.',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.deepBrown,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.refresh, color: AppColors.deepBrown),
                  onPressed: () => _refreshUsers(context),
                  tooltip: 'Refresh',
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              itemCount: simulatedUsers.length,
              itemBuilder: (context, index) {
                final user = simulatedUsers[index];
                return UserProfileCard(user: user);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileCard extends StatelessWidget {
  // FIX 3: Gunakan class publik SimulatedUser
  final SimulatedUser user;

  const UserProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16.0),
      color: Colors.white,
      shadowColor: Colors.black.withAlpha(26),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.deepBrown.withAlpha(50),
                      child: Text(
                        user.name[0],
                        style: const TextStyle(
                          fontSize: 22,
                          color: AppColors.deepBrown,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColors.deepBrown,
                          ),
                        ),
                        Text(
                          user.major,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.deepBrown.withAlpha(150),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.deepBrown.withAlpha(30),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    user.distance,
                    style: const TextStyle(
                      color: AppColors.deepBrown,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              '"${user.status}"',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: AppColors.deepBrown.withAlpha(200),
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: user.hobbies
                  .split(', ')
                  .map(
                    (hobby) => Chip(
                      label: Text(hobby),
                      backgroundColor: AppColors.deepBrown.withAlpha(26),
                      labelStyle: const TextStyle(
                        color: AppColors.deepBrown,
                        fontSize: 12,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Mengirim permintaan pertemanan ke ${user.name}',
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.send_outlined, size: 18),
                label: const Text('Connect'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.deepBrown,
                  side: BorderSide(color: AppColors.deepBrown.withAlpha(100)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
