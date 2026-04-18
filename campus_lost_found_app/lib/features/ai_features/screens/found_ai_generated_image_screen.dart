import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:stability_image_generation/stability_image_generation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;
import 'package:logger/logger.dart';

class FoundAIGeneratedImageScreen extends StatefulWidget {
  final String description;

  const FoundAIGeneratedImageScreen({super.key, required this.description});

  @override
  State<FoundAIGeneratedImageScreen> createState() =>
      _FoundAIGeneratedImageScreenState();
}

class _FoundAIGeneratedImageScreenState
    extends State<FoundAIGeneratedImageScreen> {
  final StabilityAI _ai = StabilityAI();
  final Logger _logger = Logger();

  final String apiKey = 'sk-iLvm6WNnhkgitWZE0gP2THVovoW9cLh3RFAClwHZBv9Mq06H';
  final ImageAIStyle imageAIStyle = ImageAIStyle.digitalPainting;

  Uint8List? imageBytes;
  bool isLoading = true;
  String? errorMessage;
  File? convertedFile;

  @override
  void initState() {
    super.initState();
    generate();
  }

  Future<File?> _convertAndCompressImage(Uint8List bytes) async {
    try {
      if (bytes.isEmpty) {
        throw Exception("Image bytes are empty");
      }

      // Try to decode the image to validate it
      img.Image? decodedImage = img.decodeImage(bytes);
      if (decodedImage == null) {
        throw Exception("Invalid image format");
      }

      // Resize image if too large (max dimension 800px)
      int width = decodedImage.width;
      int height = decodedImage.height;

      if (width > 800 || height > 800) {
        if (width > height) {
          height = (height * 800 / width).round();
          width = 800;
        } else {
          width = (width * 800 / height).round();
          height = 800;
        }
        decodedImage = img.copyResize(
          decodedImage,
          width: width,
          height: height,
        );
      }

      // Compress image with quality (60% quality)
      final compressedBytes = img.encodeJpg(decodedImage, quality: 60);

      // Check file size and compress more if needed
      int fileSize = compressedBytes.length;
      int quality = 60;

      while (fileSize > 500000 && quality > 20) {
        quality -= 10;
        final recompressed = img.encodeJpg(decodedImage, quality: quality);
        fileSize = recompressed.length;
      }

      final finalBytes = fileSize < compressedBytes.length
          ? img.encodeJpg(decodedImage, quality: quality)
          : compressedBytes;

      final tempDir = await getTemporaryDirectory();
      final file = File(
        '${tempDir.path}/generated_image_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      await file.writeAsBytes(finalBytes);

      if (await file.exists() && await file.length() > 0) {
        _logger.i("Final image size: ${await file.length()} bytes");
        return file;
      } else {
        throw Exception("Failed to create valid image file");
      }
    } catch (e) {
      _logger.e("Error converting image: $e");
      return null;
    }
  }

  Future<void> generate() async {
    try {
      setState(() {
        errorMessage = null;
        isLoading = true;
      });

      Uint8List result = await _ai.generateImage(
        apiKey: apiKey,
        imageAIStyle: imageAIStyle,
        prompt: widget.description,
      );

      if (result.isEmpty) {
        throw Exception("Generated image is empty");
      }

      final file = await _convertAndCompressImage(result);

      if (file != null) {
        setState(() {
          imageBytes = result;
          convertedFile = file;
          isLoading = false;
        });
      } else {
        throw Exception("Failed to save image");
      }
    } catch (e) {
      _logger.e("Error generating image: $e");
      setState(() {
        isLoading = false;
        errorMessage = "Failed to generate image: $e";
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
          "AI Generated Image for Found Item",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
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
                    : errorMessage != null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error, size: 50, color: Colors.red),
                          const SizedBox(height: 10),
                          Text(
                            errorMessage!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      )
                    : convertedFile != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.file(convertedFile!, fit: BoxFit.cover),
                      )
                    : const Icon(Icons.error),
              ),
            ),
            const Spacer(),
            if (errorMessage == null && !isLoading && convertedFile != null)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    if (convertedFile != null &&
                        await convertedFile!.exists()) {
                      if (context.mounted) {
                        Navigator.pop(context, convertedFile);
                        Navigator.pop(context, convertedFile);
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Image file is not valid. Please try again.",
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
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
            if (errorMessage != null)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                      errorMessage = null;
                      convertedFile = null;
                    });
                    generate();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 236, 122, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    "Retry",
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
