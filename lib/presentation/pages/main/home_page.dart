import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home (Feed Utama)'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.location_on, size: 80, color: Colors.blueGrey),
            const SizedBox(height: 20),
            const Text(
              'Home Page',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Maps/Geofencing akan diimplementasikan di sini.',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Selamat datang di Home Page!')),
                );
              },
              child: const Text('Refresh Feed'),
            ),
          ],
        ),
      ),
    );
  }
}