// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:pembersih_kulkas/view/prompt_view.dart';

// class RecipeView extends StatefulWidget {
//   final String ingredients;

//   const RecipeView({super.key, required this.ingredients});

//   @override
//   State<RecipeView> createState() => _RecipeViewState();
// }

// class _RecipeViewState extends State<RecipeView> {
//   String _recipe = '';
//   bool _isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _fetchRecipe();
//   }

//   Future<void> _fetchRecipe() async {
//     try {
//       // Convert comma-separated string to array
//       List<String> ingredients = widget.ingredients
//           .split(',')
//           .map((e) => e.trim())
//           .where((e) => e.isNotEmpty)
//           .toList();

//       // Fetch recipe from Laravel backend
//       final response = await http.post(
//         Uri.parse('http://10.0.2.2:8000/generate/send'),
//         headers: {
//           'Content-Type': 'application/json',
//           'Accept': 'application/json',
//         },
//         body: jsonEncode({
//           'ingredients': ingredients,
//           'user_id': '1', // Replace with the actual user ID
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         print('Response from Laravel: $data'); // For debugging

//         if (data['status'] == 'success' && data['data'] != null) {
//           final recipe = data['data']['ai_response']['message'];

//           // Save the recipe to Firebase Firestore
//           await _saveRecipeToFirebase(recipe);

//           setState(() {
//             _recipe = recipe;
//             _isLoading = false;
//           });
//         } else {
//           setState(() {
//             _recipe = 'Terjadi kesalahan: ${data['message']}';
//             _isLoading = false;
//           });
//         }
//       } else {
//         setState(() {
//           _recipe = 'Error: ${response.statusCode}';
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _recipe = 'Terjadi kesalahan: $e';
//         _isLoading = false;
//       });
//       print('Error connecting to server: $e');
//     }
//   }

//   Future<void> _saveRecipeToFirebase(String recipe) async {
//     try {
//       final user = FirebaseAuth.instance.currentUser;
//       if (user != null) {
//         final userId = user.uid;

//         // Add the recipe to the user's history in Firestore
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(userId)
//             .update({
//           'history': FieldValue.arrayUnion([recipe]),
//         });

//         print('Recipe saved to Firebase history.');
//       } else {
//         print('No user is currently logged in.');
//       }
//     } catch (e) {
//       print('Error saving recipe to Firebase: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Hasil Resep'),
//         automaticallyImplyLeading: false,
//       ),
//       body: _isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     _recipe,
//                     style: const TextStyle(fontSize: 16),
//                   ),
//                   const SizedBox(height: 20),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           // Navigate back to PromptView
//                           Navigator.pushReplacement(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => const PromptView(),
//                             ),
//                           );
//                         },
//                         child: const Text('Prompt Kembali'),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Navigate back to the home page
//                           Navigator.popUntil(context, (route) => route.isFirst);
//                         },
//                         child: const Text('Kembali ke Home'),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
          'user_id': '1',
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success' && data['data'] != null) {
          final recipe = data['data']['ai_response']['message'];
          await _saveRecipeToFirebase(recipe);

          setState(() {
            _recipe = recipe;
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
    }
  }

  Future<void> _saveRecipeToFirebase(String recipe) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userId = user.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .update({
          'history': FieldValue.arrayUnion([recipe]),
        });
      }
    } catch (e) {
      print('Error saving recipe to Firebase: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hasil Resep',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Color(0xFF9FC5B2),
        centerTitle: true,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: Color(0xFF9FC5B2)),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Text(
                          _recipe,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF9FC5B2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PromptView(),
                            ),
                          );
                        },
                        child: const Text(
                          'Prompt Kembali',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF9FC5B2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: const Text(
                          'Kembali ke Home',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
      backgroundColor: const Color(0xFFF0F4F7),
    );
  }
}
