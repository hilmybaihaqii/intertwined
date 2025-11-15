import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _selectedCriteria = 'Major';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _criteriaOptions = [
    'Major',
    'Faculty',
    'Personality Type',
    'Hobbies',
    'College Year',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mencari berdasarkan $_selectedCriteria: "$query"'),
        ),
      );
      // Di sini nanti akan memanggil SearchCubit.searchUsers(...)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Teman Berdasarkan Kriteria'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: _selectedCriteria,
              decoration: const InputDecoration(
                labelText: 'Cari Berdasarkan',
                border: OutlineInputBorder(),
              ),
              items: _criteriaOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCriteria = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan kata kunci...',
                      border: const OutlineInputBorder(),
                      labelText: _selectedCriteria,
                    ),
                    onSubmitted: (_) => _performSearch(),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 60,
                  child: ElevatedButton(
                    onPressed: _performSearch,
                    child: const Icon(Icons.search),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            const Text(
              'Hasil Pencarian:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            const Expanded(
              child: Center(
                child: Text('Masukkan kriteria pencarian untuk melihat teman.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}