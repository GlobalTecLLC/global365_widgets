import 'package:intl/intl.dart';

class GAmountFunctions {
  static String currencyUnit = "\$";

  static String formateAmount(dynamic value, {bool addCurrency = false, bool? emptyIfZero, bool? isDashedText}) {
    double amount = 0.0;
    if (value.toString().contains("--")) {
      return value.toString();
    }
    try {
      String value1 = value.toString().replaceAll(",", "");
      amount = double.parse(value1.toString());
    } catch (e) {
      return value.toString();
    }
    if (amount == 0 && (emptyIfZero ?? false)) {
      return "";
    }

    if (amount < 0.0) {
      var newAmount = amount * -1;

      var formatter = NumberFormat('###,###,###,###,##0.00');

      String fromated = formatter.format(newAmount);
      // gLogger("fromated=======================$fromated");

      return "($currencyUnit$fromated)";
    } else {
      var formatter = NumberFormat('###,###,###,###,##0.00');

      return ((addCurrency ? currencyUnit : "") + formatter.format(amount));
    }
  }

  static String formateAmountFromString(String text, {bool keepMinus = false}) {
    double amount = double.parse(text == "" || text == "null" ? "0" : text);

    if (amount < 0) {
      double newAmount = amount * -1;
      var formatter = NumberFormat('###,###,###,###,##0.00');
      String fromated = formatter.format(newAmount);
      return keepMinus ? "-$fromated" : "($fromated)";
    } else {
      var formatter = NumberFormat('###,###,###,###,##0.00');
      return formatter.format(amount);
    }
  }

static String formateAmountFromStringWithCurrency(String text, {bool keepMinus = false}) {
    double amount = double.parse(text == "" || text == "null" ? "0" : text);

    if (amount < 0) {
      double newAmount = amount * -1;
      var formatter = NumberFormat('###,###,###,###,##0.00');
      String fromated = formatter.format(newAmount);
      return currencyUnit + ((keepMinus) ? "-$fromated" : "($fromated)");
    } else {
      var formatter = NumberFormat('###,###,###,###,##0.00');
      return (currencyUnit + formatter.format(amount));
    }
  }
}
