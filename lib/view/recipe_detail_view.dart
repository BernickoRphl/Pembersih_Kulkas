import 'package:flutter/material.dart';

class RecipeDetailView extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetailView({super.key, required this.recipe});

  // Fungsi untuk menghapus tag HTML
  String removeHtmlTags(String htmlText) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
    return htmlText.replaceAll(exp, '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['title'] ?? 'Detail Resep'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Resep
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                recipe['image'] ?? 'https://via.placeholder.com/150',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200,
              ),
            ),
            const SizedBox(height: 16),

            // Judul Resep
            Text(
              recipe['title'] ?? 'No Title',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 8),

            // Waktu Persiapan
            Chip(
              label: Text(
                'Ready in ${recipe['readyInMinutes']} minutes',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.blue,
            ),
            const SizedBox(height: 16),

            // Summary
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Summary:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      removeHtmlTags(recipe['summary'] ?? 'No summary available.'),
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Ingredients
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ingredients:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: (recipe['extendedIngredients'] as List<dynamic>?)
                              ?.map((ingredient) => Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                                    child: Text(
                                      '- ${ingredient['original']}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ))
                              .toList() ??
                          [const Text('No ingredients available.')],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Instructions
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Instructions:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      removeHtmlTags(
                          recipe['instructions'] ?? 'No instructions available.'),
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}