import 'package:flutter/material.dart';
import '../../../widgets/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      // AppBar
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        title: const Text("Register"),
        foregroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new, // 👈 thinner arrow like your image
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            //  Title
            const Text(
              "Welcome User!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            //  Name
            _buildTextField("Name"),

            const SizedBox(height: 20),

            //  Email
            _buildTextField("University Email"),

            const SizedBox(height: 20),

            //  Password
            _buildTextField("Password", isPassword: true),

            const SizedBox(height: 20),

            //  Confirm Password
            _buildTextField("Confirm Password", isPassword: true),

            const SizedBox(height: 25),

            // Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Role :",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),

                const SizedBox(width: 20),

                // Student
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<int>(value: 1, groupValue: 1, onChanged: (_) {}),
                    const Text("Student"),
                  ],
                ),

                const SizedBox(width: 20),

                // Staff
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Radio<int>(value: 2, groupValue: 1, onChanged: (_) {}),
                    const Text("Staff"),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            //  Profile Picture
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  print("Add Profile Picture clicked");
                },
                icon: const Icon(
                  Icons.camera_alt,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                label: const Text(
                  "Add Profile Picture",
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.w500,
                  ),
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

            //  Register Button
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
                onPressed: () {},
                child: const Text(
                  "Register",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            //  Login Redirect
            Center(
              child: TextButton(
                onPressed: () {},
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: "Login",
                        style: TextStyle(
                          color: Color(0xFF2564C9),
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  Reusable TextField
  Widget _buildTextField(String hint, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      style: const TextStyle(fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Color(0xFFCBD5E1)),
        ),
      ),
    );
  }
}
