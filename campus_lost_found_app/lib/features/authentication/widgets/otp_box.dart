import 'package:flutter/material.dart';

class OTPBox extends StatelessWidget {
  const OTPBox({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: TextField(
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: "",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
