import 'package:flutter/material.dart';

class ContactOwnerScreen extends StatelessWidget {
  final String ownerName;
  final String ownerEmail;

  const ContactOwnerScreen({
    super.key,
    required this.ownerName,
    required this.ownerEmail,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: const Color(0xFF1F3C88),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          "Contact Owner",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),

          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildFounderCard(),
                      const SizedBox(height: 35),

                      const Text(
                        'Sending a message to the owner to inform\nthem about the item',
                        style: TextStyle(
                          color: Color(0xFFB0B5BD),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          height: 1.4,
                        ),
                      ),

                      const SizedBox(height: 28),

                      _buildMessageBox(),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 12),

              _buildSendButton(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFounderCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F1F4),
        border: Border.all(color: const Color(0xFFD0D3D8)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('assets/images/black_wallet.png'),
          ),
          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Contacting: Sanju Srimal',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.mail_outline, size: 18, color: Colors.black54),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        'sanjusrimal@gmail.com',
                        style: TextStyle(fontSize: 15, color: Colors.black87),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFD3D3D3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFD3D3D3))),
            ),
            child: const Text(
              'Type Your Message...',
              style: TextStyle(
                color: Color(0xFFB0B5BD),
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Text Field
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: const TextField(
              maxLines: 8,
              minLines: 5,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Type your message here...",
                hintStyle: TextStyle(
                  color: Color(0xFFB0B5BD),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.6,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Icons section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFD3D3D3))),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.add_photo_alternate_outlined,
                  color: Colors.lightBlue,
                  size: 22,
                ),
                const SizedBox(width: 10),
                Icon(Icons.timer_outlined, color: Colors.lightBlue, size: 22),
                const SizedBox(width: 10),
                const Text(
                  'GIF',
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.sentiment_satisfied_alt_outlined,
                  color: Colors.lightBlue,
                  size: 24,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF254EBA),
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: const Icon(Icons.send_outlined, size: 20),
        label: const Text(
          'Send Email',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
