import 'package:flutter/material.dart';

// Common TextField Widget
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final VoidCallback? togglePasswordVisibility;
  final bool isPasswordHidden;

  const CustomTextField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.validator,
    this.togglePasswordVisibility,
    this.isPasswordHidden = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(

      controller: controller,
      obscureText: isPassword ? isPasswordHidden : false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.2)),
        filled: true,

        border: OutlineInputBorder(

          borderRadius: BorderRadius.circular(12),
        ),
        prefixIcon: Icon(prefixIcon, color: Colors.blueAccent),
        suffixIcon: isPassword
            ? IconButton(
          icon: Icon(
            isPasswordHidden ? Icons.visibility : Icons.visibility_off,
            color: Colors.blueAccent,
          ),
          onPressed: togglePasswordVisibility,
        )
            : null,
      ),
      validator: validator,
    );
  }
}
