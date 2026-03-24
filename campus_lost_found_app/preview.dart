
import 'package:flutter/material.dart';
import 'lib/features/ai_features/screens/ai_item_detection_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReportFoundItemScreen(),
    );
  }
}