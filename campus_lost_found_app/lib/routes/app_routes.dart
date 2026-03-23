import 'package:flutter/material.dart';

// Screens
import '../features/authentication/screens/splash_screen.dart';
import '../features/authentication/screens/login_screen.dart';
import '../features/authentication/screens/register_screen.dart';
import '../features/authentication/screens/forgot_password_screen.dart';
import '../features/authentication/screens/verification_screen.dart';
import '../features/authentication/screens/new_password_screen.dart';
import '../features/authentication/screens/success_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verification = '/verification';
  static const String newPassword = '/new-password';
  static const String success = '/success';

  static void goTo(BuildContext context, String route, {Object? arguments}) {
    Navigator.pushNamed(context, route, arguments: arguments);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case forgotPassword:
        final email = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordScreen(email: email ?? ""),
        );
      case verification:
        final email = settings.arguments as String?;
        if (email != null && email.isNotEmpty) {
          return MaterialPageRoute(
            builder: (_) => VerificationScreen(email: email),
          );
        }
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("No email provided"))),
        );
      case newPassword:
        return MaterialPageRoute(builder: (_) => const NewPasswordScreen());
      case success:
        return MaterialPageRoute(builder: (_) => const SuccessScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Route not found"))),
        );
    }
  }
}
