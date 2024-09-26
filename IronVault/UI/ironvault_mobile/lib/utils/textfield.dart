import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final GlobalKey<FormState> formkey;
  final TextEditingController controller;
  final String title;
  final String hint;
  final bool isNumber;
  final bool readOnly; // Add readOnly field

  const ReusableTextField({
    required this.formkey,
    required this.controller,
    required this.title,
    required this.hint,
    this.isNumber = false,
    this.readOnly = false, // Set default value for readOnly
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        readOnly: readOnly, // Apply the readOnly property here
        decoration: InputDecoration(
          labelText: title,
          hintText: hint,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
