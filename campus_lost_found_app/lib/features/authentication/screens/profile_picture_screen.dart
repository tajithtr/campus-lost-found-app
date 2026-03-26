import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePictureScreen extends StatefulWidget {
  const ProfilePictureScreen({super.key});

  @override
  State<ProfilePictureScreen> createState() => _ProfilePictureScreenState();
}

class _ProfilePictureScreenState extends State<ProfilePictureScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  // camera access
  Future<void> _pickFromCamera() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  // gallery access
  Future<void> _pickFromGallery() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        title: const Text("Add Profile Picture"),
        foregroundColor: Colors.white,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 30),

            // Profile picture preview
            CircleAvatar(
              radius: 70,
              backgroundColor: Colors.grey,
              backgroundImage: _image != null ? FileImage(_image!) : null,
              child: _image == null
                  ? const Icon(Icons.person, size: 70, color: Colors.white)
                  : null,
            ),

            const SizedBox(height: 40),

            // gallery button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _pickFromGallery,
                icon: const Icon(Icons.image, color: Colors.white),
                label: const Text(
                  "Choose from Gallery",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF254EBA),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // camera button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _pickFromCamera,
                icon: const Icon(Icons.camera_alt, color: Colors.white),
                label: const Text(
                  "Take a Photo",
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),

            const Spacer(),

            //  Done Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _image);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF254EBA),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Done",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
