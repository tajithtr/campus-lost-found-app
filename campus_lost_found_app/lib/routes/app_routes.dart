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
import '../features/ai_features/screens/found_selected_succesfully.dart';
import '../features/ai_features/screens/found_deleted_succesfully.dart';

// Category Management Screens
import '../features/ai_features/screens/lost_select_category_page.dart';
import '../features/ai_features/screens/found_select_category_page.dart';

// image picking and AI generation screens
import '../features/ai_features/screens/lost_image_picker.dart';
import '../features/ai_features/screens/found_image_picker.dart';
import '../features/ai_features/screens/lost_ai_image_generator_screen.dart';
import '../features/ai_features/screens/found_ai_image_generator_screen.dart';

//Contact Screens
import '../features/claim_item/screens/contact_owner_screen.dart';
import '../features/claim_item/screens/contact_founder_screen.dart';

// Delivery Confirmation Screen
import '../features/delivery/screens/lost_item_delivery_confirmation_screen.dart';
import '../features/delivery/screens/found_item_delivery_confirmation_screen.dart';
import '../contact_us.dart';

class AppRoutes {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
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
  static const String myReportsLost = '/my-reports-lost';
  static const String myReportsFound = '/my-reports-found';
  static const String lostselectedSuccess = '/lost-selected-success';
  static const String lostdeletedSSuccess = '/lost-deleted-success';
  static const String foundSelectedSuccess = '/found-selected-success';
  static const String foundDeletedSuccess = '/found-deleted-success';
  static const String foundSelectCategory = '/found-select-category';
  static const String lostSelectCategory = '/lost-select-category';
  static const String lostAIImageGenerator = '/lost-ai-image-generator';
  static const String foundAIImageGenerator = '/found-ai-image-generator';
  static const String lostImagePicker = '/lost-image-picker';
  static const String foundImagePicker = '/found-image-picker';
  static const String contactUs = '/contact-us';
  static const String contactOwner = '/contact-owner';
  static const String contactFounder = '/contact-founder';
  static const String lostItemDeliveryConfirmation =
      '/lost-item-delivery-confirmation';
  static const String foundItemDeliveryConfirmation =
      '/found-item-delivery-confirmation';

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
        return MaterialPageRoute(
          builder: (_) => const ReportLostItemScreen(),
          settings: settings,
        );

      case reportFoundItem:
        return MaterialPageRoute(
          builder: (_) => const ReportFoundItemPage(),
          settings: settings,
        );

      case foundItemSubmit:
        return MaterialPageRoute(builder: (_) => const FoundItemReportSubmit());

      case lostItemSubmit:
        return MaterialPageRoute(builder: (_) => const LostItemReportSubmit());

      case profile:
        return MaterialPageRoute(builder: (_) => const ProfilePage());

      case myReportsLost:
        return MaterialPageRoute(builder: (_) => const MyLostItemsScreen());

      case myReportsFound:
        return MaterialPageRoute(builder: (_) => const MyFoundItemsScreen());

      case lostselectedSuccess:
        return MaterialPageRoute(builder: (_) => const LostSelectedSuccess());

      case lostdeletedSSuccess:
        return MaterialPageRoute(builder: (_) => const LostDeletedSucces());

      case foundSelectedSuccess:
        return MaterialPageRoute(builder: (_) => const FoundSelectedSuccess());

      case foundDeletedSuccess:
        return MaterialPageRoute(builder: (_) => const FoundDeletedSucces());

      case lostSelectCategory:
        return MaterialPageRoute(builder: (_) => LostSelectCategoryPage());

      case foundSelectCategory:
        return MaterialPageRoute(builder: (_) => FoundSelectCategoryPage());

      case lostAIImageGenerator:
        return MaterialPageRoute(
          builder: (_) => const LostAIImageGeneratorScreen(),
        );

      case foundAIImageGenerator:
        return MaterialPageRoute(
          builder: (_) => const FoundAIImageGeneratorScreen(),
        );

      case lostImagePicker:
        return MaterialPageRoute(builder: (_) => const LostImagePicker());

      case foundImagePicker:
        return MaterialPageRoute(builder: (_) => const FoundImagePicker());

      case contactUs:
        return MaterialPageRoute(builder: (_) => const ContactUsScreen());

      case contactOwner:
        final contactInfo = settings.arguments as Map<String, String>? ?? {};
        return MaterialPageRoute(
          builder: (_) => ContactOwnerScreen(
            ownerName: contactInfo['ownerName'] ?? 'Owner',
            ownerEmail: contactInfo['ownerEmail'] ?? '',
          ),
        );

      case contactFounder:
        final contactInfo = settings.arguments as Map<String, String>? ?? {};
        return MaterialPageRoute(
          builder: (_) => ContactFounderScreen(
            founderName: contactInfo['founderName'] ?? 'Founder',
            founderEmail: contactInfo['founderEmail'] ?? '',
          ),
        );

      case lostItemDeliveryConfirmation:
        final itemId = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => LostItemDeliveryConfirmationScreen(itemId: itemId),
        );

      case foundItemDeliveryConfirmation:
        final itemId = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => FoundItemDeliveryConfirmationScreen(itemId: itemId),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text("Route not found"))),
        );
    }
  }
}
