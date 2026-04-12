import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';

class FoundAIGeneratedImageScreen extends StatelessWidget {
  final String description;

  const FoundAIGeneratedImageScreen({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        centerTitle: true,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "AI Generated Image for Found Item",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Generated Found Item",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            Text(description, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 20),

            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: Icon(Icons.image, size: 80)),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.foundImagePicker);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 236, 122, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Use this Image",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
