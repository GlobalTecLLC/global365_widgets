
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BillPaymentController extends GetxController {
  static BillPaymentController get to => Get.find();
  var radioGroupValueForCards = 1.obs;
  TextEditingController name = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController cvv = TextEditingController();
  Rx<DateTime> selectedDateFrom = DateTime.now().obs;
  TextEditingController tecDateFrom = TextEditingController(text: DateFormat('MM/dd/yyyy').format(DateTime.now()));
}
