import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:campus_lost_found_app/features/claim_item/screens/contact_founder_screen.dart';

class FoundItemDetailsScreen extends StatefulWidget {
  final String itemName;
  final String location;
  final String date;
  final String time;
  final String category;
  final String description;
  final String imageBase64;
  final String founderName;
  final String founderEmail;

  const FoundItemDetailsScreen({
    super.key,
    required this.itemName,
    required this.location,
    required this.date,
    required this.time,
    required this.category,
    required this.description,
    required this.imageBase64,
    required this.founderName,
    required this.founderEmail,
  });

  @override
  State<FoundItemDetailsScreen> createState() => FoundItemDetailsScreenState();
}

class FoundItemDetailsScreenState extends State<FoundItemDetailsScreen> {
  bool isExpanded = false;

  Future<List<Map<String, dynamic>>> getMatchedLostItems() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('lost_items')
        .get();

    List<Map<String, dynamic>> matches = [];

    for (var doc in snapshot.docs) {
      final data = doc.data();

      double score = calculateMatchScore(data);

      if (score >= 0.5) {
        data['matchScore'] = score;
        matches.add(data);
      }
    }

    matches.sort(
      (a, b) =>
          (b['matchScore'] as double).compareTo(a['matchScore'] as double),
    );

    return matches;
  }

  double calculateMatchScore(Map<String, dynamic> lostItem) {
    double score = 0;

    final foundName = widget.itemName.toLowerCase();
    final lostName = (lostItem['itemName'] ?? '').toLowerCase();

    final foundLocation = widget.location.toLowerCase();
    final lostLocation = (lostItem['location'] ?? '').toLowerCase();

    final foundCategory = widget.category.toLowerCase();
    final lostCategory = (lostItem['category'] ?? '').toLowerCase();

    final foundDesc = widget.description.toLowerCase();
    final lostDesc = (lostItem['description'] ?? '').toLowerCase();

    if (lostName.contains(foundName) || foundName.contains(lostName)) {
      score += 0.4;
    } else {
      for (var word in foundName.split(" ")) {
        if (lostName.contains(word)) {
          score += 0.2;
          break;
        }
      }
    }

    if (lostLocation.contains(foundLocation) ||
        foundLocation.contains(lostLocation)) {
      score += 0.2;
    }

    if (foundCategory == lostCategory) {
      score += 0.2;
    }

    for (var word in foundDesc.split(" ")) {
      if (lostDesc.contains(word)) {
        score += 0.02;
      }
    }

    return score;
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
                        style: const TextStyle(
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
                        FutureBuilder<List<Map<String, dynamic>>>(
                          future: getMatchedLostItems(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Text("No matching lost items found");
                            }

                            final matches = snapshot.data!;

                            return Column(
                              children: matches.map((item) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: item['imageBase64'] != null
                                            ? Image.memory(
                                                base64Decode(
                                                  item['imageBase64'],
                                                ),
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.cover,
                                              )
                                            : Container(
                                                height: 50,
                                                width: 50,
                                                color: Colors.grey,
                                              ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item['itemName'] ?? '',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(item['location'] ?? ''),
                                          Text(
                                            "${item['date']} at ${item['time']}",
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          },
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContactFounderScreen(
                              founderName: widget.founderName,
                              founderEmail: widget.founderEmail,
                            ),
                          ),
                        );
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
