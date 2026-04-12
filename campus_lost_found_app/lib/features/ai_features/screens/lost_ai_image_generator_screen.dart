import 'package:flutter/material.dart';
import 'lost_ai_generated_image_screen.dart';

class LostAIImageGeneratorScreen extends StatefulWidget {
  const LostAIImageGeneratorScreen({super.key});

  @override
  State<LostAIImageGeneratorScreen> createState() =>
      _LostAIImageGeneratorScreenState();
}

class _LostAIImageGeneratorScreenState
    extends State<LostAIImageGeneratorScreen> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void generateImage() {
    final description = _descriptionController.text.trim();

    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a description")),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            LostAIGeneratedImageScreen(description: description),
      ),
    );
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
          "AI Image Generator For Lost Item",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Describe Lost Item",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Container(
              height: 150,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: _descriptionController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  hintText: "Description About Lost Item...",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: generateImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF254EBA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Generate AI Image",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
