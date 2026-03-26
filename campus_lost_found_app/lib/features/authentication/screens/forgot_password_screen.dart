import 'package:flutter/material.dart';
import '../widgets/auth_textfield.dart';
import '../../../routes/app_routes.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final String email;
  const ForgotPasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController(
      text: email,
    );

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: const Color(0xFF1F3C88),
          title: const Text("Forgot Password"),
          centerTitle: true,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
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
            AuthTextField(
              hintText: "Enter your email",
              controller: emailController,
              icon: Icons.email_outlined,
              borderRadius: 30,
            ),
            const SizedBox(height: 80),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  final emailText = emailController.text.trim();

                  // ✅ Validate email is not empty
                  if (emailText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter an email"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  // Navigate only if email is valid
                  AppRoutes.goTo(
                    context,
                    AppRoutes.verification,
                    arguments: emailText,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF254EBA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  "Get Verification Code",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
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
