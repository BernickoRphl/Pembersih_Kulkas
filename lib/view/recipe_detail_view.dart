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
        centerTitle: true,
        backgroundColor: Color(0xFF9FC5B2),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar dengan border dan shadow
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 2),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  recipe['image'] ?? 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              ),
            ),
            SizedBox(height: 16),

            // Judul
            Text(
              recipe['title'] ?? 'No Title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),

            // Informasi waktu
            Text(
              'Ready in ${recipe['readyInMinutes']} minutes',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),

            // Divider untuk memisahkan bagian
            Divider(color: Colors.grey.shade400, thickness: 1),

            // Summary
            Text(
              'Summary:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              removeHtmlTags(recipe['summary'] ?? 'No summary available.'),
              style: TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 16),

            Divider(color: Colors.grey.shade400, thickness: 1),

            // Ingredients
            Text(
              'Ingredients:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (recipe['extendedIngredients'] as List<dynamic>?)
                      ?.map((ingredient) => Text(
                            '- ${ingredient['original']}',
                            style: TextStyle(fontSize: 16, color: Colors.black87),
                            textAlign: TextAlign.justify,
                          ))
                      .toList() ??
                  [Text('No ingredients available.', textAlign: TextAlign.justify)],
            ),
            SizedBox(height: 16),

            Divider(color: Colors.grey.shade400, thickness: 1),

            // Instructions
            Text(
              'Instructions:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 8),
            Text(
              removeHtmlTags(
                  recipe['instructions'] ?? 'No instructions available.'),
              style: TextStyle(fontSize: 16, color: Colors.black87),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}