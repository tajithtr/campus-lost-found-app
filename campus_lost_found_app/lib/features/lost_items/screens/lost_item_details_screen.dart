import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class LostItemDetailsScreen extends StatefulWidget {
  final String itemName;
  final String location;
  final String date;
  final String time;
  final String category;
  final String description;
  final String imageBase64;

  const LostItemDetailsScreen({
    super.key,
    this.itemName = '',
    this.location = '',
    this.date = '',
    this.time = '',
    this.category = '',
    this.description = '',
    this.imageBase64 = '',
  });

  @override
  State<LostItemDetailsScreen> createState() =>
      LostItemDetailsScreenState();
}

class LostItemDetailsScreenState
    extends State<LostItemDetailsScreen> {
  bool isExpanded = false;

  Future<List<Map<String, dynamic>>> getMatchedItems() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('found_items')
        .get();

    List<Map<String, dynamic>> matches = [];

    for (var doc in snapshot.docs) {
      final data = doc.data();

      if (isMatch(data)) {
        matches.add(data);
      }
    }

    return matches;
  }

  bool isMatch(Map<String, dynamic> foundItem) {
    final lostName = widget.itemName.toLowerCase();
    final foundName =
        (foundItem['itemName'] ?? '').toLowerCase();

    final lostLocation = widget.location.toLowerCase();
    final foundLocation =
        (foundItem['location'] ?? '').toLowerCase();

    final lostCategory = widget.category.toLowerCase();
    final foundCategory =
        (foundItem['category'] ?? '').toLowerCase();

    return (foundCategory == lostCategory &&
        foundName.contains(lostName.split(" ").first) &&
        foundLocation.contains(
            lostLocation.split(" ").first));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        leading: IconButton(
          icon:
              const Icon(Icons.arrow_back, color: Colors.white),
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
                borderRadius:
                    BorderRadius.vertical(
                        top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
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
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color:
                              const Color(0xFF254EBA),
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "LOST",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  infoRow(
                    Icons.location_on,
                    "Location: ${widget.location}",
                  ),
                  const SizedBox(height: 10),
                  infoRow(
                    Icons.calendar_today,
                    "Lost on: ${widget.date} at ${widget.time}",
                  ),
                  const SizedBox(height: 10),
                  infoRow(Icons.grid_view,
                      "Category: ${widget.category}"),
                  const SizedBox(height: 18),
                  const Text(
                    "Description:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight:
                            FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    maxLines:
                        isExpanded ? null : 2,
                    overflow: isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.grey[700]),
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
                          color:
                              Color(0xFF254EBA),
                          fontWeight:
                              FontWeight.w500,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Container(
                    padding:
                        const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                      children: [
                        const Text(
                          "AI Possible Founder Matches",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        FutureBuilder<
                            List<Map<String,
                                dynamic>>>(
                          future: getMatchedItems(),
                          builder:
                              (context, snapshot) {
                            if (snapshot
                                    .connectionState ==
                                ConnectionState
                                    .waiting) {
                              return const Center(
                                child:
                                    CircularProgressIndicator(),
                              );
                            }

                            if (!snapshot.hasData ||
                                snapshot.data!
                                    .isEmpty) {
                              return const Text(
                                  "No matches found");
                            }

                            final matches =
                                snapshot.data!;

                            return Column(
                              children:
                                  matches.map((item) {
                                return Padding(
                                  padding:
                                      const EdgeInsets
                                          .only(
                                              bottom:
                                                  10),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius
                                                .circular(
                                                    8),
                                        child: item[
                                                    'imageBase64'] !=
                                                null
                                            ? Image.memory(
                                                base64Decode(
                                                    item[
                                                        'imageBase64']),
                                                height:
                                                    50,
                                                width:
                                                    50,
                                                fit: BoxFit
                                                    .cover,
                                              )
                                            : Container(
                                                height:
                                                    50,
                                                width:
                                                    50,
                                                color: Colors
                                                    .grey,
                                              ),
                                      ),
                                      const SizedBox(
                                          width: 12),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment
                                                .start,
                                        children: [
                                          Text(
                                            item[
                                                    'itemName'] ??
                                                '',
                                            style:
                                                const TextStyle(
                                              fontWeight:
                                                  FontWeight
                                                      .bold,
                                            ),
                                          ),
                                          Text(item[
                                                  'location'] ??
                                              ''),
                                          Text(
                                              "${item['date']} at ${item['time']}"),
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
                      style: ElevatedButton
                          .styleFrom(
                        backgroundColor:
                            const Color(
                                0xFF254EBA),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius
                                  .circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.contactOwner,
                        );
                      },
                      child: const Text(
                        "Contact Owner",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
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
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: const Color(0xFF64748B),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFF64748B),
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}