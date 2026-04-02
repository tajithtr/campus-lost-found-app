import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../routes/app_routes.dart';

class NewPasswordScreen extends StatefulWidget {
  final String email;

  const NewPasswordScreen({super.key, required this.email});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  bool isPasswordVisible = false;
  bool isConfirmVisible = false;
  bool isLoading = false;

  @override
  void dispose() {
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Future<void> updatePassword() async {
    String password = passwordController.text.trim();
    String confirm = confirmController.text.trim();

    // VALIDATION
    if (password.isEmpty || confirm.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password must be at least 6 characters")),
      );
      return;
    }

    if (password != confirm) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("https://YOUR_URL/resetPassword"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": widget.email, "newPassword": password}),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password Updated Successfully")),
        );

        await Future.delayed(const Duration(seconds: 1));

        if (!mounted) return;

        Navigator.pushReplacementNamed(context, AppRoutes.success);
      } else {
        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(data['error'] ?? "Failed to update password")),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Server error")));
    }

    setState(() => isLoading = false);
  }

  Widget buildPasswordField({
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback toggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      style: const TextStyle(fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: toggle,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        title: const Text("New Password"),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),

            const Text(
              "Create New Password",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            const Text(
              "Enter your new password below",
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 40),

            // PASSWORD
            buildPasswordField(
              controller: passwordController,
              isVisible: isPasswordVisible,
              toggle: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),

            const SizedBox(height: 20),

            // CONFIRM PASSWORD
            buildPasswordField(
              controller: confirmController,
              isVisible: isConfirmVisible,
              toggle: () {
                setState(() {
                  isConfirmVisible = !isConfirmVisible;
                });
              },
            ),

            const SizedBox(height: 60),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : updatePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF254EBA),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Update Password",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
