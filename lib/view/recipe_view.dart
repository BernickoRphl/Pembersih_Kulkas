import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:pembersih_kulkas/view/prompt_view.dart';

class RecipeView extends StatefulWidget {
  final String ingredients;

  const RecipeView({super.key, required this.ingredients});

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  String _recipe = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRecipe();
  }

  Future<void> _fetchRecipe() async {
    try {
      // Convert comma-separated string to array
      List<String> ingredients = widget.ingredients
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/generate/send'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'ingredients': ingredients,
          'user_id': '1', // Ganti dengan user ID yang sesuai
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Response from Laravel: $data'); // Untuk debugging

        if (data['status'] == 'success' && data['data'] != null) {
          setState(() {
            _recipe = data['data']['ai_response']['message'];
            _isLoading = false;
          });
        } else {
          setState(() {
            _recipe = 'Terjadi kesalahan: ${data['message']}';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _recipe = 'Error: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _recipe = 'Terjadi kesalahan: $e';
        _isLoading = false;
      });
      print('Error connecting to server: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Resep'),
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              // Tambahkan SingleChildScrollView untuk mengatasi overflow
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _recipe,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Kembali ke halaman PromptPage
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PromptView(),
                              ),
                            );
                          },
                          child: const Text('Prompt Kembali'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Kembali ke halaman Home (misalnya, halaman utama aplikasi)
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          },
                          child: const Text('Kembali ke Home'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40)
                  ],
                ),
              ),
            ),
    );
  }
}
