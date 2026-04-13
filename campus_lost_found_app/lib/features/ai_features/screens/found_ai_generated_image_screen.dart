import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import '../services/ai_image_service.dart';

class FoundAIGeneratedImageScreen extends StatefulWidget {
  final String description;

  const FoundAIGeneratedImageScreen({super.key, required this.description});

  @override
  State<FoundAIGeneratedImageScreen> createState() =>
      _FoundAIGeneratedImageScreenState();
}

class _FoundAIGeneratedImageScreenState
    extends State<FoundAIGeneratedImageScreen> {
  final AIService _aiService = AIService();
  String? imageUrl;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    generate();
  }

  void generate() async {
    final result = await _aiService.generateImage(widget.description, 'found');

    setState(() {
      imageUrl = result;
      isLoading = false;
    });
  }

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

            Text(widget.description, style: const TextStyle(fontSize: 16)),

            const SizedBox(height: 20),

            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: isLoading
                    ? const CircularProgressIndicator()
                    : imageUrl != null
                    ? Image.network(imageUrl!, fit: BoxFit.cover)
                    : const Icon(Icons.error),
              ),
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
