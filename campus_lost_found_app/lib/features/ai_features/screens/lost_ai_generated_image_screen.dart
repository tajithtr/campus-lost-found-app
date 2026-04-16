import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import 'package:flutter/foundation.dart';
import 'package:stability_image_generation/stability_image_generation.dart';

class AiTextToImageGenerator extends StatefulWidget {
  final String description;

  const AiTextToImageGenerator({super.key, required this.description});

  @override
  State<AiTextToImageGenerator> createState() => _AiTextToImageGeneratorState();
}

class _AiTextToImageGeneratorState extends State<AiTextToImageGenerator> {
  final StabilityAI _ai = StabilityAI();

  final String apiKey = 'sk-iLvm6WNnhkgitWZE0gP2THVovoW9cLh3RFAClwHZBv9Mq06H';
  final ImageAIStyle imageAIStyle = ImageAIStyle.digitalPainting;

  Uint8List? imageBytes;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    generate();
  }

  Future<void> generate() async {
    try {
      Uint8List result = await _ai.generateImage(
        apiKey: apiKey,
        imageAIStyle: imageAIStyle,
        prompt: widget.description,
      );

      setState(() {
        imageBytes = result;
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error: $e");
      }
      setState(() {
        isLoading = false;
      });
    }
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
          "AI Generated Image for Lost Item",
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
              "AI Generated Image",
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
                    : imageBytes != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(imageBytes!, fit: BoxFit.cover),
                      )
                    : const Icon(Icons.error),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.lostImagePicker);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF254EBA),
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
