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

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

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
          final data = doc.data();
          name = data?['name'] ?? "User";
        }
      } catch (_) {}
    }

    if (!mounted) return;

    setState(() {
      userName = name;
      _loaded = true;
    });

    _fadeController.forward();
  }

  void _onBottomNavTap(int index) {
    if (index == _selectedIndex) return;

    setState(() => _selectedIndex = index);

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, AppRoutes.home);
        break;
      case 1:
        Navigator.pushReplacementNamed(context, AppRoutes.lostItems);
        break;
      case 2:
        Navigator.pushReplacementNamed(context, AppRoutes.foundItems);
        break;
      case 3:
        Navigator.pushReplacementNamed(context, AppRoutes.profile);
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
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Scaffold(
        body: _HomeTab(userName: userName),
        bottomNavigationBar: AppNavigationBar(
          selectedIndex: _selectedIndex,
          onTap: _onBottomNavTap,
        ),
      ),
    );
  }
}

// HOME TAB

class _HomeTab extends StatelessWidget {
  final String? userName;

  const _HomeTab({this.userName});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

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
              const SizedBox(width: 48),
              const Expanded(
                child: Text(
                  "Campus Lost & Found",
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome ${userName ?? "User"}!",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                _PrimaryCard(
                  height: height * 0.16,
                  color: const Color(0xFF254EBA),
                  icon: "assets/icons/report_lost_item.png",
                  text: "Report Lost\nItem",
                  onTap: () =>
                      AppRoutes.goTo(context, AppRoutes.reportLostItem),
                ),

                const SizedBox(height: 16),

                _PrimaryCard(
                  height: height * 0.16,
                  color: const Color(0xFFEB7B34),
                  icon: "assets/icons/report_found_item.png",
                  text: "Report Found\nItem",
                  onTap: () =>
                      AppRoutes.goTo(context, AppRoutes.reportFoundItem),
                ),

                const SizedBox(height: 24),

                _SecondaryCard(
                  height: height * 0.11,
                  icon: "assets/icons/view_lost_items.png",
                  text: "View Lost Items",
                  onTap: () => AppRoutes.goTo(context, AppRoutes.lostItems),
                ),

                const SizedBox(height: 12),

                _SecondaryCard(
                  height: height * 0.11,
                  icon: "assets/icons/view_found_items.png",
                  text: "View Found Items",
                  onTap: () => AppRoutes.goTo(context, AppRoutes.foundItems),
                ),

                const SizedBox(height: 12),

                _SecondaryCard(
                  height: height * 0.11,
                  icon: "assets/icons/my_reported_items.png",
                  text: "My Reported Items",
                  onTap: () => AppRoutes.goTo(context, AppRoutes.myReports),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// PRIMARY CARD

class _PrimaryCard extends StatelessWidget {
  final double height;
  final Color color;
  final String icon;
  final String text;
  final VoidCallback onTap;

  const _PrimaryCard({
    required this.height,
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
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Image.asset(icon, width: height * 0.6),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// SECONDARY CARD

class _SecondaryCard extends StatelessWidget {
  final double height;
  final String icon;
  final String text;
  final VoidCallback onTap;

  const _SecondaryCard({
    required this.height,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(217, 217, 217, 0.6),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(icon, width: height * 0.7),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: height * 0.22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
