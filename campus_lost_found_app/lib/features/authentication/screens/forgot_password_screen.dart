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

      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        title: const Text("Forgot Password"),
        centerTitle: true,
        foregroundColor: Colors.white,
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

            // EMAIL FIELD
            AuthTextField(
              hint: "Enter your email",
              controller: emailController,
              prefixIcon: const Icon(Icons.email_outlined),
            ),

            const SizedBox(height: 80),

            // GET VERIFICATION CODE BUTTON
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  final emailText = emailController.text.trim();

                  // Email validation
                  final emailRegex = RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  );

                  if (emailText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter an email"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  if (!emailRegex.hasMatch(emailText)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please enter a valid email address"),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  // If valid → go to next screen
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
