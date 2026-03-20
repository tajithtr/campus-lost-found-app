import 'package:flutter/material.dart';
import '../features/authentication/screens/splash_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> routes = {
    '/': (context) => const SplashScreen(),
  };
}
