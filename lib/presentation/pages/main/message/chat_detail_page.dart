import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/models/match_model.dart'; // Pastikan import model ini benar

// Model sederhana untuk pesan chat (hanya untuk dummy data di halaman ini)
class ChatMessage {
  final String text;
  final String time;
  final bool isMe; // true jika pesan dari kita, false jika dari lawan bicara

  ChatMessage({required this.text, required this.time, required this.isMe});
}

class ChatDetailPage extends StatefulWidget {
  final MatchUser user;

  const ChatDetailPage({super.key, required this.user});

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  // Data dummy percakapan (sesuai gambar contoh)
  final List<ChatMessage> _messages = [
    ChatMessage(
      text:
          "Hi Jake, how are you? I saw on the app that we've crossed paths several times this week 😊",
      time: "2:55 PM",
      isMe: false, // Pesan dari Grace
    ),
    ChatMessage(
      text:
          "Haha truly! Nice to meet you Grace! What about a cup of coffee today evening? ☕",
      time: "3:02 PM",
      isMe: true, // Pesan dari Kita
    ),
    ChatMessage(text: "Sure, let's do it! 😋", time: "3:10 PM", isMe: false),
    ChatMessage(
      text: "Great I will write later the exact time and place. See you soon!",
      time: "3:12 PM",
      isMe: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamyWhite, // Warna background chat
      appBar: AppBar(
        backgroundColor: AppColors.creamyWhite,
        elevation: 1,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: AppColors.deepBrown),
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.user.imageUrl),
              radius: 18,
              backgroundColor: AppColors.softTerracotta,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.name,
                  style: const TextStyle(
                    color: AppColors.deepBrown,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Online", // Status statis untuk contoh
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert_rounded), // Icon titik tiga
          ),
        ],
      ),
      // Body menggunakan Column agar bisa menaruh input field di bawah
      body: Column(
        children: [
          // Bagian List Pesan (menggunakan Expanded agar mengisi ruang)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildChatBubble(message);
              },
            ),
          ),

          // Bagian Input Field di Bawah
          _buildMessageInput(),
        ],
      ),
    );
  }

  // Widget untuk membangun satu bubble chat
  Widget _buildChatBubble(ChatMessage message) {
    return Align(
      // Jika pesan dari kita, align ke kanan. Jika tidak, ke kiri.
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        // Batasi lebar bubble chat agar tidak terlalu penuh
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.7,
        ),
        child: Column(
          crossAxisAlignment: message.isMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            // Container Bubble
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                // Warna bubble: Kuning untuk kita, Abu-abu untuk lawan
                color: message.isMe
                    ? AppColors.sunnyYellow
                    : AppColors
                          .lightGrey, // Pakai lightGrey atau buat warna baru (misal: Color(0xFFF2F2F2))
                // Bentuk sudut bubble chat
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: message.isMe
                      ? const Radius.circular(20)
                      : const Radius.circular(0),
                  bottomRight: message.isMe
                      ? const Radius.circular(0)
                      : const Radius.circular(20),
                ),
              ),
              child: Text(
                message.text,
                style: TextStyle(
                  // Warna teks: Coklat tua agar kontras
                  color: AppColors.deepBrown,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 5),
            // Waktu Pesan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                message.time,
                style: TextStyle(
                  color: AppColors.deepBrown.withValues(alpha: 0.5),
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk input field di bagian bawah
  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.creamyWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2), // Shadow ke arah atas
          ),
        ],
      ),
      child: Row(
        children: [
          // TextField untuk mengetik pesan
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Your message",
                hintStyle: TextStyle(
                  color: AppColors.deepBrown.withValues(alpha: 0.4),
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30), // Bentuk bulat
                  borderSide: BorderSide.none, // Hilangkan garis border
                ),
                // Icon sticker di kanan dalam textfield
                suffixIcon: Icon(
                  Icons.sticky_note_2_outlined,
                  color: AppColors.deepBrown.withValues(alpha: 0.4),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Tombol Microphone Bulat
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withValues(alpha: 0.1),
                  blurRadius: 2,
                ),
              ],
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.mic_rounded),
              color: AppColors.deepBrown,
              padding: const EdgeInsets.all(12),
            ),
          ),
        ],
      ),
    );
  }
}
