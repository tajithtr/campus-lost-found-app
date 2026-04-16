import 'dart:convert';
import 'dart:io';
import 'package:campus_lost_found_app/features/ai_features/screens/lost_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_image_labeling/google_mlkit_image_labeling.dart';
import '../../../routes/app_routes.dart';
import '../../ai_features/screens/lost_ai_image_generator_screen.dart';


class ReportLostItemScreen extends StatefulWidget {
  const ReportLostItemScreen({super.key});

  @override
  State<ReportLostItemScreen> createState() => ReportLostItemScreenState();
}

class ReportLostItemScreenState extends State<ReportLostItemScreen> {
  TextEditingController itemController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  File? selectedImage;
  String detectedCategory = "Detecting...";
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

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

  void uploadImage() {}

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
          "Report Lost Item",
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
            inputField("Location Lost", controller: locationController),
            inputField(
              "Description",
              maxLines: 3,
              controller: descriptionController,
            ),

            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () async {
                    final image = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LostImagePicker(),
                      ),
                    );

                    if (image != null) {
                      setState(() {
                        selectedImage = image;
                      });

                      String detected = await detectCategory(image);

                      setState(() {
                        detectedCategory = detected;
                      });
                    }
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Icon(Icons.camera_alt, size: 55),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
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
                              AppRoutes.lostselectedSuccess,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF254EBA),
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
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              AppRoutes.lostdeletedSSuccess,
                            );
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
                    final bytes = await selectedImage!.readAsBytes();
                    String base64Image = base64Encode(bytes);

                    await FirebaseFirestore.instance
                        .collection('lost_items')
                        .add({
                          'itemName': itemController.text,
                          'date': dateController.text,
                          'time': timeController.text,
                          'location': locationController.text,
                          'description': descriptionController.text,
                          'imageBase64': base64Image,
                          'category': detectedCategory,
                          'createdAt': Timestamp.now(),
                        });
                    if (!context.mounted) return;
                    Navigator.pushNamed(context, AppRoutes.lostItemSubmit);
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Error: $e")));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF254EBA),
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
