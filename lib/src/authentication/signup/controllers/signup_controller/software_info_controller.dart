import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/authentication/login/Controllers/login_controller.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/payment_plan_controller.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/business_profile_controller.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/setup_screen_controller.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/utils/api_services/response_model/resonse_model.dart';

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

    gLogger("This is Data");
    dynamic data = {
      "companyName": SetUpController.to.businessName.text.trim(),
      "locationId": g365Module == G365Module.merchant
          ? 233
          : SetUpController.to.locationDropdown.value.toString() == "null"
          ? 0
          : SetUpController.to.locationDropdown.value['id'],
      "industryId": BusinessProfileController.to.industryDropdown.value.toString() == "null"
          ? 0
          : BusinessProfileController.to.industryDropdown.value['id'],
      "stateId": g365Module == G365Module.merchant
          ? 4872
          : BusinessProfileController.to.stateDropdown.value.toString() == "null"
          ? 0
          : BusinessProfileController.to.stateDropdown.value['id'],
      "address": "",
      "currencyId": 1,
      // BusinessProfileController.to.currencyDropdown.value['id'],
      "languageId": 1,
      // BusinessProfileController.to.languageDropdown.value['id'],
      "timeZoneId": 1,
      // BusinessProfileController.to.timezoneDropdown.value['id'],
      "previouslyUsedSolutionId": g365Module == G365Module.merchant ? 1 : selectedSoftwareId.value,
      "packageId": 23,
      "addressLineOne": BusinessProfileController.to.tecaddressLine1.text.trim(),
      "addressLineTwo": BusinessProfileController.to.tecaddressLine2.text.trim(),
      "city": BusinessProfileController.to.tecCity.text.trim(),
      "zip": BusinessProfileController.to.tecZip.text.trim(),
      "phoneNo": SetUpController.to.phoneNumberWithoutFormate,
      "planTypeId": 1,
      "planId": PaymentPlanController.to.selectedPlanId, // This should be set based on the selected plan
    };
    // try {
    //   GProgressDialog(context).show();
    // } catch (e) {
    //   GToast.error("Toast Fail" + e.toString(), context);

    //   // TODO
    // }
    gLogger("Before Calling API$data");
    try {
      GProgressDialog(context).show();
      ResponseModel response = await APIsCallPost.submitRequest(
        (g365Module == G365Module.payroll) ? 'Companies/RegisterCompanyV2' : 'Companies/RegisterCompany',
        data,
      );
      GProgressDialog(context).hide();
      dynamic responseData = jsonDecode(response.data);
      gLogger("Company Res");
      gLogger(responseData);

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
          LoginController.to.loginResponsehandler(context, responseData);
          GNav.pushNavWithExtra(context, GRouteConfig.dashboard, {"isFromSignup": true});
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
    gLogger("INSIDE THE setupMerchantAccount Users/GetProfileLink?CompanyId=${companyId}");
    GProgressDialog(context).show();

    ResponseModel response = await APIsCallGet.getData("Users/GetProfileLink?CompanyId=${companyId}");
    gLogger("setupMerchantAccount Response: ${response.data.toString()}");
    dynamic templist = jsonDecode(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      gLogger("API Response: ${templist}");
      if (templist["payload"] != null) {
        String url = templist["payload"]["url"];
        // if (kIsWeb) {
        //   if (!await launchUrl(Uri.parse(url), mode: LaunchMode.inAppBrowserView, webOnlyWindowName: "_self")) {
        //     GProgressDialog(context).hide();
        //     throw Exception('Could not launch $url');
        //   }
        // } else {
         prefs.setString("onBoardingUrl", url);
        GNav.pushNavWithExtra(context, GRouteConfig.completemerchantprocess, {"url": url});
        // }
      } else {
        GToast.error("No payload found", context);
      }
    } else {
      GToast.error(templist["message"].toString(), context);
    }

    GProgressDialog(context).hide();
  }
}
