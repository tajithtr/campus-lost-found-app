import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import '../../../widgets/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool notificationOn = true;
  String name = "User";
  String imageBase64 = "";
  bool isLoading = true;

  final ImagePicker _picker = ImagePicker();

  void _showImageOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Choose from Gallery"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text("Take Photo"),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text("Remove Photo"),
                onTap: () {
                  Navigator.pop(context);
                  _removeImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile == null) return;

    final bytes = await File(pickedFile.path).readAsBytes();
    final base64Image = base64Encode(bytes);

    await _updateImageInFirestore(base64Image);
  }

  //  Remove image
  Future<void> _removeImage() async {
    await _updateImageInFirestore("");
  }

  //  Update Firestore
  Future<void> _updateImageInFirestore(String base64Image) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
      'imageBase64': base64Image,
    });

    setState(() {
      imageBase64 = base64Image;
    });
  }

  int _selectedIndex = 3;

  Future<void> loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;

    try {
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (doc.exists && doc.data() != null) {
          final data = doc.data();

          setState(() {
            name = data?['name'] ?? "User";
            imageBase64 = data?['imageBase64'] ?? "";
          });
        }
      }
    } catch (e) {
      // Handling error
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void _onBottomNavTap(int index) {
    if (index == _selectedIndex) return;

    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, AppRoutes.lostItems);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, AppRoutes.foundItems);
        break;
      case 3:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1F3C88),
      body: Column(
        children: [
          const SizedBox(height: 60),

          GestureDetector(
            onTap: _showImageOptions,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: imageBase64.isNotEmpty
                      ? MemoryImage(base64Decode(imageBase64))
                      : null,
                  child: imageBase64.isEmpty
                      ? const Icon(Icons.person, size: 40)
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 16,
                      color: Color(0xFF2F4FB2),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            "Hello, $name 👋",
            style: const TextStyle(color: Colors.white70),
          ),

          const Text(
            "Welcome to Campus\nLost & Found",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 30),

          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFF5F6FA),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  _menuTile(
                    Icons.description_outlined,
                    "My Reports",
                    onTap: () {
                      final user = FirebaseAuth.instance.currentUser;
                      String userId = user?.uid ?? "";

                      AppRoutes.goTo(
                        context,
                        AppRoutes.myReportsLost,
                        arguments: userId,
                      );
                    },
                  ),
                  const Divider(),
                  _menuTile(
                    Icons.lock_outline,
                    "Change Password",
                    onTap: () {
                      final user = FirebaseAuth.instance.currentUser;
                      String email = user?.email ?? "";

                      AppRoutes.goTo(
                        context,
                        AppRoutes.forgotPassword,
                        arguments: email,
                      );
                    },
                  ),
                  const Divider(),
                  _notificationTile(),
                  const Divider(),
                  _logoutTile(context),
                ],
              ),
            ),
          ),
        ],
      ),

      bottomNavigationBar: AppNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }

  Widget _menuTile(IconData icon, String text, {VoidCallback? onTap}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFE6ECFF),
        child: Icon(icon, color: const Color(0xFF2F4FB2)),
      ),
      title: Text(text, style: const TextStyle(color: Colors.black)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  Widget _notificationTile() {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFF0F4FF),
        child: const Icon(
          Icons.notifications_outlined,
          size: 20,
          color: Color(0xFF2F4FB2),
        ),
      ),
      title: const Text("Notification", style: TextStyle(color: Colors.black)),
      trailing: Switch(
        value: notificationOn,
        onChanged: (value) {
          setState(() {
            notificationOn = value;
          });
        },
        activeThumbColor: const Color(0xFF2F4FB2),
      ),
    );
  }

  Widget _logoutTile(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Color(0xFFFFE6E6),
        child: Icon(Icons.error_outline, color: Colors.red),
      ),
      title: const Text("Logout", style: TextStyle(color: Colors.red)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        _showLogoutDialog(context);
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final navigator = Navigator.of(context);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.logout, size: 50, color: Color(0xFF254EBA)),
              const SizedBox(height: 15),
              const Text(
                "Are you sure to log out of your account?",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  navigator.pushNamedAndRemoveUntil('/login', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF254EBA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "Log Out",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Color(0xFF254EBA)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
