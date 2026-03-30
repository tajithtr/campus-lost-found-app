import 'dart:io';
import 'package:flutter/material.dart';
import '../widgets/auth_textfield.dart';
import 'package:campus_lost_found_app/widgets/custom_button.dart';
import 'profile_picture_screen.dart';
import 'package:campus_lost_found_app/core/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        title: const Text("Register"),
        centerTitle: true,
        foregroundColor: Colors.white,
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

            // ROLE SELECTION
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

            // PROFILE IMAGE PREVIEW
            if (_profileImage != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: FileImage(_profileImage!),
                  ),
                ),
              ),

            // PICK IMAGE BUTTON
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
                icon: const Icon(Icons.camera_alt, color: Colors.black),
                label: const Text(
                  "Add Profile Picture",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // REGISTER BUTTON
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                    text: "Register",
                    onPressed: () async {
                      if (nameController.text.isEmpty ||
                          emailController.text.isEmpty ||
                          passwordController.text.isEmpty ||
                          confirmPasswordController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please fill all fields"),
                          ),
                        );
                        return;
                      }

                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Passwords do not match"),
                          ),
                        );
                        return;
                      }

                      try {
                        setState(() => isLoading = true);

                        final user = await AuthService().register(
                          emailController.text,
                          passwordController.text,
                        );

                        // SAVE NAME
                        if (user != null) {
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(user.uid)
                              .set({
                                'name': nameController.text.trim(),
                                'email': emailController.text.trim(),
                              });
                        }

                        setState(() => isLoading = false);

                        if (context.mounted && user != null) {
                          // Navigate to login screen after registration
                          Navigator.pushReplacementNamed(context, '/login');
                        }
                      } catch (e) {
                        setState(() => isLoading = false);
                        if (context.mounted) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      }
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
