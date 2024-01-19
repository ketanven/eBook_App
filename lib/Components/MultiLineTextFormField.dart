import 'package:flutter/material.dart';

class MultiLineTextFormField extends StatelessWidget {
  final String labelText;

  final TextEditingController controller;
  const MultiLineTextFormField(
      {super.key, required this.labelText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: 5,
      controller: controller,
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        filled: true,
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 20),
        border: OutlineInputBorder(
            borderSide:
                BorderSide(color: Theme.of(context).colorScheme.primary)),
        // prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
