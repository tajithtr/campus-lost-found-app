import 'package:flutter/material.dart';

class DeliveryReminderScreen extends StatefulWidget {
  const DeliveryReminderScreen({super.key});

  @override
  State<DeliveryReminderScreen> createState() =>
      _DeliveryReminderScreenState();
}

class _DeliveryReminderScreenState extends State<DeliveryReminderScreen> {
  bool? isDelivered;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F3F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Delivery Reminder",
          style: TextStyle(color: Colors.white),
        ),
        leading: const Icon(Icons.arrow_back, color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Icon(
              Icons.assignment_turned_in,
              size: 90,
              color: Color(0xFF3A63D1),
            ),
            const SizedBox(height: 20),
            const Text(
              "Delivery Reminder",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(color: Colors.grey, fontSize: 15),
                children: [
                  TextSpan(text: "Reminder : "),
                  TextSpan(
                    text:
                        "Has the item been successfully delivered?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => setState(() => isDelivered = true),
                  child: Column(
                    children: [
                      Container(
                        width: 140,
                        height: 55,
                        decoration: BoxDecoration(
                          color: const Color(0xFF63D2A3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.black,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Yes",
                        style: TextStyle(color: Color(0xFF63D2A3)),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () => setState(() => isDelivered = false),
                  child: Column(
                    children: [
                      Container(
                        width: 140,
                        height: 55,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDCE3E1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 28,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text("No"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 80),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF254EBA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Confirm Delivery",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}