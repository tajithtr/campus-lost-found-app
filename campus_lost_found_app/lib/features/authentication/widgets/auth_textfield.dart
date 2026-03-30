import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  final String hint;
  final bool isPassword;
  final TextEditingController? controller;
  final Widget? prefixIcon;

  const AuthTextField({
    super.key,
    required this.hint,
    this.isPassword = false,
    this.controller,
    this.prefixIcon,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _isObscure : false,

      decoration: InputDecoration(
        hintText: widget.hint,
        prefixIcon: widget.prefixIcon,

        // 👁 password toggle
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              )
            : null,

        filled: true,
        fillColor: Colors.grey[200],

        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
