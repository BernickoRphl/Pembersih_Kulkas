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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.popUntil(
              context,
              (route) => route.settings.name == '/',
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              recipe['image'] ?? 'https://via.placeholder.com/150',
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
            SizedBox(height: 16),
            Text(
              recipe['title'] ?? 'No Title',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Ready in ${recipe['readyInMinutes']} minutes',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Summary:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              removeHtmlTags(recipe['summary'] ?? 'No summary available.'),
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Ingredients:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: (recipe['extendedIngredients'] as List<dynamic>?)
                      ?.map((ingredient) => Text(
                            '- ${ingredient['original']}',
                            style: TextStyle(fontSize: 16),
                          ))
                      .toList() ??
                  [Text('No ingredients available.')],
            ),
            SizedBox(height: 16),
            Text(
              'Instructions:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Text(
              removeHtmlTags(
                  recipe['instructions'] ?? 'No instructions available.'),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
