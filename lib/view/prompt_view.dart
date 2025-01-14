import 'package:flutter/material.dart';
import 'recipe_view.dart';

class PromptView extends StatefulWidget {
  const PromptView({super.key});

  @override
  State<PromptView> createState() => _PromptViewState();
}

class _PromptViewState extends State<PromptView> {
  final _formKey = GlobalKey<FormState>();
  final _ingredientsController = TextEditingController();

  @override
  void dispose() {
    _ingredientsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Judul Input
              const Text(
                'Masukkan Bahan-bahan Anda',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Pisahkan bahan-bahan dengan koma (,)',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),

              // Input Field
              TextFormField(
                controller: _ingredientsController,
                decoration: InputDecoration(
                  labelText: 'Contoh: Telur, Tepung, Gula',
                  labelStyle: const TextStyle(color: Colors.blueAccent),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blueAccent),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan bahan-bahan terlebih dahulu';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Tombol Buat Resep
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeView(
                          ingredients: _ingredientsController.text,
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Buat Resep',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Opsi Alternatif
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}