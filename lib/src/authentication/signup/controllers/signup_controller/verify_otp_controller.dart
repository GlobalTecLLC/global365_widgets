import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'dart:convert';

import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/authentication/signup/controllers/signup_controller/sign_up_controller.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/utils/services/response_model/resonse_model.dart';

import 'package:global365_widgets/src/utils/api_client/api_client.dart';
import 'package:global365_widgets/src/utils/go_routes.dart';
import 'package:global365_widgets/src/utils/print_log.dart';
import 'package:global365_widgets/src/utils/progressDialog.dart';

class VerifyOtpController extends GetxController {
  static VerifyOtpController get to => Get.find();

  final formKey = GlobalKey<FormState>();

  var otp = List.filled(6, '').obs;
  var isButtonEnabled = false.obs;

  void updateOtp(int index, String value) {
    otp[index] = value;
    isButtonEnabled.value = otp.every((element) => element.isNotEmpty);
  }

  RxBool isLoading = false.obs;

  verifyOTP(context) async {
    gLogger("INSIDE VERIFY OTP API CALL");
    String otpString = otp.join();
    isLoading.value = true;
    ResponseModel response = await APIsCallPut.updateRequestWithIdwithoutbody(
      "Users/ConfirmVerificationCode?Email=${SignUpController.to.tecEmail.text.trim()}&VerificationCode=$otpString",
    );
    isLoading.value = false;
    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic decodedData = jsonDecode(response.data);
      String accessToken1 = decodedData["payload"]["token"];
      accessToken = accessToken1;
      gLogger("accessToken: $accessToken");
      if (g365Module == G365Module.merchant) {
        GNav.pushNav(context, GRouteConfig.setUpScreenRoute);
      } else {
        GNav.pushNav(context, GRouteConfig.paymentInfoRoute);
      }

      gLogger("API Response: ${response.data}");
    } else {
      GToast.error("Invalid OTP", context);
      gLogger("Error: ${response.data.toString()}");
    }
  }

  resendOTP(context) async {
    gLogger("INSIDE RESEND OTP API CALL");
    GProgressDialog(context).show();
    ResponseModel response = await APIsCallPost.submitRequestWithOutBody(
      "Users/ResendVerificationCode?Email=${SignUpController.to.tecEmail.text.trim()}",
    );
    GProgressDialog(context).hide();
    if (response.statusCode == 200 || response.statusCode == 201) {
      gLogger("API Response: ${response.data}");
    } else {
      GToast.error(response.data.toString(), context);
      gLogger("Error: ${response.data.toString()}");
    }
  }
}
