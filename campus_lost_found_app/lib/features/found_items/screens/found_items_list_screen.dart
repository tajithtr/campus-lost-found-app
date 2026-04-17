import 'package:flutter/material.dart';
import 'found_item_details_screen.dart';
import '../../../widgets/navigation_bar.dart';
import '../../../routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class FoundItemsScreen extends StatefulWidget {
  const FoundItemsScreen({super.key});

  @override
  State<FoundItemsScreen> createState() => _FoundItemsScreenState();
}

class _FoundItemsScreenState extends State<FoundItemsScreen> {
  int _selectedIndex = 2;

  void _onBottomNavTap(int index) {
    if (_selectedIndex == index) return;

    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, AppRoutes.lostItems);
        break;
      case 2:
        break;
      case 3:
        Navigator.pushReplacementNamed(context, AppRoutes.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _FoundTab(),
      bottomNavigationBar: AppNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}

class _FoundTab extends StatelessWidget {
  _FoundTab();

  final TextEditingController searchController = TextEditingController();
  final ValueNotifier<String> searchText = ValueNotifier<String>("");

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: const Color(0xFF1F3C88),
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 10,
            left: 16,
            right: 16,
            bottom: 16,
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              const Expanded(
                child: Text(
                  "Found Items",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(width: 48),
            ],
          ),
        ),

        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      searchText.value = value.trim().toLowerCase();
                    },
                    decoration: InputDecoration(
                      hintText: "Search Items...",
                      hintStyle: TextStyle(fontWeight: FontWeight.bold),
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.lostItems,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: const Center(
                            child: Text(
                              "Lost Items",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 236, 122, 60),
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        child: const Center(
                          child: Text(
                            "Found Items",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                ValueListenableBuilder(
                  valueListenable: searchText,
                  builder: (context, value, _) {
                    return _FoundItemCard(searchText: value);
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FoundItemCard extends StatelessWidget {
  final String searchText;

  const _FoundItemCard({required this.searchText});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('found_items')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text("No found items yet"));
        }

        final docs = snapshot.data!.docs.where((doc) {
          final itemName = (doc['itemName'] ?? "").toString().toLowerCase();
          final category = (doc['category'] ?? "").toString().toLowerCase();
          final location = (doc['location'] ?? "").toString().toLowerCase();

          if (searchText.isEmpty) return true;

          return itemName.contains(searchText) ||
              category.contains(searchText) ||
              location.contains(searchText);
        }).toList();

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index];

            final itemName = data['itemName'] ?? "";
            final location = data['location'] ?? "";
            final date = data['date'] ?? "";
            final time = data['time'] ?? "";
            final imageBase64 = data['imageBase64'] ?? "";

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:
                          (imageBase64 != null &&
                              imageBase64.toString().isNotEmpty)
                          ? Image.memory(
                              base64Decode(imageBase64),
                              fit: BoxFit.cover,
                              gaplessPlayback: true,
                            )
                          : const Icon(Icons.image),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          itemName,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Row(
                          children: [
                            const Icon(
                              Icons.location_on,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                "Found at: $location",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 4),

                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              "Found on: $date, $time",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 8),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FoundItemDetailsScreen(
                                  itemName: itemName,
                                  location: location,
                                  date: date,
                                  time: time,
                                  category: data['category'] ?? "",
                                  description: data['description'] ?? "",
                                  imageBase64: imageBase64,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 236, 122, 60),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Text(
                              "View Details",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
