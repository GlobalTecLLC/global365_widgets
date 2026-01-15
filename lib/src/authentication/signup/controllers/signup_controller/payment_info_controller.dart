import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/utils/logger.dart';
import 'package:intl/intl.dart';

class PaymentInfoController extends GetxController {
  static PaymentInfoController get to => Get.find();

  final formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController cvv = TextEditingController();
  Rx<DateTime> selectedDateFrom = DateTime.now().obs;
  TextEditingController tecDateFrom = TextEditingController(text: DateFormat('MM/dd/yyyy').format(DateTime.now()));

  /// updated payment info controllers
  TextEditingController cardCardNumber = TextEditingController();
  TextEditingController cardExpiry = TextEditingController();
  TextEditingController cardCCV = TextEditingController();

  /// Validation Methods
  bool _isValidCardNumber(String cardNumber) {
    // Remove dashes and check if it's 16 digits in format ####-####-####-####
    String cleanedNumber = cardNumber.replaceAll('-', '');
    if (cleanedNumber.length != 16 || !RegExp(r'^\d+$').hasMatch(cleanedNumber)) {
      return false;
    }
    // Check if original format has dashes in correct positions
    if (!RegExp(r'^\d{4}-\d{4}-\d{4}-\d{4}$').hasMatch(cardNumber)) {
      return false;
    }
    return true;
  }

  bool _isValidExpiry(String expiry) {
    // Format: MM/YY (e.g., 12/64)
    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(expiry)) {
      return false;
    }
    List<String> parts = expiry.split('/');
    int month = int.parse(parts[0]);
    if (month < 1 || month > 12) {
      return false;
    }
    return true;
  }

  bool _isValidCVV(String cvv) {
    // CVV should be 3 digits
    return RegExp(r'^\d{3}$').hasMatch(cvv);
  }

  Future<void> submitPaymentInfo(BuildContext context) async {
    Logger.log("Submit payment info called");
    Logger.log("Card Number: ${cardCardNumber.text}");
    Logger.log("Card Expiry: ${cardExpiry.text}");
    Logger.log("Card CVV: ${cardCCV.text}");
    // Validate card number
    if (!_isValidCardNumber(cardCardNumber.text.trim())) {
      GToast.info(context, "Please enter valid card number (format: ####-####-####-####)");
      return;
    }

    // Validate expiry
    if (!_isValidExpiry(cardExpiry.text.trim())) {
      GToast.info(context, "Please enter valid expiry date (format: MM/YY)");
      return;
    }

    // Validate CVV
    if (!_isValidCVV(cardCCV.text.trim())) {
      GToast.info(context, "Please enter valid CVV (3 digits)");
      return;
    }

    GProgressDialog(context).show();

    // Transform card number: remove dashes (5363-4231-3465-4756 -> 5363423134654756)
    String cleanedCardNumber = cardCardNumber.text.trim().replaceAll('-', '');

    // Transform expiry: MM/YY to MMYY (12/64 -> 1264)
    String formattedExpiry = cardExpiry.text.trim().replaceAll('/', '');

    dynamic data = {"cardNumber": cleanedCardNumber, "expirationDate": formattedExpiry, "cvv": cardCCV.text.trim()};
    ResponseModel resp = await APIsCallPost.submitRequest("Users/ValidateAndCreateCustomerV2", data);
    GProgressDialog(context).hide();
    dynamic responseBody = jsonDecode(resp.data);
    Logger.log("Response Body: $responseBody");
    if (resp.statusCode == 200) {
      GToast.succss("Payment Information added successfully", context);
      GNav.goNav(context, GRouteConfig.setUpScreenRoute);
    } else {
      String errorMsg = responseBody['msg'] ?? "Failed to add payment information";
      // Extract message after colon if present
      if (errorMsg.contains(':')) {
        errorMsg = errorMsg.split(':').last.trim();
      }
      GToast.error(errorMsg, context);
    }
  }
}
