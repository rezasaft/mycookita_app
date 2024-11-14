import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseStorageService {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<String> uploadImage(File file) async {
    try {
      final ref = storage.ref().child('recipe_images/${DateTime.now().toString()}');
      await ref.putFile(file);
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      return '';
    }
  }
}
