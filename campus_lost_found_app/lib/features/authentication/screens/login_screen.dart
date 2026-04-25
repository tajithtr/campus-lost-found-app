import 'package:flutter/material.dart';
import '../widgets/auth_textfield.dart';
import '../../../core/services/auth_service.dart';
import '../../../routes/app_routes.dart';
import '../../home/screens/home_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../contact_us.dart';

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

  Future<void> loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

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

    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.none)) {
      showMessage("No internet connection. Please try again.");
      return;
    }

    try {
      await _authService.login(email, password);

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

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        elevation: 0,
        toolbarHeight: kToolbarHeight + 10,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text(
          "Login",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
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

              // email
              AuthTextField(
                controller: emailController,
                hint: "Enter your email",
                prefixIcon: const Icon(Icons.email_outlined),
              ),

              const SizedBox(height: 15),

              // password
              AuthTextField(
                controller: passwordController,
                hint: "Enter your password",
                isPassword: true,
                prefixIcon: const Icon(Icons.lock_outline),
              ),

              const SizedBox(height: 10),

              // forgot password
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    String email = emailController.text.trim();

                    if (email.isEmpty) {
                      showMessage("Please enter your email first");
                      return;
                    }

                    AppRoutes.goTo(
                      context,
                      AppRoutes.forgotPassword,
                      arguments: email,
                    );
                  },
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Color(0xFF254EBA),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // login button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: loginUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF254EBA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
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

              const SizedBox(height: 14),

              // contact us button
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ContactUsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.support_agent_outlined,
                    color: Color(0xFF254EBA),
                    size: 20,
                  ),
                  label: const Text(
                    "Contact Us",
                    style: TextStyle(
                      color: Color(0xFF254EBA),
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      color: Color(0xFF254EBA),
                      width: 1.3,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account? "),
                  GestureDetector(
                    onTap: () {
                      AppRoutes.goTo(context, AppRoutes.register);
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color(0xFF254EBA),
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
