import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/match_model.dart'; // Pastikan import modelnya

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamyWhite,
      appBar: AppBar(
        title: const Text(
          "Messages",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.deepBrown,
          ),
        ),
        backgroundColor: AppColors.creamyWhite,
        iconTheme: const IconThemeData(
          color: AppColors.deepBrown,
        ),
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: dummyMatches.length,
        separatorBuilder: (context, index) => Divider(
          color: AppColors.deepBrown.withValues(alpha: 0.1),
          height: 1,
          indent: 70, // Memberi jarak garis dari kiri agar rapi
        ),
        itemBuilder: (context, index) {
          final user = dummyMatches[index];

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20, 
              vertical: 8
            ),
            // Foto Profil
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(user.imageUrl),
              backgroundColor: AppColors.softTerracotta, // Fallback color
            ),
            // Nama User
            title: Text(
              user.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.deepBrown,
                fontSize: 16,
              ),
            ),
            // Pesan Terakhir
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                user.lastMessage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppColors.deepBrown.withValues(alpha: 0.6),
                  fontSize: 14,
                ),
              ),
            ),
            // Waktu
            trailing: Text(
              user.time,
              style: TextStyle(
                color: AppColors.deepBrown.withValues(alpha: 0.4),
                fontSize: 12,
              ),
            ),
            // Navigasi ke Detail Chat
            onTap: () {
              context.pushNamed(
                'chat_detail',
                extra: user, // Mengirim object user ke halaman detail
              );
            },
          );
        },
      ),
    );
  }
}