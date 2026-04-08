import 'package:flutter/material.dart';

class ContactFounderScreen extends StatefulWidget {
  const ContactFounderScreen({super.key});

  @override
  State<ContactFounderScreen> createState() => _ContactFounderScreenState();
}

class _ContactFounderScreenState extends State<ContactFounderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "Contact Owner",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            const SizedBox(height: 20),

            ///  Contact Card
            Container(
              width: double.infinity,
              height: 90,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 239, 239, 248),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300, width: 2),
              ),
              child: Row(
                children: [
                  ///  Profile Image (Asset)
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage("assets/photo_2.jpg"),
                  ),

                  const SizedBox(width: 12),

                  ///  Text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Contacting: Sanju Srimal",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text("sanjusrimal98@gmail.com"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            /// Title
            const Text(
              "Item Claim Request",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 20),

            ///  Subtitle
            const Text(
              "To claim this item you must verify ownership.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),

            const SizedBox(height: 30),

            ///  Verification Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF254EBA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Start Verification",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),///  Small Description
            const Text(
              "Answer a few questions to prove you are the real owner of this item.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),

            const SizedBox(height: 40),

            ///  Contact Directly
            const Text(
              "Contact owner directly",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 25),

            ///  Email Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 236, 122, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.send, color: Colors.white),
                label: const Text(
                  "Send Email",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            
            ///  Bottom Note
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[200], // ash/light grey background
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Security-style icon with exclamation
                    Container(
                      
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.error_outline, // exclamation icon
                        size: 20,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Text
                    const Flexible(
                      child: Text(
                        "For security, ownership verification is required before contacting the finder.",
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}