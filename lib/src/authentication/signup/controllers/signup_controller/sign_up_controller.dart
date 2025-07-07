import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/utils/api_services/response_model/resonse_model.dart';
import 'package:global365_widgets/src/utils/api_services/post_requests.dart';
import 'package:global365_widgets/src/utils/api_client/api_client.dart';
import 'package:global365_widgets/src/utils/go_routes.dart';
import 'package:global365_widgets/src/utils/print_log.dart';
import 'package:global365_widgets/src/utils/toast/delightful_toast_class.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUpController extends GetxController {
  static SignUpController get to => Get.find();

  final formKey = GlobalKey<FormState>();
  TextEditingController controllerusernmae = TextEditingController();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();

  Future<void> launchURL(String url) async {
    if (await canLaunch(url)) {
      try {
        await launch(url);
        gLogger('sucess: $url');
      } catch (e) {
        gLogger('Error: $e');
      }
    } else {
      throw 'Could not launch $url';
    }
  }

  RxBool checkedValue = false.obs;
  RxBool betaTestingAgreement = false.obs;
  RxBool isEmailValid = false.obs;

  RxBool isLoading = false.obs;
  signUp(context) async {
    gLogger("INSIDE THE SIGN UP API CALL");
    dynamic data = {
      "firstName": firstName.text.trim(),
      "lastName": lastName.text.trim(),
      "email": tecEmail.text.trim(),
      "password": controllerpassword.text.trim(),
    };
    isLoading.value = true;
    gLogger("User Data: $data");

    ResponseModel response = await APIsCallPost.submitRequest("Users/Register", data);
    isLoading.value = false;
    if (response.statusCode == 200 || response.statusCode == 201) {
      GNav.pushNav(context, GRouteConfig.verifyOtpScreenRoute);
      gLogger("API Response: ${response.data}");
    } else {
      var responseData = json.decode(response.data);
      String errorMessage = responseData['message'] ?? 'An error occurred';
      GToast.error(errorMessage, context);
      gLogger("Error: ${response.data.toString()}");
    }
  }

  RxBool passwordVisible = true.obs;
  RxBool isPasswordValid = false.obs;
  RxInt passwordStrength = 0.obs;
  RxString passwordStrengthText = ''.obs;
  RxBool isShowValidation = false.obs;
  int validatePassword(String password) {
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
    return passwordStrength.value;
  }
}
