import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart'; // Pastikan path ini benar

// FIX 1: Ganti nama class dari _NewsItem menjadi NewsItem (publik)
class NewsItem {
  final String title;
  final String date;
  final IconData icon;
  final Color color;
  final String type;

  const NewsItem({
    required this.title,
    required this.date,
    required this.icon,
    required this.color,
    required this.type,
  });
}

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  // FIX 2: Gunakan class NewsItem yang publik
  static final List<NewsItem> newsItems = [
    const NewsItem(
      title: "Pengumuman: Maintenance Server Malam Ini",
      date: "15 November 2025",
      icon: Icons.warning_amber,
      color: Colors.orange,
      type: "System",
    ),
    const NewsItem(
      title: "Acara 'Meet & Greet' Mahasiswa Baru Fakultas Teknik",
      date: "20 November 2025",
      icon: Icons.event,
      color: Colors.green,
      type: "Event",
    ),
    const NewsItem(
      title: "Tips Efektif Mencari Teman Berdasarkan Hobi",
      date: "10 November 2025",
      icon: Icons.lightbulb_outline,
      color: Colors.blue,
      type: "Tips",
    ),
    const NewsItem(
      title: "Lowongan Relawan untuk Acara Kampus",
      date: "05 November 2025",
      icon: Icons.volunteer_activism,
      color: Colors.purple,
      type: "Komunitas",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // FIX 3: Hapus Scaffold dan AppBar. Mulai dengan Container.
    return Container(
      color: AppColors.creamyWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tambahkan Judul di sini (pengganti AppBar)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Text(
              'Pengumuman & Info',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.deepBrown,
              ),
            ),
          ),
          // Gunakan Expanded agar ListView mengisi sisa ruang
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              itemCount: newsItems.length,
              itemBuilder: (context, index) {
                final item = newsItems[index];
                return NewsCard(item: item);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  // FIX 4: Gunakan class NewsItem yang publik
  final NewsItem item;

  const NewsCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.only(bottom: 12.0),
      color: AppColors.creamyWhite,
      shadowColor: Colors.black.withAlpha(26),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        leading: CircleAvatar(
          backgroundColor: item.color.withAlpha(26), // 10% opacity
          child: Icon(item.icon, color: item.color),
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.deepBrown,
            fontSize: 15,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              item.date,
              style: TextStyle(
                color: AppColors.deepBrown.withAlpha(150),
                fontSize: 12,
              ),
            ),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: item.color,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            item.type,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Membaca detail: ${item.title}')),
          );
        },
      ),
    );
  }
}
