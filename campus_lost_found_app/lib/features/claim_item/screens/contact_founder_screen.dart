import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import '../../../routes/app_routes.dart';

class ContactFounderScreen extends StatelessWidget {
  final String founderName;
  final String founderEmail;

  const ContactFounderScreen({
    super.key,
    required this.founderName,
    required this.founderEmail,
  });

  Future<String?> getFounderProfileImage() async {
    try {
      // First, find the user by email in users collection
      final querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: founderEmail)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final userData = querySnapshot.docs.first.data();
        final profileImageBase64 = userData['profileImage'];

        if (profileImageBase64 != null && profileImageBase64.isNotEmpty) {
          return profileImageBase64;
        }
      }

      // Check found_items collection for user profile
      final foundItemQuery = await FirebaseFirestore.instance
          .collection('found_items')
          .where('userEmail', isEqualTo: founderEmail)
          .limit(1)
          .get();

      if (foundItemQuery.docs.isNotEmpty) {
        final userData = foundItemQuery.docs.first.data();
        final profileImageBase64 = userData['userProfileImage'];

        if (profileImageBase64 != null && profileImageBase64.isNotEmpty) {
          return profileImageBase64;
        }
      }

      return null;
    } catch (e) {
      debugPrint("Error loading profile image: $e");
      return null;
    }
  }

  Future<void> _sendEmail(String to, String subject, String body) async {
    // Encode the subject and body properly to preserve spaces
    final encodedSubject = Uri.encodeComponent(subject);
    final encodedBody = Uri.encodeComponent(body);

    // Create mailto URL with properly encoded parameters
    final mailToString = 'mailto:$to?subject=$encodedSubject&body=$encodedBody';
    final Uri emailUri = Uri.parse(mailToString);

    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('No email app found on this device');
      }
    } catch (e) {
      debugPrint('Error launching email: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController subjectController = TextEditingController();
    final TextEditingController messageController = TextEditingController();

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
          "Contact Founder",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFounderCard(),
                      const SizedBox(height: 35),

                      const Text(
                        'Sending a message to notify the person\nwho found the item',
                        style: TextStyle(
                          color: Color(0xFFB0B5BD),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 28),

                      _buildMessageBox(subjectController, messageController),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              _buildSendButton(context, subjectController, messageController),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFounderCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F1F4),
        border: Border.all(color: const Color(0xFFD0D3D8)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          FutureBuilder<String?>(
            future: getFounderProfileImage(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color(0xFF1F3C88),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                );
              }

              if (snapshot.hasError) {
                debugPrint("Error loading profile: ${snapshot.error}");
                return CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xFF1F3C88),
                  child: Text(
                    founderName.isNotEmpty ? founderName[0].toUpperCase() : "?",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              }

              final profileImageBase64 = snapshot.data;

              if (profileImageBase64 != null && profileImageBase64.isNotEmpty) {
                try {
                  // Try to decode and display the image
                  final imageBytes = base64Decode(profileImageBase64);
                  return CircleAvatar(
                    radius: 30,
                    backgroundImage: MemoryImage(imageBytes),
                    onBackgroundImageError: (error, stackTrace) {
                      debugPrint("Image decode error: $error");
                    },
                  );
                } catch (e) {
                  debugPrint("Error decoding image: $e");
                  return CircleAvatar(
                    radius: 30,
                    backgroundColor: const Color(0xFF1F3C88),
                    child: Text(
                      founderName.isNotEmpty
                          ? founderName[0].toUpperCase()
                          : "?",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  );
                }
              } else {
                // Show default avatar with first letter of name
                return CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color(0xFF1F3C88),
                  child: Text(
                    founderName.isNotEmpty ? founderName[0].toUpperCase() : "?",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                );
              }
            },
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contacting: $founderName',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.mail_outline,
                      size: 18,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        founderEmail,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBox(
    TextEditingController subjectController,
    TextEditingController messageController,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFD3D3D3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Subject Field
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFD3D3D3))),
            ),
            child: Row(
              children: [
                const Text(
                  'Subject:',
                  style: TextStyle(
                    color: Color(0xFFB0B5BD),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: subjectController,
                    decoration: const InputDecoration(
                      hintText: "Enter email subject...",
                      hintStyle: TextStyle(
                        color: Color(0xFFB0B5BD),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Message Field
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: messageController,
              maxLines: 8,
              minLines: 5,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Type your message here...",
                hintStyle: TextStyle(
                  color: Color(0xFFB0B5BD),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.6,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton(
    BuildContext context,
    TextEditingController subjectController,
    TextEditingController messageController,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: () async {
          final subject = subjectController.text.trim();
          final message = messageController.text.trim();

          if (subject.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please enter a subject"),
                backgroundColor: Colors.black,
              ),
            );
            return;
          }

          if (message.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Please enter your message"),
                backgroundColor: Colors.black,
              ),
            );
            return;
          }

          // Show loading
          final snackBar = ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Opening email app..."),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.black,
            ),
          );

          try {
            await _sendEmail(founderEmail, subject, message);
            snackBar.close();

            // Show success message before navigating
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Email opened successfully!"),
                duration: Duration(seconds: 1),
                backgroundColor: Colors.black,
              ),
            );

            // Navigate to home screen after email is sent
            await Future.delayed(const Duration(milliseconds: 500));
            Navigator.pushNamedAndRemoveUntil(
              context,
              AppRoutes.home,
              (route) => false,
            );
          } catch (e) {
            snackBar.close();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Error: ${e.toString()}"),
                backgroundColor: Colors.black,
                duration: const Duration(seconds: 3),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEB7B34),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: const Icon(Icons.send_outlined, size: 20),
        label: const Text(
          'Send Email',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
