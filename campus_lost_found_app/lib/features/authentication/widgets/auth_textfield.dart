import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final String hintText;
  final IconData? icon;
  final bool isPassword;
  final TextEditingController? controller;
  final double borderRadius;

  const AuthTextField({
    super.key,
    required this.hintText,
    this.icon,
    this.isPassword = false,
    this.controller,
    this.borderRadius = 30,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword; // Only obscure if password
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: Border.all(color: const Color(0xFFCBD5E1)),
        color: Colors.white,
      ),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          icon: widget.icon != null
              ? Icon(widget.icon, color: Colors.black)
              : null,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
          border: InputBorder.none,
          suffixIcon: widget.isPassword
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() => _obscureText = !_obscureText);
                  },
                )
              : null,
        ),
      ),
    );
  }
}
