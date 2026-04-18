import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_settings.dart';
import 'notification_service.dart';

class FirestoreNotificationListener {
  static bool _started = false;

  static void start() {
    if (_started) return;
    _started = true;

    FirebaseFirestore.instance
        .collection('lost_items')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .snapshots()
        .listen((snapshot) async {
          if (snapshot.docs.isNotEmpty) {
            bool enabled = await AppSettings.notificationsEnabled();

            if (enabled) {
              await NotificationService.show(
                title: "New Lost Item",
                body: "A user reported a lost item.",
                payload: 'lost',
              );
            }
          }
        });

    FirebaseFirestore.instance
        .collection('found_items')
        .orderBy('createdAt', descending: true)
        .limit(1)
        .snapshots()
        .listen((snapshot) async {
          if (snapshot.docs.isNotEmpty) {
            bool enabled = await AppSettings.notificationsEnabled();

            if (enabled) {
              await NotificationService.show(
                title: "New Found Item",
                body: "A user reported a found item.",
                payload: 'found',
              );
            }
          }
        });
  }
}
