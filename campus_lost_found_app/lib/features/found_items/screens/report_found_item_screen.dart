import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import '../../ai_features/screens/found_image_picker.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import 'package:campus_lost_found_app/core/services/app_settings.dart';
import 'package:campus_lost_found_app/core/services/notification_service.dart';
import 'package:image/image.dart' as img;
import 'package:logger/logger.dart';

class ReportFoundItemPage extends StatefulWidget {
  const ReportFoundItemPage({super.key});

  @override
  State<ReportFoundItemPage> createState() => ReportFoundItemPageState();
}

class ReportFoundItemPageState extends State<ReportFoundItemPage> {
  final Logger _logger = Logger();

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController itemController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? manualCategory;

  File? selectedImage;
  String detectedCategory = "Detecting...";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null && manualCategory == null) {
      setState(() {
        manualCategory = args as String;
        detectedCategory = manualCategory!;
      });
    }
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    itemController.dispose();
    locationController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<Uint8List> _compressImage(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();

      // Decode the image
      img.Image? originalImage = img.decodeImage(bytes);
      if (originalImage == null) {
        throw Exception("Invalid image format");
      }

      // Calculate new dimensions (max 800px)
      int width = originalImage.width;
      int height = originalImage.height;
      const int maxDimension = 800;

      if (width > maxDimension || height > maxDimension) {
        if (width > height) {
          height = (height * maxDimension / width).round();
          width = maxDimension;
        } else {
          width = (width * maxDimension / height).round();
          height = maxDimension;
        }
        originalImage = img.copyResize(
          originalImage,
          width: width,
          height: height,
        );
      }

      // Compress image with quality (start at 70%)
      int quality = 70;
      Uint8List compressedBytes = img.encodeJpg(
        originalImage,
        quality: quality,
      );

      // Reduce quality until file size is under 500KB or quality reaches 30%
      while (compressedBytes.length > 500000 && quality > 30) {
        quality -= 10;
        compressedBytes = img.encodeJpg(originalImage, quality: quality);
      }

      _logger.i(
        "Original size: ${bytes.length} bytes, Compressed size: ${compressedBytes.length} bytes",
      );
      return compressedBytes;
    } catch (e) {
      _logger.e("Error compressing image: $e");
      // Return original bytes if compression fails
      return await imageFile.readAsBytes();
    }
  }

  Widget inputField(
    String title, {
    int maxLines = 1,
    TextEditingController? controller,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          readOnly: onTap != null,
          onTap: onTap,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1.2),
            ),
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }

  Future<void> pickDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> pickTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        timeController.text = picked.format(context);
      });
    }
  }

  Future<String> detectCategory(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);

    final imageLabeler = ImageLabeler(
      options: ImageLabelerOptions(confidenceThreshold: 0.6),
    );

    final labels = await imageLabeler.processImage(inputImage);

    String category = "Other";

    for (ImageLabel label in labels) {
      String text = label.label.toLowerCase();

      if (text.contains("wallet")) {
        category = "Wallet";
      } else if (text.contains("bag")) {
        category = "Bag";
      } else if (text.contains("book")) {
        category = "Books";
      } else if (text.contains("phone") || text.contains("laptop")) {
        category = "Electronics";
      } else if (text.contains("key")) {
        category = "Key";
      } else if (text.contains("card")) {
        category = "ID Card";
      }
    }

    imageLabeler.close();
    return category;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          "Report Found Item",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            inputField("Item Name", controller: itemController),
            inputField("Date", controller: dateController, onTap: pickDate),
            inputField("Time", controller: timeController, onTap: pickTime),
            inputField("Location Found", controller: locationController),
            inputField(
              "Description",
              maxLines: 3,
              controller: descriptionController,
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: selectedImage != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            selectedImage!,
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Image Selected",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextButton.icon(
                          onPressed: () async {
                            final image = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const FoundImagePicker(),
                              ),
                            );
                            if (image != null && image is File) {
                              setState(() {
                                selectedImage = image;
                              });
                              if (manualCategory == null) {
                                String detected = await detectCategory(image);
                                setState(() {
                                  detectedCategory = detected;
                                });
                              }
                            }
                          },
                          icon: const Icon(Icons.edit, size: 16),
                          label: const Text(
                            "Change Image",
                            style: TextStyle(fontSize: 12),
                          ),
                          style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        ),
                      ],
                    )
                  : Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async {
                          final image = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const FoundImagePicker(),
                            ),
                          );
                          if (image != null && image is File) {
                            setState(() {
                              selectedImage = image;
                            });
                            if (manualCategory == null) {
                              String detected = await detectCategory(image);
                              setState(() {
                                detectedCategory = detected;
                              });
                            }
                          }
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.camera_alt, size: 55),
                              SizedBox(height: 8),
                              Text(
                                "Upload Image",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Upload or Generate image of the item",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
            ),

            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Category Detected: $detectedCategory",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.foundSelectedSuccess,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              236,
                              122,
                              60,
                            ),
                            shape: const StadiumBorder(),
                          ),
                          child: const Text(
                            "Accept",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Accept this suggestion?",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () async {
                            final result = await Navigator.pushNamed(
                              context,
                              AppRoutes.foundDeletedSuccess,
                            );

                            if (result != null) {
                              setState(() {
                                manualCategory = result as String;
                                detectedCategory = manualCategory!;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey,
                            shape: const StadiumBorder(),
                          ),
                          child: const Text(
                            "Delete",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (itemController.text.isEmpty ||
                      dateController.text.isEmpty ||
                      timeController.text.isEmpty ||
                      locationController.text.isEmpty ||
                      descriptionController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields")),
                    );
                    return;
                  }

                  if (selectedImage == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please upload an image")),
                    );
                    return;
                  }

                  try {
                    final compressedBytes = await _compressImage(
                      selectedImage!,
                    );
                    String base64Image = base64Encode(compressedBytes);

                    await FirebaseFirestore.instance
                        .collection('found_items')
                        .add({
                          'itemName': itemController.text,
                          'date': dateController.text,
                          'time': timeController.text,
                          'location': locationController.text,
                          'description': descriptionController.text,
                          'imageBase64': base64Image,
                          'category': manualCategory ?? detectedCategory,
                          'createdAt': Timestamp.now(),
                        });

                    bool enabled = await AppSettings.notificationsEnabled();

                    if (enabled) {
                      await NotificationService.show(
                        title: "New Found Item",
                        body: "A user reported a found item.",
                        payload: 'found',
                      );
                    }

                    if (!mounted) return;
                    Navigator.pushNamed(context, AppRoutes.foundItemSubmit);
                  } catch (e) {
                    if (!mounted) return;
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Error: $e")));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 236, 122, 60),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Submit Report",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
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
