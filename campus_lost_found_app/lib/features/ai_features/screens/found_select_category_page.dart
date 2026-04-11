import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';

class FoundSelectCategoryPage extends StatefulWidget {
  @override
  _FoundSelectCategoryPageState createState() =>
      _FoundSelectCategoryPageState();
}

class _FoundSelectCategoryPageState extends State<FoundSelectCategoryPage> {
  String selectedCategory = "";

  final List<Map<String, dynamic>> categories = [
    {"name": "Electronics", "icon": Icons.phone_iphone, "color": Colors.blue},
    {"name": "Bag", "icon": Icons.shopping_bag_outlined, "color": Colors.brown},
    {"name": "ID Card", "icon": Icons.credit_card, "color": Colors.blue},
    {
      "name": "Wallet",
      "icon": Icons.account_balance_wallet_outlined,
      "color": Colors.blue,
    },
    {"name": "Accessories", "icon": Icons.lock, "color": Colors.blue},
    {"name": "Books", "icon": Icons.menu_book_outlined, "color": Colors.red},
    {"name": "Keys", "icon": Icons.vpn_key_outlined, "color": Colors.orange},
    {
      "name": "Other",
      "icon": Icons.inventory_2_outlined,
      "color": Colors.orange,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text(
          "Select Category for Found Item",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.1,
          children: categories.map((cat) {
            bool isSelected = selectedCategory == cat["name"];

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedCategory = cat["name"];
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isSelected ? cat["color"] : Colors.grey.shade300,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(cat["icon"], size: 40, color: cat["color"]),
                    const SizedBox(height: 10),
                    Text(
                      cat["name"],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.reportFoundItem);
            if (selectedCategory.isNotEmpty) {
              print("Selected Category: $selectedCategory");
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 236, 122, 60),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: 14),
          ),
          child: Text(
            "Save",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
