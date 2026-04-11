import 'package:flutter/material.dart';

// Authentication Screens
import '../features/authentication/screens/splash_screen.dart';
import '../features/authentication/screens/login_screen.dart';
import '../features/authentication/screens/register_screen.dart';
import '../features/authentication/screens/forgot_password_screen.dart';

// Home Screen
import '../features/home/screens/home_screen.dart';

// Profile Screen
import '../features/profile/screens/profile_screen.dart';

// Lost Items Screens
import '../features/lost_items/screens/lost_items_list_screen.dart';
import '../features/lost_items/screens/lost_item_details_screen.dart';
import '../features/lost_items/screens/report_lost_item_screen.dart';
import '../features/lost_items/screens/lost_item_report_submit.dart';

// Found Items Screens
import '../features/found_items/screens/found_items_list_screen.dart';
import '../features/found_items/screens/report_found_item_screen.dart';
import '../features/found_items/screens/found_item_report_submit.dart';

// My Reports Screens
import '../features/reports/screens/my_reports_lost_item_screen.dart';
import '../features/reports/screens/my_reports_found_item_screen.dart';
import '../features/ai_features/screens/lost_selected_succesfully.dart';
import '../features/ai_features/screens/lost_deleted_succesfully.dart';

// Category Management Screens
import '../features/ai_features/screens/select_category_page.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String lostItems = '/lost-items';
  static const String foundItems = '/found-items';
  static const String profile = '/profile';
  static const String reportLostItem = '/report-lost-item';
  static const String reportFoundItem = '/report-found-item';
  static const String foundItemSubmit = '/found-item-submit';
  static const String lostItemSubmit = '/lost-item-submit';
  static const String lostItemDetails = '/lost-item-details';
  static const String myReportsLost = '/my-reports-lost';
  static const String myReportsFound = '/my-reports-found';
  static const String myReports = '/my-reports';
  static const String selectedSuccess = '/selected-success';
  static const String deletedSuccess = '/deleted-success';
  static const String selectCategory = '/select-category';

  static void goTo(BuildContext context, String route, {Object? arguments}) {
    Navigator.pushNamed(context, route, arguments: arguments);
  }

  static void goAndReplace(
    BuildContext context,
    String route, {
    Object? arguments,
  }) {
    Navigator.pushReplacementNamed(context, route, arguments: arguments);
  }

  static void goAndRemoveUntil(
    BuildContext context,
    String route, {
    Object? arguments,
  }) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      route,
      (route) => false,
      arguments: arguments,
    );
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
        final email = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => ForgotPasswordScreen(email: email),
        );

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

      case foundItemSubmit:
        return MaterialPageRoute(builder: (_) => const FoundItemReportSubmit());

      case lostItemSubmit:
        return MaterialPageRoute(builder: (_) => const LostItemReportSubmit());

      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());

      case lostItemDetails:
        return MaterialPageRoute(builder: (_) => const LostItemDetailsScreen());

      case myReportsLost:
        return MaterialPageRoute(builder: (_) => const MyLostItemsScreen());

      case myReportsFound:
        return MaterialPageRoute(builder: (_) => const MyFoundItemsScreen());

      case myReports:
        return MaterialPageRoute(builder: (_) => const MyLostItemsScreen());

      case selectedSuccess:
        return MaterialPageRoute(builder: (_) => const SelectedSuccess());

      case deletedSuccess:
        return MaterialPageRoute(builder: (_) => const DeletedSuccess());

      case selectCategory:
        return MaterialPageRoute(builder: (_) => SelectCategoryPage());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Route not found"))),
        );
    }
  }
}
