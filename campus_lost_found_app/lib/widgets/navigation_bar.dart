import 'package:flutter/material.dart';

class AppNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const AppNavigationBar({
    required this.selectedIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFFF8FAFC),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      selectedItemColor: const Color(0xFF254EBA),
      unselectedItemColor: Colors.grey,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.location_on), label: "Lost"),
        BottomNavigationBarItem(
          icon: Icon(Icons.pan_tool_outlined),
          label: "Found",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: "Profile",
        ),
      ],
    );
  }
}
