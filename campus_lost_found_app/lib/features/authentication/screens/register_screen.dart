import 'package:flutter/material.dart';
import '../widgets/auth_textfield.dart';
import '../../../routes/app_routes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        title: const Text("Register"),
        foregroundColor: Colors.white,
        centerTitle: true,
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

            const AuthTextField(hintText: "Name"),
            const SizedBox(height: 20),

            const AuthTextField(hintText: "University Email"),
            const SizedBox(height: 20),

            const AuthTextField(hintText: "Password", isPassword: true),
            const SizedBox(height: 20),

            const AuthTextField(hintText: "Confirm Password", isPassword: true),

            const SizedBox(height: 25),

            Row(
              children: [
                const Text("Role :"),
                const SizedBox(width: 20),

                Row(
                  children: const [
                    Radio(value: 1, groupValue: 1, onChanged: null),
                    Text("Student"),
                  ],
                ),

                const SizedBox(width: 20),

                Row(
                  children: const [
                    Radio(value: 2, groupValue: 1, onChanged: null),
                    Text("Staff"),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.camera_alt),
                label: const Text("Add Profile Picture"),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF254EBA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  // After register → go back to login
                  Navigator.pop(context);
                },
                child: const Text(
                  "Register",
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
