import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final bool isNumber;
  final TextEditingController controller;
  const MyTextFormField(
      {super.key,
      required this.labelText,
      required this.icon,
      required this.controller,
      this.isNumber = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        filled: true,
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 20),
        border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary)),
        prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
