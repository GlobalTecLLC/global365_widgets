import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final String newText = newValue.text;

    // Remove all non-numeric characters
    final String digitsOnly = newText.replaceAll(RegExp(r'\D'), '');

    // Initialize an empty formattedText
    String formattedText = '';

    if (digitsOnly.length >= 1) {
      // Make sure to check if the string has enough length before substring
      formattedText += '(' + digitsOnly.substring(0, digitsOnly.length.clamp(0, 3));
    }
    if (digitsOnly.length >= 4) {
      formattedText += ')' + digitsOnly.substring(3, digitsOnly.length.clamp(3, 6));
    }
    if (digitsOnly.length >= 7) {
      formattedText += '-' + digitsOnly.substring(6, digitsOnly.length.clamp(6, 10));
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
