import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/dropdowns/searchabledropdowncustom/dropdown_plus.dart';
import 'package:global365_widgets/src/utils/api_services/response_model/resonse_model.dart';


import 'package:global365_widgets/src/utils/print_log.dart';

class BusinessProfileController extends GetxController {
  static BusinessProfileController get to => Get.find();

  final formKey = GlobalKey<FormState>();
  TextEditingController currencyName = TextEditingController();
  TextEditingController businessName = TextEditingController();
  TextEditingController tecaddressLine1 = TextEditingController();
  TextEditingController tecaddressLine2 = TextEditingController();
  TextEditingController tecCity = TextEditingController();
  TextEditingController tecZip = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  //Dropdowns initialization

  // DropdownEditingController<dynamic> locationDropdown = DropdownEditingController();
  DropdownEditingController<dynamic> industryDropdown = DropdownEditingController();
  DropdownEditingController<dynamic> stateDropdown = DropdownEditingController();
  DropdownEditingController<dynamic> languageDropdown = DropdownEditingController();
  DropdownEditingController<dynamic> timezoneDropdown = DropdownEditingController();

  DropdownEditingController<dynamic> currencyDropdown = DropdownEditingController();

  RxList industryList = [].obs;
  RxList currenciesList = [].obs;
  RxList languagesList = [].obs;
  RxList timezoneList = [].obs;
  RxList statesList = [].obs;
  RxInt selectedLocationId = 0.obs;
  void getDropDownsData(context) async {
      ResponseModel response = await APIsCallGet.getData('Companies/GetConfigs?Type=sc');
    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic payLoad = jsonDecode(response.data);
      gLogger("data: $payLoad");
      currenciesList.assignAll(payLoad['payload']['currencies'] ?? []);
      industryList.assignAll(payLoad['payload']['industries'] ?? []);
      languagesList.assignAll(payLoad['payload']['languages'] ?? []);
      timezoneList.assignAll(payLoad['payload']['timezones'] ?? []);
    } else {
      GToast.error(response.data.toString(), context);
      gLogger("Error: ${response.data.toString()}");
    }
  }

  void getStatesData(context) async {
       ResponseModel response = await APIsCallGet.getData('Companies/GetStatesByLocationId?locationId=${selectedLocationId.value}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic payLoad = jsonDecode(response.data);
      gLogger("data: $payLoad");

      statesList.assignAll(payLoad['payload'] ?? []);
    } else {
      GToast.error(response.data.toString(), context);
      gLogger("Error: ${response.data.toString()}");
    }
  }

  RxList locationsList = [].obs;
  void getLocationsDropDown(context) async {
  ResponseModel response = await APIsCallGet.getData('Companies/GetLocations');
    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic payLoad = jsonDecode(response.data);
      gLogger("data: $payLoad");
      locationsList.assignAll(payLoad['payload'] ?? []);
    } else {
      GToast.error(response.data.toString(), context);
      gLogger("Error: ${response.data.toString()}");
    }
  }
}
