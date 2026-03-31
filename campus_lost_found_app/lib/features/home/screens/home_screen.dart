import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../widgets/navigation_bar.dart';
import '../../../routes/app_routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  String? userName;
  bool _loaded = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    // Initialize tabs/screens
    _screens = [
      _HomeTab(userName: userName),
      const Scaffold(body: Center(child: Text("Found Items Page"))),
      const Scaffold(body: Center(child: Text("Profile Page"))),
    ];

    loadUserName();
  }

  Future<void> loadUserName() async {
    final user = FirebaseAuth.instance.currentUser;
    String name = "User";

    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (doc.exists && doc.data() != null) {
          name = doc['name'];
        }
      } catch (_) {
        name = "User";
      }
    }

    await Future.delayed(const Duration(milliseconds: 300));

    if (!mounted) return;

    setState(() {
      userName = name;
      _loaded = true;
      _screens[0] = _HomeTab(userName: userName);
    });

    _fadeController.forward();
  }

  void _onBottomNavTap(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        break;
      case 1:
        AppRoutes.goTo(context, AppRoutes.lostItems);
        break;
      case 2:
        break;
      case 3:
        break;
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.blue[800],
            ),
          ),
        ),
      );
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Scaffold(
        body: IndexedStack(index: _selectedIndex, children: _screens),
        bottomNavigationBar: AppNavigationBar(
          selectedIndex: _selectedIndex,
          onTap: _onBottomNavTap,
        ),
      ),
    );
  }
}

// Home Tab

class _HomeTab extends StatelessWidget {
  final String? userName;

  const _HomeTab({this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        centerTitle: true,
        title: const Text(
          "Campus Lost & Found",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              "Welcome ${userName ?? "User"}!",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF000000),
              ),
            ),
            const SizedBox(height: 20),

            // Primary Cards
            _PrimaryCard(
              color: const Color(0xFF254EBA),
              icon: "assets/icons/report_lost_item.png",
              text: "Report Lost\nItem",
              onTap: () => AppRoutes.goTo(context, AppRoutes.reportLostItem),
            ),
            const SizedBox(height: 18),
            _PrimaryCard(
              color: const Color(0xFFEB7B34),
              icon: "assets/icons/report_found_item.png",
              text: "Report Found\nItem",
              onTap: () => AppRoutes.goTo(context, AppRoutes.reportFoundItem),
            ),
            const SizedBox(height: 24),

            // Secondary Cards
            _SecondaryCard(
              icon: "assets/icons/view_lost_items.png",
              text: "View Lost Items",
              onTap: () => AppRoutes.goTo(context, AppRoutes.lostItems),
            ),
            const SizedBox(height: 14),
            _SecondaryCard(
              icon: "assets/icons/view_found_items.png",
              text: "View Found Items",
              onTap: () => AppRoutes.goTo(context, AppRoutes.foundItems),
            ),
            const SizedBox(height: 14),
            _SecondaryCard(
              icon: "assets/icons/my_reported_items.png",
              text: "My Reported Items",
              onTap: () => AppRoutes.goTo(context, AppRoutes.myReports),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Cards

class _PrimaryCard extends StatelessWidget {
  final Color color;
  final String icon;
  final String text;
  final VoidCallback onTap;

  const _PrimaryCard({
    required this.color,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}

class _SecondaryCard extends StatelessWidget {
  final String icon;
  final String text;
  final VoidCallback onTap;

  const _SecondaryCard({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
