import 'package:flutter/material.dart';

// Function to load a custom font
FontWeight loadCustomFontWeight() {
  // You can customize the font weight based on your requirements
  return FontWeight.w500;
}

TextStyle getEBookAppTextStyle(BuildContext context) {
  return TextStyle(
    fontFamily:
        'YourCustomFont', // Use the font family name without the file extension
    fontWeight: loadCustomFontWeight(),
    fontSize: Theme.of(context).textTheme.headlineLarge!.fontSize,
    color: Theme.of(context).colorScheme.background,
  );
}

// Usage in your Container's child Text widget

