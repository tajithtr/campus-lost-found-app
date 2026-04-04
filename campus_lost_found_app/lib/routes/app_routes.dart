import 'package:flutter/material.dart';

// Authentication Screens
import '../features/authentication/screens/splash_screen.dart';
import '../features/authentication/screens/login_screen.dart';
import '../features/authentication/screens/register_screen.dart';
import '../features/authentication/screens/forgot_password_screen.dart';
import '../features/authentication/screens/success_screen.dart';
import '../features/authentication/screens/verification_screen.dart';
import '../features/authentication/screens/new_password_screen.dart';

// Home Screen
import '../features/home/screens/home_screen.dart';

// Lost Items Screens
import '../features/lost_items/screens/lost_items_list_screen.dart';
import '../features/lost_items/screens/lost_item_details_screen.dart';
import '../features/lost_items/screens/report_lost_item_screen.dart';

// ✅ Found Items Screens (ADDED)
import '../features/found_items/screens/found_items_list_screen.dart';
import '../features/found_items/screens/report_found_item_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verification = '/verification';
  static const String newPassword = '/new-password';
  static const String success = '/success';
  static const String home = '/home';
  static const String lostItems = '/lost-items';
  static const String foundItems = '/found-items'; // ✅ already existed
  static const String reportLostItem = '/report-lost-item';
  static const String reportFoundItem = '/report-found-item';
  static const String lostItemDetails = '/lost-item-details';
  static const String myReports = '/my-reports';

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

      case success:
        return MaterialPageRoute(builder: (_) => const SuccessScreen());

      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case lostItems:
        return MaterialPageRoute(builder: (_) => const LostItemsScreen());

      case foundItems:
        return MaterialPageRoute(builder: (_) => const FoundItemsScreen());

      case reportLostItem:
        return MaterialPageRoute(builder: (_) => const ReportLostItemScreen());

      case reportFoundItem:
        return MaterialPageRoute(builder: (_) => const ReportFoundItemPage());

      case lostItemDetails:
        return MaterialPageRoute(builder: (_) => const LostItemDetailsScreen());

      case forgotPassword:
        final email = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordScreen(email: email),
        );

      case verification:
        final email = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => VerificationScreen(email: email),
        );

      case newPassword:
        final email = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => NewPasswordScreen(email: email),
        );

      default:
        return _errorRoute("Route not found");
    }
  }

  static MaterialPageRoute _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        body: Center(
          child: Text(message, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
