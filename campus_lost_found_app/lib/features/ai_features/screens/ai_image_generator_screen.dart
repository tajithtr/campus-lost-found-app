import 'package:flutter/material.dart';
import 'ai_generated_image_screen.dart';

class AIImageGeneratorScreen extends StatefulWidget {
  const AIImageGeneratorScreen({super.key});

  @override
  State<AIImageGeneratorScreen> createState() =>
      _AIImageGeneratorScreenState();
}

class _AIImageGeneratorScreenState
    extends State<AIImageGeneratorScreen> {
  final TextEditingController _descriptionController =
      TextEditingController();

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
            AIGeneratedImageScreen(description: description),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("AI Image Generator",style: TextStyle(color: Colors.white,),),centerTitle: true,
        backgroundColor: const Color(0xFF2F4DA0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: "Describe item...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: generateImage,
              child: const Text("Generate AI Image"),
            )
          ],
        ),
      ),
    );
  }
}