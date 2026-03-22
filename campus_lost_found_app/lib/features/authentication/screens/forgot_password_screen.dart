import 'package:flutter/material.dart';
import '../widgets/auth_textfield.dart';
import '../../../routes/app_routes.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key, String? email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        title: const Text("Forgot password"),
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),

            const Text(
              "Forgot Your Password?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "Enter your email address to receive a code",
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 40),

            const AuthTextField(
              hintText: "Enter your email",
              prefixIcon: Icons.email_outlined,
            ),

            const SizedBox(height: 80),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Later → navigate to verification screen
                },
                child: const Text("Get Verification Code"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
