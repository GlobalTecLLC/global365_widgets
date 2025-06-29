import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/utils/api_services/response_model/resonse_model.dart';

import 'package:global365_widgets/src/utils/api_client/api_client.dart';
import 'package:global365_widgets/src/utils/print_log.dart';

class PaymentPlanController extends GetxController {
  var items = <Item>[].obs;
  //essential radios
  var addAdditionalEntities = true.obs;
  var onlineBillPay = true.obs;
  var contractorPayments = true.obs;
  var eFilings = true.obs;

  //professional radios
  var proAddAdditionalEntities = true.obs;
  var proOnlineBillPay = false.obs;
  var proContractorPayments = true.obs;
  var proEFilings = true.obs;

  //enterprise radios
  var enterAddAdditionalEntities = true.obs;
  var enterOnlineBillPay = false.obs;
  var enterContractorPayments = true.obs;
  var enterEFilings = true.obs;

  //corporate radios
  var corAddAdditionalEntities = true.obs;
  var corOnlineBillPay = false.obs;
  var corContractorPayments = true.obs;
  var corEFilings = true.obs;

  //selected plan variable
  RxString selectedPlan = "".obs;
  //List for expansion data
  RxList subscriptionPlansList = [].obs;
  Rx<dynamic> subscriptionPlansFirstList = Rx<dynamic>({});

  RxBool isPlansListLoading = false.obs;
  RxBool isYearlyplanActive = false.obs;
  RxDouble updatedCost = 0.0.obs;
  int selectedPlanId = -1;
  void getSubScriptionPlans(BuildContext context) async {
    // (Sp-1)GetSubScriptionPlansV2
    gLogger("INSIDE THE getSubScriptionPlans");
    isPlansListLoading.value = true;
    ResponseModel response = await APIsCallGet.getDataWithOutAuth("Companies/GetSubScriptionPlansV2");
    gLogger("getSubScriptionPlans" + response.data.toString());
    gLogger(response.statusCode);
    isPlansListLoading.value = false;

    dynamic decodedData = jsonDecode(response.data);
    if (response.statusCode == 200) {
      // GToast.succss(decodedData["message"].toString(), context);
      subscriptionPlansList.value = decodedData["payload"] ?? [];
      subscriptionPlansFirstList.value = decodedData["payload"][0] ?? {};
      updatedCostMonthLyYearly();
    } else {
      gLogger("Error in getting data");
      GToast.error(decodedData["message"].toString(), context);
    }
  }

  void updatedCostMonthLyYearly() {
    if (isYearlyplanActive.isFalse) {
      double addOnsCost = 0.0;
      for (int i = 0; i < (subscriptionPlansFirstList.value["addOns"] ?? []).length; i++) {
        addOnsCost += subscriptionPlansFirstList.value["addOns"][i]["monthlyPrice"] ?? 0.0;
      }
      updatedCost.value = addOnsCost + (subscriptionPlansFirstList.value["monthlyDisplayPrice"] ?? 0.0);
    } else {
      double addOnsCost = 0.0;
      for (int i = 0; i < subscriptionPlansFirstList.value["addOns"].length; i++) {
        addOnsCost += subscriptionPlansFirstList.value["addOns"][i]["yearlyPrice"] ?? 0.0;
      }
      updatedCost.value = addOnsCost + (subscriptionPlansFirstList.value["yearlyDisplayPrice"] ?? 0.0);
    }
  }

  final List<Map<String, dynamic>> essential = [
    {
      "title": "Financial Management",
      "items": ["Manage Income & Expenses", "Write & Print Checks", "Record Credit Card Transactions", "Reconciliation", "Import Transactions", "Export Transactions"],
      "isExpanded": true,
    },
    {
      "title": "Vendor Management",
      "items": ["Enter & Pay Bills", "Receipt Management"],
      "isExpanded": false,
    },
  ];

  final List<Map<String, dynamic>> professional = [
    {
      "title": "Financial Management",
      "items": ["Manage Income & Expenses", "Write & Print Checks", "Record Credit Card Transactions", "Reconciliation", "Import Transactions", "Export Transactions"],
      "isExpanded": true,
    },
    {
      "title": "Vendor Management",
      "items": ["Enter & Pay Bills", "Receipt Management"],
      "isExpanded": false,
    },
  ];

  final List<Map<String, dynamic>> enterprise = [
    {
      "title": "Financial Management",
      "items": ["Manage Income & Expenses", "Write & Print Checks", "Record Credit Card Transactions", "Reconciliation", "Import Transactions", "Export Transactions"],
      "isExpanded": true,
    },
    {
      "title": "Vendor Management",
      "items": ["Enter & Pay Bills", "Receipt Management"],
      "isExpanded": true,
    },
  ];

  final List<Map<String, dynamic>> corporate = [
    {
      "title": "Financial Management",
      "items": ["Manage Income & Expenses", "Write & Print Checks", "Record Credit Card Transactions", "Reconciliation", "Import Transactions", "Export Transactions"],
      "isExpanded": true,
    },
    {
      "title": "Vendor Management",
      "items": ["Enter & Pay Bills", "Receipt Management"],
      "isExpanded": false,
    },
  ];

  @override
  void onInit() {
    super.onInit();
    items.addAll([
      Item(
        headerValue: 'Financial Management',
        expandedValue: [
          'Manage Income & Expenses',
          'Write & Print Checks',
          'Record Credit Card Transactions',
          'Reconciliation',
          'Import Transactions',
          'Export Transactions',
        ],
      ),
      Item(headerValue: 'Vendor Management', expandedValue: ['Enter & Pay Bills', 'Receipt Management']),
    ]);
  }

  void toggleExpanded(int index) {
    items[index].isExpanded = !items[index].isExpanded;
    items.refresh();
  }
}

class Item {
  Item({required this.headerValue, required this.expandedValue, this.isExpanded = false});

  String headerValue;
  List<String> expandedValue;
  bool isExpanded;
}
