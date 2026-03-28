import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();

  // password visibility toggles
  bool _isPasswordVisible = false;
  bool _isConfirmVisible = false;

  @override
  void dispose() {
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        title: const Text(
          "New Password",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            const Center(
              child: Text(
                "Enter New Password",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 10),

            const Center(
              child: Text(
                "Create your new password to login",
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              "Password",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 10),

            // Password Field
            _buildPasswordField(
              controller: passwordController,
              isVisible: _isPasswordVisible,
              toggleVisibility: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),

            const SizedBox(height: 25),

            const Text(
              "Confirm Password",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 10),

            // Confirm Password Field
            _buildPasswordField(
              controller: confirmController,
              isVisible: _isConfirmVisible,
              toggleVisibility: () {
                setState(() {
                  _isConfirmVisible = !_isConfirmVisible;
                });
              },
            ),

            const SizedBox(height: 60),

            // Update Password Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  String pass = passwordController.text;
                  String confirm = confirmController.text;

                  if (pass.isEmpty || confirm.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields")),
                    );
                    return;
                  }

                  if (pass != confirm) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Passwords do not match")),
                    );
                    return;
                  }

                  // Success message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Password Updated")),
                  );

                  // Wait safely
                  await Future.delayed(const Duration(seconds: 1));

                  if (!context.mounted) return;

                  Navigator.pushReplacementNamed(context, AppRoutes.success);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF254EBA),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
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

  // Reusable password field with visibility toggle
  Widget _buildPasswordField({
    required TextEditingController controller,
    required bool isVisible,
    required VoidCallback toggleVisibility,
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

        //  Show / Hide Icon
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: toggleVisibility,
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1)),
        ),
      ),
    );
  }
}
