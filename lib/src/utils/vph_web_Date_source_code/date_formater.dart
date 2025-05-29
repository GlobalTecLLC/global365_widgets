import 'dart:math';

import 'package:flutter/services.dart';

class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {


    var text = "";
    if (newValue.text.length < oldValue.text.length) {
      text = newValue.text;
    } else {
      String filterText = newValue.text.replaceAll(RegExp(r'[^0-9/]'), '');
      text = _format(filterText, '/');
    }
    
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String seperator) {
    value = value.replaceAll(seperator, '');
    var newString = '';

    for (int i = 0; i < min(value.length, _maxChars); i++) {
      newString += value[i];
      if ((i == 1 || i == 3)) {
        newString += seperator;
      }
    }
    if (newString.length == 10) {
      List date = newString.split('/');
      int month = int.parse(date[0]);
      int day = int.parse(date[1]);
      int year = int.parse(date[2]);
      int newDay = day;
      if (year % 4 != 0) {
        if (month == 2) {
          if (day >= 29) {
            newDay = 28;
          }
        }
      }
      newString = '${month < 10 ? "0$month" : month.toString()}/${newDay < 10 ? "0$newDay" : newDay.toString()}/$year';
    } else if (newString.length >= 6) {
      List date = newString.split('/');
      int month = int.parse(date[0]);
      int day = int.parse(date[1]);

      int newDay = day;
      int newMonth = month;
      if (month > 12) {
        newMonth = 12;
      }

      //Add validation of 30 days and 31 days months
      if (month == 4 || month == 6 || month == 9 || month == 11) {
        if (day > 30) {
          newDay = 30;
        }
      } else if (month == 2) {
        if (day > 29) {
          newDay = 29;
        }
      } else if (day > 31) {
        newDay = 31;
      }

      newString = '${newMonth < 10 ? "0$newMonth" : newMonth.toString()}/${newDay < 10 ? "0$newDay" : newDay.toString()}${date.length > 2 ? "/${date[2]}" : ''}';
    } else if (newString.length == 3) {
      int month = int.parse(newString.replaceAll(seperator, ""));
      if (month > 12) {
        newString = '12/';
      }
    }

    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}
