import 'package:flutter/material.dart';

class ScrollPage extends StatelessWidget {
  const ScrollPage({super.key});
  final List<Map<String, String>> simulatedUsers = const [
    {
      "name": "David",
      "major": "Informatika",
      "hobbies": "Mendaki, Coding",
      "distance": "1.2 km",
      "status": "Sedang mencari teman ngopi."
    },
    {
      "name": "Eva",
      "major": "Arsitektur",
      "hobbies": "Menggambar, Fotografi",
      "distance": "500 m",
      "status": "Baru selesai kelas, ingin makan siang."
    },
    {
      "name": "Fahmi",
      "major": "Manajemen",
      "hobbies": "Bisnis, Gym",
      "distance": "3.5 km",
      "status": "Mencari teman diskusi bisnis."
    },
    {
      "name": "Gina",
      "major": "Seni Rupa",
      "hobbies": "Melukis, Musik",
      "distance": "800 m",
      "status": "Menyambut siapa saja yang suka seni."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temukan Pengguna Lain'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Memuat data pengguna baru...')),
              );
              // Nanti di sini akan memanggil Cubit/Bloc untuk fetch data
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: simulatedUsers.length,
        itemBuilder: (context, index) {
          final user = simulatedUsers[index];
          return UserProfileCard(user: user);
        },
      ),
    );
  }
}

class UserProfileCard extends StatelessWidget {
  final Map<String, String> user;

  const UserProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Text(user["name"]![0], style: const TextStyle(fontSize: 20)),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user["name"]!,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          user["major"]!,
                          style: const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    user["distance"]!,
                    style: TextStyle(color: Colors.blue.shade800, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 15),
            
            // Status/Hobi
            Text(
              user["status"]!,
              style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black87),
            ),
            const SizedBox(height: 10),
            
            // Hobi/Minat
            Wrap(
              spacing: 8.0,
              children: user["hobbies"]!.split(', ').map((hobby) => Chip(
                label: Text(hobby, style: const TextStyle(fontSize: 12)),
              )).toList(),
            ),
            
            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerRight,
              child: OutlinedButton.icon(
                onPressed: () {
                   ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Mengirim permintaan pertemanan ke ${user["name"]}')),
                    );
                },
                icon: const Icon(Icons.send),
                label: const Text('Connect'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}