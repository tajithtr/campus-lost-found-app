import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String message = "Checking Firebase connection...";

  @override
  void initState() {
    super.initState();
    testFirestore();
  }

  Future<void> testFirestore() async {
    try {
      await FirebaseFirestore.instance.collection('test').doc('connection').set(
        {'status': 'connected'},
      );

      var doc = await FirebaseFirestore.instance
          .collection('test')
          .doc('connection')
          .get();

      if (doc.exists && doc.data()?['status'] == 'connected') {
        setState(() {
          message = "Firebase is fully connected!";
        });
      } else {
        setState(() {
          message = "Firebase read/write test failed.";
        });
      }
    } catch (e) {
      setState(() {
        message = "Firebase error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Campus Lost & Found')),
      body: Center(
        child: Text(
          message,
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
