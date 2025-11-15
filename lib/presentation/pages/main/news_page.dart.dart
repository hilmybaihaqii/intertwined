// lib/presentation/pages/main/news_page.dart

import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  final List<Map<String, dynamic>> newsItems = const [
    {
      "title": "Pengumuman: Maintenance Server Malam Ini",
      "date": "15 November 2025",
      "icon": Icons.warning_amber,
      "color": Colors.orange,
      "type": "System"
    },
    {
      "title": "Acara 'Meet & Greet' Mahasiswa Baru Fakultas Teknik",
      "date": "20 November 2025",
      "icon": Icons.event,
      "color": Colors.green,
      "type": "Event"
    },
    {
      "title": "Tips Efektif Mencari Teman Berdasarkan Hobi",
      "date": "10 November 2025",
      "icon": Icons.lightbulb_outline,
      "color": Colors.blue,
      "type": "Tips"
    },
    {
      "title": "Lowongan Relawan untuk Acara Kampus",
      "date": "05 November 2025",
      "icon": Icons.volunteer_activism,
      "color": Colors.purple,
      "type": "Komunitas"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengumuman & Info Komunitas'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: newsItems.length,
        itemBuilder: (context, index) {
          final item = newsItems[index];
          return NewsCard(item: item);
        },
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final Map<String, dynamic> item;

  const NewsCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: item["color"].withOpacity(0.1),
          child: Icon(item["icon"], color: item["color"]),
        ),
        title: Text(
          item["title"],
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(item["date"]),
          ],
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: item["color"],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            item["type"],
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Membaca detail: ${item["title"]}')),
          );
        },
      ),
    );
  }
}