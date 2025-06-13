import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/business_profile_controller.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/setup_screen_controller.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/utils/Services/ResponseModel/resonse_model.dart';
import 'package:global365_widgets/src/utils/Services/get_request.dart';
import 'package:global365_widgets/src/utils/Services/post_requests.dart';
import 'package:global365_widgets/src/utils/api_client/api_client.dart';
import 'package:global365_widgets/src/utils/go_routes.dart';
import 'package:global365_widgets/src/utils/print_log.dart';
import 'package:global365_widgets/src/utils/progressDialog.dart';

import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class SoftwareInfoController extends GetxController {
  static SoftwareInfoController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    if (Get.isRegistered<SetUpController>()) {
      Get.find<SetUpController>();
    } else {
      Get.put(SetUpController());
    }
    if (Get.isRegistered<BusinessProfileController>()) {
      Get.find<BusinessProfileController>();
    } else {
      Get.put(BusinessProfileController());
    }
  }

  RxInt selectedSoftwareId = 0.obs;
  RxString selectedSoftware = ''.obs;

  void setSelectedSoftware(String software) {
    selectedSoftware.value = software;
    switch (software) {
      case 'QuickBooks':
        selectedSoftwareId.value = 1;
        break;
      case 'Xero':
        selectedSoftwareId.value = 2;
        break;
      case 'Sage':
        selectedSoftwareId.value = 3;
        break;
      case 'Zoho':
        selectedSoftwareId.value = 4;
        break;
      case 'Quicken':
        selectedSoftwareId.value = 5;
        break;
      case 'NetSuite':
        selectedSoftwareId.value = 6;
        break;
      case 'Excel':
        selectedSoftwareId.value = 7;
        break;
      case 'None':
        selectedSoftwareId.value = 8;
        break;
      default:
        selectedSoftwareId.value = 0;
    }
  }

  signUp(context) async {
    gLogger("Inside the Sign up api call");
    gLogger("Selected Software: ${selectedSoftware.value}");
    gLogger("company name: ${SetUpController.to.businessName.text.trim()}");
    gLogger("address: ${BusinessProfileController.to.tecaddressLine1.text.trim()}");
    // gLogger("location name and id: ${SetUpController.to.locationDropdown.value['id']}");
    // gLogger("industry name and id: ${BusinessProfileController.to.industryDropdown.value['name']} ${BusinessProfileController.to.industryDropdown.value['id']}");
    // gLogger("state name and id: ${BusinessProfileController.to.stateDropdown.value['name']} ${BusinessProfileController.to.stateDropdown.value['id']}");
    // gLogger("language name and id: ${BusinessProfileController.to.languageDropdown.value['name']} ${BusinessProfileController.to.languageDropdown.value['id']}");
    // gLogger("timezone name and id: ${BusinessProfileController.to.timezoneDropdown.value['name']} ${BusinessProfileController.to.timezoneDropdown.value['id']}");
    // gLogger("currency name and id: ${BusinessProfileController.to.currencyDropdown.value['name']} ${BusinessProfileController.to.currencyDropdown.value['id']}");
    gLogger("This is Data");
    dynamic data = {
      // "addressLineOne": BusinessProfileController.to.address.text.trim(),
      // "addressLineTwo": "",
      // "city": "",
      // "zip": "",
      // "countryId": SetUpController.to.locationDropdown.value['id'],
      "companyName": SetUpController.to.businessName.text.trim(),
      "locationId": SetUpController.to.locationDropdown.value.toString() == "null" ? 0 : SetUpController.to.locationDropdown.value['id'],
      "industryId": BusinessProfileController.to.industryDropdown.value.toString() == "null" ? 0 : BusinessProfileController.to.industryDropdown.value['id'],
      "stateId": BusinessProfileController.to.stateDropdown.value.toString() == "null" ? 0 : BusinessProfileController.to.stateDropdown.value['id'],
      "address": "",
      "currencyId": 1,
      // BusinessProfileController.to.currencyDropdown.value['id'],
      "languageId": 1,
      // BusinessProfileController.to.languageDropdown.value['id'],
      "timeZoneId": 1,
      // BusinessProfileController.to.timezoneDropdown.value['id'],
      "previouslyUsedSolutionId": selectedSoftwareId.value,
      "packageId": -1,
      "addressLineOne": BusinessProfileController.to.tecaddressLine1.text.trim(),
      "addressLineTwo": BusinessProfileController.to.tecaddressLine2.text.trim(),
      "city": BusinessProfileController.to.tecCity.text.trim(),
      "zip": BusinessProfileController.to.tecZip.text.trim(),
      "phoneNo": BusinessProfileController.to.phoneNumber.text.trim(),
    };
    // try {
    //   GProgressDialog(context).show();
    // } catch (e) {
    //   GToast.error("Toast Fail" + e.toString(), context);

    //   // TODO
    // }
    gLogger("Before Calling API");
    try {
      GProgressDialog(context).show();
      ResponseModel response = await APIsCallPost.submitRequest('Companies/RegisterCompany', data);
      GProgressDialog(context).hide();
      dynamic responseData = jsonDecode(response.data);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // AutoRouter.of(context).push(const FinalizeSignupRoute());
        if (g365Module == G365Module.merchant) {
          String? companyIDTemp;
          try {
            companyIDTemp = (responseData['payload']['loggedCompanies'][0]['companyId'] ?? 0).toString();
          } catch (e) {
            gLogger("Error getting company ID: $e");
          }
          if (companyIDTemp != null || companyIDTemp != "null") {
            companyId = companyIDTemp.toString();
          } else {
            GToast.error("Company ID not found in response", context);
            return;
          }
          setupMerchantAccount(context);
        } else {
          GToast.succss(responseData['message'] ?? "", context);

          GNav.pushNav(context, GRouteConfig.finalizeSignupRoute);
        }

        gLogger("Success: ${response.data.toString()}");
      } else {
        GToast.error(responseData['message'] ?? "", context);
        gLogger("Error: ${response.data.toString()}");
      }
    } catch (e) {
      GToast.error(e.toString(), context);
    }
  }

  setupMerchantAccount(BuildContext context, {String? companyIdTemp}) async {
    if (companyId == null || companyId.isEmpty) {
      companyId = companyIdTemp.toString();
    }
    gLogger("INSIDE THE setupMerchantAccount");
    GProgressDialog(context).show();

    ResponseModel response = await APIsCallGet.getData("Users/GetProfileLink?CompanyId=${companyId}");
    gLogger("setupMerchantAccount Response: ${response.data.toString()}");
    dynamic templist = jsonDecode(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      gLogger("API Response: ${templist}");
      if (templist["payload"] != null) {
        String url = templist["payload"]["url"];

        if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView, webOnlyWindowName: "_self")) {
          GProgressDialog(context).hide();
          throw Exception('Could not launch $url');
        }
      } else {
        GToast.error("No payload found", context);
      }
    } else {
      GToast.error(templist["message"].toString(), context);
    }

    GProgressDialog(context).hide();
  }
}
