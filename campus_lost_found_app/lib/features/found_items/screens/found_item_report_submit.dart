import 'package:flutter/material.dart';
import '../../../routes/app_routes.dart';

class FoundItemReportSubmit extends StatelessWidget {
  const FoundItemReportSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a reusable orange color
    const orangeColor = Color.fromARGB(255, 236, 122, 60);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),

          // Main column layout
          child: Column(
            children: [
              // Push content to center vertically
              const Expanded(flex: 3, child: SizedBox()),

              // Success icon
              const Icon(Icons.check_circle, size: 100, color: Colors.green),

              const SizedBox(height: 20),

              // Success title
              const Text(
                "Report Submitted Successfully!",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              // Subtitle / description
              const Text(
                "Your found item has been added to the system.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),

              // Space before buttons
              const Expanded(flex: 2, child: SizedBox()),

              // View Found Items button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to Found Items Screen
                    Navigator.pushNamed(context, AppRoutes.foundItems);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orangeColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    "View Found Items",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Back to Home button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate back to Home Screen and clear stack
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.home,
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFE0E0E0),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    "Back to Home",
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
