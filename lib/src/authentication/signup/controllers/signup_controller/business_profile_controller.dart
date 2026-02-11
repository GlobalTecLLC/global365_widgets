import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/dropdowns/searchabledropdowncustom/dropdown_plus.dart';
import 'package:global365_widgets/src/utils/logger.dart';
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

  CustomPhoneNumberController phoneController = CustomPhoneNumberController();

  RxString orgIdFromRedirectLogin = "".obs;
  //Dropdowns initialization

  // DropdownEditingController<dynamic> locationDropdown = DropdownEditingController();
  DropdownEditingController<dynamic> industryDropdown = DropdownEditingController();
  DropdownEditingController<dynamic> stateDropdown = DropdownEditingController();
  DropdownEditingController<dynamic> languageDropdown = DropdownEditingController();
  DropdownEditingController<dynamic> timezoneDropdown = DropdownEditingController();
  DropdownEditingController<dynamic> currencyDropdown = DropdownEditingController();

  final FocusNode businessNameFocusNode = FocusNode();
  final FocusNode industryDropdownFocusNode = FocusNode();
  final FocusNode addressLine1FocusNode = FocusNode();
  final FocusNode addressLine2FocusNode = FocusNode();
  final FocusNode cityFocusNode = FocusNode();
  final FocusNode stateDropdownFocusNode = FocusNode();
  final FocusNode zipFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode goBackButtonFocusNode = FocusNode();
  final FocusNode nextButtonFocusNode = FocusNode();

  @override
  void onClose() {
    businessNameFocusNode.dispose();
    industryDropdownFocusNode.dispose();
    addressLine1FocusNode.dispose();
    addressLine2FocusNode.dispose();
    cityFocusNode.dispose();
    stateDropdownFocusNode.dispose();
    zipFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    goBackButtonFocusNode.dispose();
    nextButtonFocusNode.dispose();
    super.onClose();
  }


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
      // industryList.assignAll(payLoad['payload']['industries'] ?? []);
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

  RxString addressValidationMsg = "".obs;
  Future<void> validateAddress(BuildContext context) async {
    GProgressDialog(context).show();
    Logger.log("validateAddress");
    dynamic data = {
      "addressLine1": tecaddressLine1.text.trim(),
      "addressLine2": null,
      "CountryId": 233,
      "StateId": stateDropdown.value['id'],
      "city": tecCity.text.trim(),
      "zip": tecZip.text.trim(),
    };
    ResponseModel response = await APIsCallPost.submitRequest("Companies/ValidateAddress", data);
    GProgressDialog(context).hide();
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(jsonDecode(response.data).toString());
      GNav.pushNav(context, GRouteConfig.softwareInfoScreenRoute);
    } else {
      dynamic decodedData = jsonDecode(response.data);
      String message = decodedData["message"].toString();

      // Remove "API Error: " prefix if it exists
      if (message.startsWith("API Error: ")) {
        message = message.replaceFirst("API Error: ", "");
      }
      addressValidationMsg.value = decodedData["message"].toString();
    }
  }
}
