import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../widgets/auth_textfield.dart';
import 'package:campus_lost_found_app/widgets/custom_button.dart';
import 'profile_picture_screen.dart';
import 'package:campus_lost_found_app/core/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int? _selectedRole;
  File? _profileImage;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        centerTitle: true,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Register",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Welcome User!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            AuthTextField(hint: "Name", controller: nameController),
            const SizedBox(height: 20),
            AuthTextField(
              hint: "University Email",
              controller: emailController,
            ),
            const SizedBox(height: 20),
            AuthTextField(
              hint: "Password",
              isPassword: true,
              controller: passwordController,
            ),
            const SizedBox(height: 20),
            AuthTextField(
              hint: "Confirm Password",
              isPassword: true,
              controller: confirmPasswordController,
            ),
            const SizedBox(height: 25),

            Row(
              children: [
                const Text("Role :", style: TextStyle(fontSize: 16)),
                const SizedBox(width: 20),
                RadioGroup<int>(
                  groupValue: _selectedRole,
                  onChanged: (value) {
                    setState(() => _selectedRole = value);
                  },
                  child: Row(
                    children: [
                      Radio<int>(value: 1),
                      const Text("Student"),
                      const SizedBox(width: 20),
                      Radio<int>(value: 2),
                      const Text("Staff"),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            if (_profileImage != null)
              Center(
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: FileImage(_profileImage!),
                ),
              ),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  final image = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProfilePictureScreen(),
                    ),
                  );
                  if (image != null) {
                    setState(() => _profileImage = image);
                  }
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Add Profile Picture"),
              ),
            ),

            const SizedBox(height: 30),

            isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                    text: "Register",
                    onPressed: () async {
                      if (_profileImage == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Please select image")),
                        );
                        return;
                      }

                      // check internet connectivity before attempting registration
                      var connectivityResult = await Connectivity()
                          .checkConnectivity();

                      if (connectivityResult.contains(
                        ConnectivityResult.none,
                      )) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "No internet connection. Please try again.",
                            ),
                          ),
                        );
                        return;
                      }

                      setState(() => isLoading = true);

                      try {
                        final user = await AuthService().register(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        );

                        if (user != null) {
                          String base64Image = "";

                          final bytes = await _profileImage!.readAsBytes();

                          if (bytes.length > 1024 * 1024) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Image must be less than 1MB"),
                              ),
                            );
                            setState(() => isLoading = false);
                            return;
                          }

                          base64Image = base64Encode(bytes);

                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .set({
                                'name': nameController.text.trim(),
                                'email': emailController.text.trim(),
                                'imageBase64': base64Image,
                              });
                        }

                        if (context.mounted) {
                          Navigator.pushReplacementNamed(context, '/home');
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Registration failed. Check internet and try again.",
                            ),
                          ),
                        );
                      }

                      if (mounted) {
                        setState(() => isLoading = false);
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
