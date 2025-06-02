import 'package:flutter/services.dart';

class ThousandsSeparatorInputFormatterWithCurrency extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) && oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex = newValue.text.length - newValue.selection.extentOffset;

      // Split the value into parts before and after the dot
      List<String> parts = newValueText.split('.');
      String beforeDot = parts[0];
      String afterDot = parts.length > 1 ? '.' + parts.sublist(1).join('') : '';
      bool hasNegtive = false;
      if (beforeDot.startsWith('-')) {
        hasNegtive = true;
        beforeDot = beforeDot.substring(1);
      }
      // Add commas to the part before the dot
      final chars = beforeDot.split('');
      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
          newString = separator + newString;
        }
        newString = chars[i] + newString;
      }
      if (hasNegtive) {
        newString = '-' + newString;
      }

      // Combine the parts back together
      newString += afterDot;

      return TextEditingValue(
        text: newString.toString().isEmpty ? newString.toString() : ("\$" + newString.toString()),
        selection: TextSelection.collapsed(
          offset: newString.toString().isEmpty ? newString.length - selectionIndex : (newString.length + 1) - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
