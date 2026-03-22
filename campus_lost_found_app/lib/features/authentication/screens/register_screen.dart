import 'package:flutter/material.dart';
import '../widgets/auth_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  int? _selectedRole; // 1 = Student, 2 = Staff

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color(0xFF1F3C88),
          title: const Text("Register"),
          centerTitle: true,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Welcome User!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            const AuthTextField(hintText: "Name", borderRadius: 30),
            const SizedBox(height: 20),
            const AuthTextField(hintText: "University Email", borderRadius: 30),
            const SizedBox(height: 20),
            const AuthTextField(
              hintText: "Password",
              isPassword: true,
              borderRadius: 30,
            ),
            const SizedBox(height: 20),
            const AuthTextField(
              hintText: "Confirm Password",
              isPassword: true,
              borderRadius: 30,
            ),
            const SizedBox(height: 25),

            // Role selection
            Row(
              children: [
                const Text("Role :", style: TextStyle(fontSize: 16)),
                const SizedBox(width: 20),
                Row(
                  children: [
                    Radio<int>(
                      value: 1,
                      groupValue: _selectedRole,
                      onChanged: (value) {
                        setState(() => _selectedRole = value);
                      },
                    ),
                    const Text("Student"),
                    const SizedBox(width: 20),
                    Radio<int>(
                      value: 2,
                      groupValue: _selectedRole,
                      onChanged: (value) {
                        setState(() => _selectedRole = value);
                      },
                    ),
                    const Text("Staff"),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.camera_alt, color: Colors.black),
                label: const Text(
                  "Add Profile Picture",
                  style: TextStyle(color: Colors.black),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(color: Colors.grey.shade300),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF254EBA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
