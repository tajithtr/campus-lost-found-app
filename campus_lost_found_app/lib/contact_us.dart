import 'package:flutter/material.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  bool isLiked = false;

  static const TextStyle kTitle = TextStyle(
    color: Colors.white,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle kSubtitle = TextStyle(
    color: Colors.white70,
    fontSize: 14,
    height: 1.4,
  );

  static const TextStyle kSectionTitle = TextStyle(
    color: Color(0xFF1F3C88),
    fontSize: 17,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle kCardTitle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle kCardSubtitle = TextStyle(
    fontSize: 14.5,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle kBody = TextStyle(color: Colors.black54, height: 1.4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        elevation: 0,
        toolbarHeight: kToolbarHeight + 10,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text(
          "Contact Us",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            /// HEADER
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [Color(0xFF1F3C88), Color(0xFF2564C9)],
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("We’re Here To Help", style: kTitle),
                            SizedBox(height: 6),
                            Text(
                              "Support & assistance anytime",
                              style: kSubtitle,
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white24,
                        child: Icon(
                          Icons.support_agent,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12),

                  Text(
                    "If you need help, have questions, or face any issues, our team is always ready to support you quickly and effectively.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12.5,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 22),

            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("Get In Touch", style: kSectionTitle),
                ),
                Expanded(child: Divider()),
              ],
            ),

            const SizedBox(height: 18),

            _contactCard(
              icon: Icons.email_outlined,
              iconColor: Color(0xFF2564C9),
              iconBg: Color(0xFFEAF0FF),
              title: "Email",
              subtitle: "support@campuslostfound.com",
              desc: "We respond within a short time.",
            ),

            const SizedBox(height: 12),

            _contactCard(
              icon: Icons.phone,
              iconColor: Colors.green,
              iconBg: Color(0xFFEAF7EE),
              title: "Phone",
              subtitle: "+94 71 234 5678",
              desc: "Mon - Fri (9:00 AM - 5:00 PM)",
            ),

            const SizedBox(height: 12),

            _contactCard(
              icon: Icons.location_on_outlined,
              iconColor: Colors.deepPurple,
              iconBg: Color(0xFFF2EAFF),
              title: "Address",
              subtitle:
                  "NSBM Green University Town,\nPitipana, Homagama, Sri Lanka.",
              desc: "Visit our campus anytime.",
            ),

            /// 🔥 FIXED SPACING (KEY FIX)
            const SizedBox(height: 30),

            /// ACTION BUTTON
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: const Color(0xFF2564C9)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLiked = true;
                      });

                      Future.delayed(const Duration(milliseconds: 150), () {
                        Navigator.pop(context);
                      });
                    },
                    child: Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : const Color(0xFF2564C9),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Thanks for reaching out",
                    style: TextStyle(
                      color: Color(0xFF2564C9),
                      fontWeight: FontWeight.w600,
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

  Widget _contactCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required String desc,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: iconBg,
            child: Icon(icon, color: iconColor, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: kCardTitle),
                const SizedBox(height: 4),
                Text(subtitle, style: kCardSubtitle),
                const SizedBox(height: 4),
                Text(desc, style: kBody),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
