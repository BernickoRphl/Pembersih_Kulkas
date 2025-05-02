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
            children: [
              TextFormField(
                controller: _ingredientsController,
                decoration: const InputDecoration(
                  labelText: 'Masukkan bahan (pisahkan dengan koma)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan bahan-bahan terlebih dahulu';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
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
                child: const Text('Buat Resep'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
