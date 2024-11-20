import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingsPage(), // Changed to SettingsPage
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Pengaturan',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          // Username section
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[400],
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 16),
                Text(
                  'Username',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          
          // Menu items
          ListTile(
            leading: Icon(Icons.person_outline),
            title: Text('Akun'),
            onTap: () {
              // Handle akun tap
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark_outline),
            title: Text('Tersimpan'),
            onTap: () {
              // Handle tersimpan tap
            },
          ),
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('Tentang Kami'),
            onTap: () {
              // Handle tentang kami tap
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Keluar'),
            onTap: () {
              // Handle keluar tap
            },
          ),
        ],
      ),
    );
  }
}