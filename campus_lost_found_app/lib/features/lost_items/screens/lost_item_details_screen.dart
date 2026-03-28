import 'package:flutter/material.dart';


class LostItemDetailsScreen extends StatefulWidget {
  @override
  _LostItemDetailsScreenState createState() => _LostItemDetailsScreenState();
}

class _LostItemDetailsScreenState extends State<LostItemDetailsScreen> {
  bool isExpanded = false;

  final String description =
      "A black leather wallet that contains several personal ID cards and some cash. It also includes a driving license, bank cards, and a few important receipts inside.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Color(0xFF1F3C88),
        centerTitle: true,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text(
          "Item Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 300,
              child: Image.asset(
                'assets/images/black_wallet.png',
                fit: BoxFit.cover,
                alignment: Alignment(0, 0.7),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Black Wallet",
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Color(0xFF254EBA),
                          borderRadius:
                              BorderRadius.circular(10),
                        ),
                        child: Text(
                          "LOST",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight:
                                  FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  infoRow(Icons.location_on,
                      "Location:  University Library – 2nd Floor"),
                  SizedBox(height: 10),
                  infoRow(Icons.calendar_today,
                      "Date & Time:  28 Jan 2026, around 3.30 PM"),
                  SizedBox(height: 10),
                  infoRow(Icons.grid_view,
                      "Category:  Wallet"),
                  SizedBox(height: 18),
                  Text(
                    "Description:",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    maxLines: isExpanded ? null : 2,
                    overflow: isExpanded
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.grey[700]),
                  ),
                  if (!isExpanded)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = true;
                        });
                      },
                      child: Text(
                        " See More...",
                        style: TextStyle(
                          color: Color(0xFF254EBA),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AI Possible Matches",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/black_wallet.png',
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 12),
                            Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Wallet:",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                                Text(
                                  "Found in University Library",
                                  style: TextStyle(
                                      color: Colors.black),
                                ),
                                Text(
                                  "28 Jan 2026, around 4.30 PM",
                                  style: TextStyle(
                                      color: Colors.black),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color(0xFF254EBA),
                        shape:
                            RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        "Claim This Item",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget infoRow(IconData icon, String text) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Color(0xFF64748B)),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Color(0xFF64748B),
              fontSize: 14,
            ),
          ),
        )
      ],
    );
  }
}