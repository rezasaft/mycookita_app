import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:image_picker/image_picker.dart';
//import 'dart:io';
import '../widgets/recipe_card.dart';
import '../services/firebase_storage_service.dart';
import '../services/firestore_service.dart';
import 'add_recipe_screen.dart';  // Import layar AddRecipeScreen
import 'recipe_detail_screen.dart'; // Import file untuk tampilan detail resep
import '../profile/profile_page.dart'; // Import halaman profil

final FirestoreService firestoreService = FirestoreService();
final FirebaseStorageService storageService = FirebaseStorageService();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> recipes = [];
  List<Map<String, dynamic>> filteredRecipes = [];
  //final ImagePicker _picker = ImagePicker();
  int _selectedIndex = 0; // Track selected index in BottomNavigationBar

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  Future<void> _fetchRecipes() async {
    final snapshot = await FirebaseFirestore.instance.collection('recipes').get();
    final recipeList = snapshot.docs.map((doc) => doc.data()).toList();
    
    setState(() {
      recipes = recipeList;
      filteredRecipes = recipeList;
    });
  }

  void _filterRecipes(String query) {
    final results = recipes.where((recipe) {
      final nameLower = recipe["name"].toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    setState(() {
      filteredRecipes = results;
    });
  }

  // Handle BottomNavigationBar item tap
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      // Navigasi ke layar AddRecipeScreen ketika tab "Tambah Resep" dipilih
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AddRecipeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('background.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: 200,
                width: double.infinity,
                color: Colors.white.withOpacity(0.5),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'COOKITA\nTEMUKAN RESEP MASAKANMU!',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.person, color: Colors.black, size: 50),
                      onPressed: () {
                        // Navigasi ke halaman profil ketika ikon profil ditekan
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ProfilePage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterRecipes,
              decoration: InputDecoration(
                hintText: 'Cari',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Resep Populer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = filteredRecipes[index];
                return GestureDetector(
                  onTap: () {
                    // Navigasi ke layar detail resep
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailScreen(
                          recipeId: recipe['id'], // Kirimkan ID atau data resep yang relevan
                        ),
                      ),
                    );
                  },
                  child: RecipeCard(
                  name: recipe["name"],
                  image: recipe["image"],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Set the onTap callback here
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Tambah Resep'),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: 'Tersimpan'),
        ],
      ),
    );
  }
}
