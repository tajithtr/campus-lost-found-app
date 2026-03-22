import 'package:flutter/material.dart';

// Package imports (portable)
import 'package:campus_lost_found_app/features/authentication/screens/splash_screen.dart';
import 'package:campus_lost_found_app/features/authentication/screens/login_screen.dart';
import 'package:campus_lost_found_app/features/authentication/screens/register_screen.dart';
import 'package:campus_lost_found_app/features/authentication/screens/forgot_password_screen.dart';

class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // Static map of routes
  static final Map<String, WidgetBuilder> routes = {
    splash: (_) => const SplashScreen(),
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    forgotPassword: (_) => const ForgotPasswordScreen(),
  };

  /// Navigate safely to a route
  static void goTo(BuildContext context, String route, {Object? arguments}) {
    if (routes.containsKey(route)) {
      Navigator.pushNamed(context, route, arguments: arguments);
    } else {
      throw Exception("Route $route is not defined in AppRoutes.");
    }
  }

  /// Handle dynamic routes with arguments
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
      default:
        // Fallback route
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
