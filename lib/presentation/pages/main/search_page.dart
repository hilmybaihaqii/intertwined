import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.creamyWhite,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Cari Teman',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.deepBrown,
              ),
            ),
            Text(
              'Temukan teman baru berdasarkan kriteria.',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.deepBrown.withAlpha(150),
              ),
            ),
            const SizedBox(height: 24),
            DropdownButtonFormField<String>(
              initialValue: _selectedCriteria,
              decoration: InputDecoration(
                labelText: 'Cari Berdasarkan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Masukkan kata kunci...',
                      labelText: _selectedCriteria,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onFieldSubmitted: (_) => _performSearch(),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 58,
                  child: ElevatedButton(
                    onPressed: _performSearch,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.deepBrown,
                      foregroundColor: AppColors.creamyWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Icon(Icons.search),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Hasil Pencarian:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.deepBrown,
              ),
            ),
            const Divider(thickness: 1, height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Text(
                  'Masukkan kriteria pencarian untuk melihat teman.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    color: AppColors.deepBrown.withAlpha(150),
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
