import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        centerTitle: true,
        title: const Text(
          "Campus Lost & Found",
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Text(
              "Welcome Sarah!",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
              ),
            ),
            const SizedBox(height: 20),
            _PrimaryCard(
              color: const Color(0xFF254EBA),
              icon: "assets/icons/report_lost_item.png",
              text: "Report Lost\nItem",
            ),
            const SizedBox(height: 18),
            _PrimaryCard(
              color: const Color(0xFFEB7B34),
              icon: "assets/icons/report_found_item.png",
              text: "Report Found\nItem",
            ),
            const SizedBox(height: 24),
            _SecondaryCard(
              icon: "assets/icons/view_lost_items.png",
              text: "View Lost Items",
            ),
            const SizedBox(height: 14),
            _SecondaryCard(
              icon: "assets/icons/view_found_items.png",
              text: "View Found Items",
            ),
            const SizedBox(height: 14),
            _SecondaryCard(
              icon: "assets/icons/my_reported_items.png",
              text: "My Reported Items",
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF8FAFC),
          border: Border(top: BorderSide(color: Color(0xFFCBD5E1), width: 0.5)),
        ),
        child: BottomNavigationBar(
          backgroundColor: const Color(0xFFF8FAFC),
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: 0,
          selectedItemColor: const Color(0xFF254EBA),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: "Lost",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pan_tool_outlined),
              label: "Found",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

class _PrimaryCard extends StatelessWidget {
  final Color color;
  final String icon;
  final String text;

  const _PrimaryCard({
    required this.color,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Image.asset(icon, width: 87, height: 87),
          const SizedBox(width: 18),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _SecondaryCard extends StatelessWidget {
  final String icon;
  final String text;

  const _SecondaryCard({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(217, 217, 217, 0.6),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Image.asset(icon, width: 87, height: 87),
          const SizedBox(width: 18),
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF000000),
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
