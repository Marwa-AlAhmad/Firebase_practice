import 'package:flutter/material.dart';

class CostumTextForm extends StatelessWidget {
  final String hintText;
  final TextEditingController mycontroller;
  final String? Function(String?)? validator;

  const CostumTextForm({
    super.key,
    required this.hintText,
    required this.mycontroller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: mycontroller,
      validator: validator,
      decoration: InputDecoration(
        hintText: "Enter your Password",
        hintStyle: TextStyle(fontSize: 15, color: Colors.grey[600]),
        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
        filled: true,
        fillColor: Colors.grey[200],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: const Color.fromARGB(255, 253, 220, 220),
          ),
        ),
      ),
    );
  }
}
