import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pembersih_kulkas/view/profile_view.dart';
import 'package:pembersih_kulkas/view/prompt_view.dart';
import 'dart:convert';

import 'package:pembersih_kulkas/view/recipe_detail_view.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;

  // Daftar halaman yang akan ditampilkan
  final List<Widget> _pages = [
    RecipeGrid(), // Halaman Beranda
    PromptView(), // Halaman Buat Resep
    ProfilePage(), // Halaman Profile
  ];

  // Daftar judul AppBar untuk setiap halaman
  final List<String> _appBarTitles = [
    'List Resep', // Judul untuk Beranda
    'Buat Resep Baru', // Judul untuk Buat Resep
    'Profil Saya', // Judul untuk Profile
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Menghilangkan tombol back
        title: Text(
          _appBarTitles[_selectedIndex], // Judul AppBar dinamis
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 4,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blue),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Colors.blue),
            label: 'Buat Resep',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blue),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class RecipeGrid extends StatefulWidget {
  @override
  _RecipeGridState createState() => _RecipeGridState();
}

class _RecipeGridState extends State<RecipeGrid> {
  List<Map<String, dynamic>> recipes = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  Future<void> _fetchRecipes() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/recipes'),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Parsed data: $data');

        setState(() {
          recipes =
              List<Map<String, dynamic>>.from(data); // Parsing array resep
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load recipes: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching recipes: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<Map<String, dynamic>> _fetchRecipeDetail(int id) async {
    try {
      // Ganti dengan endpoint API backend Anda untuk mengambil detail resep
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8000/recipes/$id'),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Parsed detail data: $data');
        return data; // Kembalikan data detail resep
      } else {
        throw Exception('Failed to load recipe detail: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching recipe detail: $e');
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator(color: Colors.blue))
        : recipes.isEmpty
            ? Center(child: Text('Tidak ada resep yang ditemukan.'))
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: recipes.length,
                  itemBuilder: (context, index) {
                    final recipe = recipes[index];
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(8),
                        onTap: () async {
                          // Ambil detail resep berdasarkan ID
                          try {
                            final recipeDetail =
                                await _fetchRecipeDetail(recipe['id']);
                            // Navigasi ke halaman detail resep
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RecipeDetailView(recipe: recipeDetail),
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(8),
                                ),
                                child: Image.network(
                                  recipe['image'] ??
                                      'https://via.placeholder.com/150',
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    recipe['title'] ?? 'No Title',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
  }
}