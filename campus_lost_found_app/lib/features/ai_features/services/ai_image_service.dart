import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class AIService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> generateImage(String description, String type) async {
    try {
      
      final response = await http.post(
        Uri.parse("https://api.openai.com/v1/images/generations"),
        headers: {
          "Authorization": "Bearer YOUR_API_KEY",
          "Content-Type": "application/json",
        },
        body: jsonEncode({"prompt": description, "n": 1, "size": "512x512"}),
      );

      final data = jsonDecode(response.body);

      String imageUrl = data["data"][0]["url"];

      await _firestore.collection('ai_images').add({
        "description": description,
        "imageUrl": imageUrl,
        "type": type,
        "createdAt": Timestamp.now(),
      });

      return imageUrl;
    } catch (e, stack) {
      log('Error generating AI image', error: e, stackTrace: stack);
      return null;
    }
  }
}
