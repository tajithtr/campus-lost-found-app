import 'package:flutter/material.dart';
import '../widgets/auth_textfield.dart';
import '../../../core/services/auth_service.dart';
import '../../home/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;

  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // login function with validation and error handling
  Future<void> loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    //  VALIDATION
    if (email.isEmpty && password.isEmpty) {
      showMessage("Please enter email and password");
      return;
    }

    if (email.isEmpty) {
      showMessage("Please enter your email");
      return;
    }

    if (password.isEmpty) {
      showMessage("Please enter your password");
      return;
    }

    try {
      // 🔐 Firebase login
      await _authService.login(email, password);

      // navigate to home on success
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        showMessage("Email or password is incorrect");
      }
    }
  }

  // helper to show snackbar messages
  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        title: const Text("Login"),
        centerTitle: true,
        foregroundColor: Colors.white,
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              const SizedBox(height: 20),

              Image.asset('assets/images/logo.jpg', height: 200),

              const SizedBox(height: 25),

              const Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 25),

              // EMAIL
              AuthTextField(
                controller: emailController,
                hint: "Enter your email",
                prefixIcon: const Icon(Icons.email_outlined),
              ),

              const SizedBox(height: 15),

              // PASSWORD
              AuthTextField(
                controller: passwordController,
                hint: "Enter your password",
                isPassword: true,
                prefixIcon: const Icon(Icons.lock_outline),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text("Forgot Password?"),
                ),
              ),

              const SizedBox(height: 10),

              // LOGIN BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF254EBA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: loginUser,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account? "),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xFF2F4DA0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
