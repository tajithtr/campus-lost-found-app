import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Make sure this file exists

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase safely
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const LostFoundApp());
}

class LostFoundApp extends StatelessWidget {
  const LostFoundApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Campus Lost & Found',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: Center(
          child: Text("Firebase Initialized ✅", style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }
}
