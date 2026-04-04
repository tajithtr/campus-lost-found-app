import 'package:flutter/material.dart';

class CreateCategoryPage extends StatefulWidget {
  @override
  _CreateCategoryPageState createState() => _CreateCategoryPageState();
}

class _CreateCategoryPageState extends State<CreateCategoryPage> {
  final TextEditingController categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f7fb),

      appBar: AppBar(
      backgroundColor: const Color(0xFF1F3C88),
      iconTheme: const IconThemeData(color: Colors.white),

  
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
            Navigator.pop(context);
       },
       ),

      title: const Text(
       "Other Category",
       style: TextStyle(color: Colors.white),
      ),
      centerTitle: true,
  ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Category Name",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87
              ),
            ),

            SizedBox(height: 10),

            TextField(
              controller: categoryController,
              decoration: InputDecoration(
                hintText: "Type category here...",
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xff1c3faa), width: 2),
                ),
              ),
            ),

          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: EdgeInsets.all(20),
        child: ElevatedButton(
          onPressed: () {
            
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF254EBA),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.symmetric(vertical: 14),
          ),
          child: Text(
            "Save",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16
            ),
          ),
        ),
      ),
    );
  }
}