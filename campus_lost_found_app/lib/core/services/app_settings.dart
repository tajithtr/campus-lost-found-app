import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  static Future<bool> notificationsEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool('notification_status') ?? true;
  }
}
