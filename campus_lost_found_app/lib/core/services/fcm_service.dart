import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logger/logger.dart';

class FCMService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final Logger _logger = Logger();

  static Future<void> init() async {
    await _messaging.requestPermission();

    String? token = await _messaging.getToken();
    _logger.i("FCM TOKEN: $token");

    await _messaging.subscribeToTopic("all_users");
  }

  static Future<void> subscribeAllUsers() async {
    await _messaging.subscribeToTopic("all_users");
  }

  static Future<void> unsubscribeAllUsers() async {
    await _messaging.unsubscribeFromTopic("all_users");
  }
}
