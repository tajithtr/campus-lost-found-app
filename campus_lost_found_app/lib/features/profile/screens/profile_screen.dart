import 'package:flutter/material.dart';
import '../../../widgets/navigation_bar.dart';
import '../../../routes/app_routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool notificationOn = true;

  int _selectedIndex = 3;
  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();

    _screens = [
      const Scaffold(body: Center(child: Text("Home Page"))),
      const Scaffold(body: Center(child: Text("Lost Items Page"))),
      const Scaffold(body: Center(child: Text("Found Items Page"))),
      _ProfileTab(
        notificationOn: notificationOn,
        onToggle: (value) {
          setState(() {
            notificationOn = value;
            _screens[3] = _ProfileTab(
              notificationOn: notificationOn,
              onToggle: (val) {
                setState(() {
                  notificationOn = val;
                });
              },
            );
          });
        },
      ),
    ];
  }

  void _onBottomNavTap(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        AppRoutes.goTo(context, AppRoutes.home);
        break;
      case 1:
        AppRoutes.goTo(context, AppRoutes.lostItems);
        break;
      case 2:
        AppRoutes.goTo(context, AppRoutes.foundItems);
        break;
      case 3:
        // Already here
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: AppNavigationBar(
        selectedIndex: _selectedIndex,
        onTap: _onBottomNavTap,
      ),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  final bool notificationOn;
  final Function(bool) onToggle;

  const _ProfileTab({required this.notificationOn, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF254EBA),
      body: Column(
        children: [
          const SizedBox(height: 60),

          Stack(
            children: [
              const CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('assets/profile.jpg'),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 16,
                    color: Color(0xFF2F4FB2),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          const Text(
            "Sarah Ayeshi",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Hello, Sarah 👋",
            style: TextStyle(color: Colors.white70),
          ),

          const Text(
            "Welcome to Campus\nLost & Found",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70),
          ),

          const SizedBox(height: 30),

          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFF5F6FA),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  _menuTile(
                    Icons.description_outlined,
                    "My Reports",
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Divider(),
                  _menuTile(
                    Icons.lock_outline,
                    "Change Password",
                    style: const TextStyle(color: Colors.black),
                  ),
                  const Divider(),
                  _notificationTile(notificationOn, onToggle),
                  const Divider(),
                  _logoutTile(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuTile(IconData icon, String text, {TextStyle? style}) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFE6ECFF),
        child: Icon(icon, color: const Color(0xFF2F4FB2)),
      ),
      title: Text(text, style: style),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }

  Widget _notificationTile(bool value, Function(bool) onChanged) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Color(0xFFF0F4FF),
        child: Icon(
          Icons.notifications_outlined,
          size: 20,
          color: Color(0xFF2F4FB2),
        ),
      ),
      title: const Text("Notification", style: TextStyle(color: Colors.black)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: const Color(0xFF2F4FB2),
      ),
    );
  }

  Widget _logoutTile(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Color(0xFFFFE6E6),
        child: Icon(Icons.error_outline, color: Colors.red),
      ),
      title: const Text("Logout", style: TextStyle(color: Colors.red)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        _showLogoutDialog(context);
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.logout, size: 50, color: Color(0xFF254EBA)),
              const SizedBox(height: 15),
              const Text(
                "Are you sure to log out of your account?",
                style: TextStyle(color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF254EBA),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Log Out",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Color(0xFF2564C9)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
