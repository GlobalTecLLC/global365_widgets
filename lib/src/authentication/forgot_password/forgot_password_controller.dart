import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/utils/print_log.dart';

class ForgetPasswodController extends GetxController {
  static ForgetPasswodController get to => Get.find();

  TextEditingController tecEmail = TextEditingController();
  TextEditingController tecPasswordController = TextEditingController();
  TextEditingController tecReenterPasswordController = TextEditingController();
  RxBool isButtonEnabled = false.obs;

  // 1 for email, 2 for otp, 3 for password field widget
  RxInt indexforShowingWidget = 1.obs;
  TextEditingController otpController = TextEditingController();

  FocusNode otpFocusNode = FocusNode();
  RxBool loogingIn = false.obs;
  RxBool passwordVisible = true.obs;
  RxBool reEnterpasswordVisible = true.obs;

  sendOTP(BuildContext context) async {
    gLogger("INSIDE RESEND OTP API CALL for get pasword");
    if (tecEmail.text.isEmpty) {
      GToast.error("Please enter Email", context);
    } else if (!isValidEmail(tecEmail.text.trim())) {
      GToast.error("Please enter valid Email", context);
    } else {
      GProgressDialog(context).show();
      // (SP-5) ForgotPassword
      ResponseModel response = await APIsCallPut.updateRequestWithIdwithoutbodyWithOutAuth(
        "Users/ForgotPassword?Email=${tecEmail.text.trim()}",
      );
      GProgressDialog(context).hide();

      gLogger("Response of sendOTP api is ${response.data} and code is ${response.statusCode}");
      dynamic decodedData = jsonDecode(response.data);
      if (response.statusCode == 200) {
        GToast.succss((decodedData["message"] ?? "").toString(), context);
        indexforShowingWidget.value = 2;
      } else {
        GToast.error((decodedData["message"] ?? "").toString(), context);
      }
    }
  }

  verifyOTP(BuildContext context) async {
    gLogger("INSIDE verifyOTPOTP OTP API CALL for get pasword and otp is ${otpController.text}");
    if (otpController.text.isEmpty) {
      GToast.error("Please enter OTP", context);
    } else if (otpController.text.toString().length < 6) {
      GToast.error("Please enter complete OTP", context);
    } else {
      GProgressDialog(context).show();
      // (Sp-1024) VerificationForgotPasswordCode
      ResponseModel response = await APIsCallPut.updateRequestWithIdwithoutbodyWithOutAuth(
        "Users/VerificationForgotPasswordCode?Email=${tecEmail.text.trim()}&VerificationCode=${otpController.text}",
      );
      GProgressDialog(context).hide();
      gLogger("Response of verifyOTP api is ${response.data} and code is ${response.statusCode}");
      dynamic decodedData = jsonDecode(response.data);
      if (response.statusCode == 200) {
        GToast.succss((decodedData["message"] ?? "").toString(), context);
        indexforShowingWidget.value = 3;
      } else {
        GToast.error((decodedData["message"] ?? "").toString(), context);
      }
    }
  }

  resetPassword(BuildContext context) async {
    gLogger(
      "INSIDE resetPassword CALL for get pasword and otp is ${otpController.text} and email is ${tecEmail.text} and password is ${tecPasswordController.text} and reenter password is ${tecReenterPasswordController.text}",
    );
    if (tecPasswordController.text.trim().toString() != tecReenterPasswordController.text.trim().toString()) {
      GToast.error("Please enter same Password in both fields", context);
    } else {
      GProgressDialog(context).show();

      //(SP-6) ResetPassword
      ResponseModel response = await APIsCallPut.updateRequestWithIdwithoutbodyWithOutAuth(
        "Users/ResetPassword?Email=${tecEmail.text.trim()}&VerificationCode=${otpController.text}&Password=${tecPasswordController.text.trim()}",
      );
      GProgressDialog(context).hide();

      gLogger("Response of resetPassword api is ${response.data} and code is ${response.statusCode}");
      dynamic decodedData = jsonDecode(response.data);
      if (response.statusCode == 200) {
        GToast.succss((decodedData["message"] ?? "").toString(), context);
        tecEmail.clear();
        otpController.clear();
        tecPasswordController.clear();
        tecReenterPasswordController.clear();
        indexforShowingWidget.value = 1;
        GNav.pushNav(context, GRouteConfig.loginUsaPageRoute);
      } else {
        GToast.error((decodedData["message"] ?? "").toString(), context);
      }
    }
  }

  RxBool isPasswordValid = false.obs;
  RxInt passwordStrength = 0.obs;
  RxString passwordStrengthText = ''.obs;
  RxBool isShowValidation = false.obs;
  void validatePassword(String password) {
    final RegExp strongPasswordRegExp = RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*[!@#$%^&*(),.?":{}|<>])(?=.*[0-9]).{8,}$');
    if (strongPasswordRegExp.hasMatch(password) && password.length >= 12) {
      passwordStrength.value = 3;
      passwordStrengthText.value = 'Very Strong';
    } else if (strongPasswordRegExp.hasMatch(password)) {
      passwordStrength.value = 2;
      passwordStrengthText.value = 'Medium';
    } else {
      passwordStrength.value = 1;
      passwordStrengthText.value = 'Weak';
    }

    isPasswordValid.value = passwordStrength.value >= 2;
  }

  functionToClearData() {
    tecEmail.clear();
    tecPasswordController.clear();
    tecReenterPasswordController.clear();

    // 1 for email, 2 for otp, 3 for password field widget
    isButtonEnabled.value = false;
    indexforShowingWidget.value = 1;
    otpController.clear();
    loogingIn.value = false;
    passwordVisible.value = true;
    reEnterpasswordVisible.value = true;
    isPasswordValid.value = false;
    passwordStrength.value = 0;
    passwordStrengthText.value = '';
    isShowValidation.value = false;
  }
}
