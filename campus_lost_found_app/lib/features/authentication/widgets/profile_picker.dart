import 'package:flutter/material.dart';

class ProfilePicker extends StatelessWidget {
  const ProfilePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Colors.grey[300],
      child: const Icon(Icons.camera_alt),
    );
  }
}
