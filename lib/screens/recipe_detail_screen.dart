import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String recipeId; // Ambil ID resep dari parameter konstruktor

  RecipeDetailScreen({required this.recipeId});

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late DocumentSnapshot recipeDetail;

  @override
  void initState() {
    super.initState();
    _fetchRecipeDetail();
  }

  // Fungsi untuk mengambil detail resep dari Firestore
  Future<void> _fetchRecipeDetail() async {
    final doc = await FirebaseFirestore.instance
        .collection('recipes')
        .doc(widget.recipeId) // Gunakan ID resep yang dikirim
        .get();
    setState(() {
      recipeDetail = doc;
    });
  }

  @override
  Widget build(BuildContext context) {
    //if (recipeDetail == null) {
      //return Scaffold(
        //appBar: AppBar(title: Text("Detail Resep")),
        //body: Center(child: CircularProgressIndicator()),
      //);
    //}

    return Scaffold(
      appBar: AppBar(
        title: Text(recipeDetail["name"]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(recipeDetail["image"]), // Tampilkan gambar resep
            SizedBox(height: 16),
            Text(
              recipeDetail["name"],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              "Bahan-bahan:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...List.generate(
              recipeDetail["ingredients"].length,
              (index) => Text(recipeDetail["ingredients"][index]),
            ),
            SizedBox(height: 16),
            Text(
              "Cara Memasak:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...List.generate(
              recipeDetail["instructions"].length,
              (index) => Text(recipeDetail["instructions"][index]),
            ),
          ],
        ),
      ),
    );
  }
}
