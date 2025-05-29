import 'package:intl/intl.dart';

class GDateFunctions {
  //write double extension method
  static String fromateDateFromStringInPDF(String date) {
    try {
      DateTime billDate1 = DateTime.parse(date);
      String formatedDate = DateFormat('dd MMM yyyy').format(billDate1);
      return formatedDate;
    } catch (e) {
      return date;
    }
    // List listdate = date.split("T");
  }

  static String fromateDateFromString(String date) {
    try {
      DateTime billDate1 = DateTime.parse(date);
      String formatedDate = DateFormat('dd-MMM-yyyy').format(billDate1);
      return formatedDate;
    } catch (e) {
      return date;
    }
    // List listdate = date.split("T");
  }

  static String formateDateAsYearMonthDay(String value) {
    String formattedDate = "";
    try {
      formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.parse(value));
    } catch (e) {
      formattedDate = value;
    }
    return formattedDate;
  }

  static String formatDateForSnapshot(String inputDate) {
    String formattedDate = "";
    try {
      formattedDate = DateFormat('dd-MM-yy').format(DateTime.parse(inputDate));
    } catch (e) {
      formattedDate = inputDate;
    }
    return formattedDate;
  }

  static String convertToCamelCase(String input) {
    List<String> words = input.split(' ');
    String camelCase = words.first.toLowerCase();

    for (int i = 1; i < words.length; i++) {
      camelCase += words[i][0].toUpperCase() + words[i].substring(1).toLowerCase();
    }
    return camelCase;
  }
}
