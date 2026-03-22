import 'package:flutter/material.dart';

// Screens
import 'package:campus_lost_found_app/features/authentication/screens/splash_screen.dart';
import 'package:campus_lost_found_app/features/authentication/screens/login_screen.dart';
import 'package:campus_lost_found_app/features/authentication/screens/register_screen.dart';
import 'package:campus_lost_found_app/features/authentication/screens/forgot_password_screen.dart';
import 'package:campus_lost_found_app/features/authentication/screens/verification_screen.dart';

class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verification = '/verification';

  /// Centralized navigation method
  static void goTo(BuildContext context, String route, {Object? arguments}) {
    Navigator.pushNamed(context, route, arguments: arguments);
  }

  /// SINGLE SOURCE OF TRUTH
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
          builder: (_) => ForgotPasswordScreen(email: email),
        );

      case verification:
        final email = settings.arguments as String?;
        return MaterialPageRoute(
          builder: (_) => VerificationScreen(email: email),
        );

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Route not found"))),
        );
    }
  }
}
