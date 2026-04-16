import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import 'dart:convert';

class FoundItemDetailsScreen extends StatefulWidget {
  final String itemName;
  final String location;
  final String date;
  final String time;
  final String category;
  final String description;
  final String imageBase64;

  const FoundItemDetailsScreen({
    super.key,
    required this.itemName,
    required this.location,
    required this.date,
    required this.time,
    required this.category,
    required this.description,
    required this.imageBase64,
  });

  @override
  State<FoundItemDetailsScreen> createState() => FoundItemDetailsScreenState();
}

class FoundItemDetailsScreenState extends State<FoundItemDetailsScreen> {
  bool isExpanded = false;

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
          "Item Details",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.memory(
                base64Decode(widget.imageBase64),
                fit: BoxFit.fill,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.itemName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 236, 122, 60),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "FOUND",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  infoRow(Icons.location_on, "Location: ${widget.location}"),
                  const SizedBox(height: 10),
                  infoRow(
                    Icons.calendar_today,
                    "Found on: ${widget.date} at ${widget.time}",
                  ),
                  const SizedBox(height: 10),
                  infoRow(Icons.grid_view, "Category: ${widget.category}"),
                  const SizedBox(height: 18),
                  const Text(
                    "Description:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    maxLines: isExpanded ? null : 2,
                    overflow: isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  if (!isExpanded)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = true;
                        });
                      },
                      child: const Text(
                        " See More...",
                        style: TextStyle(
                          color: Color(0xFF254EBA),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "AI Possible Owner Matches",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/usb.jpg',
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "USB Drive:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  "Lost in FOC L104",
                                  style: TextStyle(color: Colors.black),
                                ),
                                Text(
                                  "29 Jan 2026, around 3:30 PM",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          236,
                          122,
                          60,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.contactFounder);
                      },
                      child: const Text(
                        "Contact Founder",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: const Color(0xFF64748B)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(color: Color(0xFF64748B), fontSize: 14),
          ),
        ),
      ],
    );
  }
}
