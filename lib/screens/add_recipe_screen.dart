import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart'; // Add this import for kIsWeb
import '../services/firebase_storage_service.dart';
import '../services/firestore_service.dart';

final FirestoreService firestoreService = FirestoreService();
final FirebaseStorageService storageService = FirebaseStorageService();

class AddRecipeScreen extends StatefulWidget {
  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _nameController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  // Fungsi untuk memilih gambar dari galeri
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print("No image selected.");
      }
    });
  }

  // Fungsi untuk menambahkan resep ke Firestore
  Future<void> _addRecipe() async {
    if (_nameController.text.isEmpty ||
        _ingredientsController.text.isEmpty ||
        _instructionsController.text.isEmpty ||
        _imageFile == null) {
      // Pastikan semua field terisi
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Semua field harus diisi dan gambar harus dipilih"),
      ));
      return;
    }

    // Upload gambar dan ambil URL-nya
    String imageUrl = await storageService.uploadImage(_imageFile!);

    // Simpan resep ke Firestore
    await firestoreService.addRecipe(
      _nameController.text,
      imageUrl,
      _ingredientsController.text.split(','),
      _instructionsController.text.split(','),
      "user123", // Ganti dengan ID pengguna yang sesuai
    );

    // Tampilkan pesan sukses dan kembali ke layar sebelumnya
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Resep berhasil ditambahkan"),
    ));

    Navigator.pop(context); // Kembali ke layar sebelumnya
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Resep'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input Nama Resep
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nama Resep',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Input Bahan-bahan
              TextField(
                controller: _ingredientsController,
                decoration: InputDecoration(
                  labelText: 'Bahan-bahan (Pisahkan dengan koma)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Input Langkah-langkah
              TextField(
                controller: _instructionsController,
                decoration: InputDecoration(
                  labelText: 'Langkah-langkah (Pisahkan dengan koma)',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              // Pilih Gambar Resep
              GestureDetector(
                onTap: _pickImage,
                child: _imageFile == null
                    ? Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: Center(
                          child: Icon(
                            Icons.add_a_photo,
                            color: Colors.grey[600],
                          ),
                        ),
                      )
                    : (kIsWeb // Check if the app is running on the web
                        ? Image.network(
                            _imageFile!.path, // Use URL for web
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            _imageFile!,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )),
              ),
              SizedBox(height: 16),

              // Tombol Simpan Resep
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: _addRecipe,
                  child: Text('Upload'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}