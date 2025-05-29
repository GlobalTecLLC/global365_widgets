import 'package:flutter/services.dart';

class DecimalTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Only allow digits and a single decimal point
    final newText = newValue.text;

    if (newText.isEmpty) return newValue;

    final regExp = RegExp(r'^\d*\.?\d*$');
    if (regExp.hasMatch(newText)) {
      // Return the new value if it matches the regex
      return newValue;
    }

    // Return old value if the new value doesn't match the regex
    return oldValue;
  }
}
