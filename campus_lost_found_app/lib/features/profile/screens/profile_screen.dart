import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../widgets/navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      // Silently handle error loading user data
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

  void _onNavTap(int index) {
    if (index == 3) return;

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/lost');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/found');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: const Color(0xFF254EBA),
      body: Column(
        children: [
          const SizedBox(height: 60),

          // Profile Picture with Camera Icon (UI SAME)
          Stack(
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

          // bottom card (UI SAME)
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
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Divider(),

                  _menuTile(
                    Icons.lock_outline,
                    "Change Password",
                    style: const TextStyle(color: Colors.black),
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

      bottomNavigationBar: AppNavigationBar(selectedIndex: 3, onTap: _onNavTap),
    );
  }

  Widget _menuTile(IconData icon, String text, {TextStyle? style}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFE6ECFF),
        child: Icon(icon, color: const Color(0xFF2F4FB2)),
      ),
      title: Text(text, style: style),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
                child: const Text("Log Out"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancel"),
              ),
            ],
          ),
        );
      },
    );
  }
}
