import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addRecipe(String name, String imageUrl, List<String> ingredients, List<String> instructions, String userId) async {
    try {
      await firestore.collection('recipes').add({
        'name': name,
        'image': imageUrl,
        'ingredients': ingredients,
        'instructions': instructions,
        'userId': userId,
      });
      print("Recipe added successfully!");
    } catch (e) {
      print("Error adding recipe: $e");
    }
  }
}
