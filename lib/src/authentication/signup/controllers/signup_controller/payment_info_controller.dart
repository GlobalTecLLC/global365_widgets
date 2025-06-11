
import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
}
