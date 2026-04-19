import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FoundItemDeliveryConfirmationScreen extends StatefulWidget {
  final String itemId;

  const FoundItemDeliveryConfirmationScreen({super.key, required this.itemId});

  @override
  State<FoundItemDeliveryConfirmationScreen> createState() =>
      _FoundItemDeliveryConfirmationScreenState();
}

class _FoundItemDeliveryConfirmationScreenState
    extends State<FoundItemDeliveryConfirmationScreen> {
  bool isLoading = false;

  Future<void> _deleteItem() async {
    setState(() => isLoading = true);

    try {
      await FirebaseFirestore.instance
          .collection('found_items')
          .doc(widget.itemId)
          .delete();

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      setState(() => isLoading = false);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error deleting item: $e")));
    }
  }

  void _handleNo() {
    Navigator.pop(context);
  }

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
          "Found Item Status",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        children: [
          const SizedBox(height: 80),

          const Icon(
            Icons.assignment_turned_in,
            size: 90,
            color: Color.fromARGB(255, 236, 122, 60),
          ),

          const SizedBox(height: 30),

          const Text(
            "Has the found item been returned?",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 10),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Text(
              "Confirm whether this found item has been successfully returned to its owner. "
              "If yes, it will be permanently removed from your found items list.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),

          const SizedBox(height: 50),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: isLoading ? null : _deleteItem,
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 236, 122, 60),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(Icons.check, color: Colors.white),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Yes",
                      style: TextStyle(
                        color: Color.fromARGB(255, 236, 122, 60),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: _handleNo,
                child: Column(
                  children: [
                    Container(
                      width: 120,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.close, color: Colors.black),
                    ),
                    const SizedBox(height: 6),
                    const Text("No"),
                  ],
                ),
              ),
            ],
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _handleNo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE0E0E0),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  "Back to My Found Item List",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
