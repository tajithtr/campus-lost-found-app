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
              children: [
                Text(
                  'Contacting: $ownerName',
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.mail_outline,
                      size: 18,
                      color: Colors.black54,
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        ownerEmail,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Colors.black87,
                        ),
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
          // Subject Field
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFD3D3D3))),
            ),
            child: Row(
              children: [
                const Text(
                  'Subject:',
                  style: TextStyle(
                    color: Color(0xFFB0B5BD),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Enter email subject...",
                      hintStyle: TextStyle(
                        color: Color(0xFFB0B5BD),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Message Field
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
        ],
      ),
    );
  }

  Widget _buildSendButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: () {
          // Handle send email functionality here
        },
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
