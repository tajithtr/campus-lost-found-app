import 'package:flutter/material.dart';
import 'lost_ai_generated_image_screen.dart';

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
      backgroundColor: Colors.white,

      
      appBar: AppBar(
      backgroundColor: const Color(0xFF1F3C88),
      iconTheme: const IconThemeData(color: Colors.white),

  
  leading: IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () {
      Navigator.pop(context);
    },
  ),

  title: const Text(
    "AI Image Generator",
    style: TextStyle(color: Colors.white),
  ),
  centerTitle: true,
),

      
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            
            const Text(
              "Describe Lost Item",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
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
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}