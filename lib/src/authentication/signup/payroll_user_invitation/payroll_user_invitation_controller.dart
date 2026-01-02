import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/authentication/login/Controllers/login_controller.dart';
import 'package:global365_widgets/src/utils/print_log.dart';
import 'package:go_router/go_router.dart';

class PayrollUserInvitationController extends GetxController {
  static PayrollUserInvitationController get to => Get.find();

  RxInt pageNumber = 0.obs;
  RxBool isgettingData = false.obs;
  RxString companyName = "".obs;
  RxString inviterUserName = "".obs;
  RxString inviterUserEmail = "".obs;
  RxString invitedUserEmail = "".obs;
  RxString firstNameFromAPI = "".obs;
  RxBool isUserVerified = false.obs;
  RxnBool isUserVerifiedNull = RxnBool(false);

  String statusCode = "";
  RxString verificationCode = "".obs;
  void getInvitedUserData(BuildContext context, {String? verficationCode}) async {
    isgettingData.value = true;
    verificationCode.value = verficationCode ?? "";
    // (SP-1008)GetUserInfoThroughCode
    gLogger("INSIDE THE GET INVITED USER DATA API CALL and verification code is $verficationCode");
    ResponseModel response = await APIsCallGet.getDataWithOutAuth(
      "Users/GetVerifiedUserInfoThroughCode?VerifiedCode=$verficationCode",
    );

    isgettingData.value = false;
    dynamic decodedData = jsonDecode(response.data);
    statusCode = response.statusCode.toString();
    gLogger("REsponseData = ${response.data}");
    if (response.statusCode == 200) {
      companyName.value = ((decodedData["payload"] ?? {})["companyName"] ?? "");
      inviterUserName.value = ((decodedData["payload"] ?? {})["inviterName"] ?? "");
      inviterUserEmail.value = ((decodedData["payload"] ?? {})["inviterEmail"] ?? "");
      invitedUserEmail.value = ((decodedData["payload"] ?? {})["email"] ?? "");
      firstNameFromAPI.value = ((decodedData["payload"] ?? {})["name"] ?? "");
      isUserVerified.value = ((decodedData["payload"] ?? {})["isVerified"] ?? false);
    } else {
      GToast.error(decodedData["message"].toString(), context);
    }
  }

  TextEditingController tecFirstName = TextEditingController();
  TextEditingController tecLastname = TextEditingController();
  TextEditingController tecPassword = TextEditingController();
  RxString firstName = "".obs;
  // RxString lastName = "".obs;
  RxString password = "".obs;
  RxBool passwordVisible = false.obs;
  RxBool isAgreedToTerms = false.obs;
  RxBool isAgreedToBetaTesting = false.obs;
  RxBool isFilledAllData = false.obs;

  signUp(BuildContext context) async {
    gLogger("INSIDE THE SIGN UP API CALL");
    dynamic data = {
      "firstName": tecFirstName.text.trim(),
      "lastName": tecLastname.text.trim(),
      "email": invitedUserEmail.value,
      "password": tecPassword.text.trim(),
      "fullName": "${tecFirstName.text.trim()} ${tecLastname.text.trim()}",
    };
    gLogger("User Data: $data");
    GProgressDialog(context).show();
    // (SP-1) User Register
    ResponseModel response = await APIsCallPost.submitRequestWithOutAuth("Users/Register", data);
    gLogger("response: ${response.data}");
    gLogger("response: ${response.statusCode}");

    GProgressDialog(context).hide();
    dynamic decodedData = jsonDecode(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      GToast.succss(decodedData["message"], context);
      pageNumber.value = 2;
      otpController.clear();
      // otp.value = List.filled(6, '');
      gLogger("API Response: ${response.data}");
    } else {
      GToast.error(decodedData["message"], context);
    }
  }

  functionTOClearDataofSignUp() {
    tecFirstName.clear();
    tecLastname.clear();
    tecPassword.clear();
    passwordVisible.value = false;
    isAgreedToTerms.value = false;
    isFilledAllData.value = false;
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

  TextEditingController otpController = TextEditingController();
  FocusNode otpFocusNode = FocusNode();
  // var otp = List.filled(6, '').obs;
  var isButtonEnabled = false.obs;

  // void updateOtp(int index, String value) {
  //   otp[index] = value;
  //   isButtonEnabled.value = otp.every((element) => element.isNotEmpty);
  // }

  bool isAccepted = false;
  verifiedUserInvitationResponse(BuildContext context, bool isAcceptedInvite) async {
    gLogger("INSIDE verifiedUserInvitationResponse and isaccepted: $isAcceptedInvite");
    GProgressDialog(context).show();
    // (SP-1009) VerifiedUserInvitationResponse
    ResponseModel response = await APIsCallPut.updateRequestWithIdwithoutbody(
      "Users/InvitationResponseVerfiiedUser?IsAccepted=$isAcceptedInvite&VerifiedCode=",
    );
    gLogger("data: ${response.data}");
    gLogger("status code ${response.statusCode}");
    GProgressDialog(context).hide();
    dynamic decodedData = jsonDecode(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      GToast.succss(decodedData["message"], context);
    } else {
      GToast.error(decodedData["message"], context);
      gLogger("Error: ${response.data.toString()}");
    }
  }

  // acceptAndRejectAfterSignIn(BuildContext context, bool isAcceptedInvite) async {
  //   gLogger("INSIDE verifiedUserInvitationResponse and isaccepted: $isAcceptedInvite");
  //   GProgressDialog(context).show();
  //   // (SP-1009) VerifiedUserInvitationResponse
  //   ResponseModel response = await APIsCallPut.updateRequestWithIdwithoutbody(
  //     "Users/InvitationResponseVerfiiedUser?IsAccepted=$isAcceptedInvite&VerifiedCode=",
  //   );
  //   gLogger("data: ${response.data}");
  //   gLogger("status code ${response.statusCode}");
  //   GProgressDialog(context).hide();
  //   dynamic decodedData = jsonDecode(response.data);

  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     GToast.succss(decodedData["message"], context);

  //     dynamic loggedCompanies = (decodedData["payload"] ?? {});

  //     userNameForGlobals.value = prefs.getString('userName').toString();
  //     companyNameForGlobals.value = loggedCompanies["companyName"] ?? "";

  //     final jsonString = loggedCompanies["companywisePermissions"];
  //     prefs.setString("permissions", jsonEncode(jsonString));

  //     // prefs.setString("listOfWidgets", jsonEncode(DashboardController.to.listOfWidgets.value));
  //     // if (isAcceptedInvite) {
  //     //   globals.isLoggingInInvitedUser.value = false;

  //     //   context.push(RouteConfig.dashboard);
  //     // } else {
  //     //   globals.isLoggingInInvitedUser.value = false;
  //     //   alertForRejection(context);
  //     // }
  //     isAccepted = false;
  //   } else {
  //     GToast.error(decodedData["message"], context);
  //     gLogger("Error: ${response.data.toString()}");
  //   }
  // }

  // verifiedClientInvitationResponse(BuildContext context, bool isAcceptedInvite) async {
  //   gLogger("INSIDE verifiedUserInvitationResponse and isaccepted: $isAcceptedInvite");
  //   GProgressDialog(context).show();
  //   // (CPA-IC-1003) InvitationResponseVerfiiedUserV2
  //   ResponseModel response = await APIsCallPut.updateRequestWithIdwithoutbody(
  //     "Users/InvitationResponseVerfiiedUserV2?IsAccepted=$isAcceptedInvite&VerifiedCode=",
  //   );
  //   gLogger("data: ${response.data}");
  //   GProgressDialog(context).hide();
  //   dynamic decodedData = jsonDecode(response.data);
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     GToast.succss(decodedData["message"], context);
  //     // if (isAcceptedInvite) {
  //     //   globals.isLoggingInInvitedUser.value = false;
  //     // } else {
  //     //   globals.isLoggingInInvitedUser.value = false;
  //     //   alertForRejection(context);
  //     // }
  //   } else {
  //     GToast.error(decodedData["message"], context);
  //     gLogger("Error: ${response.data.toString()}");
  //   }
  // }

  // rejectUnVerifiedUser(BuildContext context) async {
  //   gLogger("INSIDE rejectUnVerifiedUser");
  //   GProgressDialog(context).show();
  //   // (SP-1010)RejectedUnVerfiiedUser
  //   ResponseModel response = await APIsCallPut.updateRequestWithIdwithoutbodyWithOutAuth(
  //     "Users/RejectedUnVerfiiedUser?VerifiedCode=",
  //   );
  //   GProgressDialog(context).hide();
  //   dynamic decodedData = jsonDecode(response.data);
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     GToast.succss(decodedData["message"], context);
  //     // alertForRejection(context);
  //   } else {
  //     GToast.error(decodedData["message"], context);
  //     gLogger("Error: ${response.data.toString()}");
  //   }
  // }

  // rejectUnVerifiedClient(BuildContext context) async {
  //   gLogger("INSIDE rejectUnVerifiedUser");
  //   GProgressDialog(context).show();
  //   //  (CPA-IC-1004) RejectedUnVerfiiedUserV2
  //   ResponseModel response = await APIsCallPut.updateRequestWithIdwithoutbodyWithOutAuth(
  //     "Users/RejectedUnVerfiiedUserV2?VerifiedCode=",
  //   );
  //   GProgressDialog(context).hide();
  //   dynamic decodedData = jsonDecode(response.data);
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     GToast.succss(decodedData["message"], context);
  //     // alertForRejection(context);
  //   } else {
  //     GToast.error(decodedData["message"], context);
  //     gLogger("Error: ${response.data.toString()}");
  //   }
  // }

  verifyOTP(BuildContext context) async {
    gLogger("INSIDE VERIFY OTP API CALL and otp is ${otpController.text}");

    ResponseModel response = await APIsCallPut.updateRequestWithIdwithoutbody(
      "Users/InvitationResponseVerfiiedUser?IsAccepted=true&VerifiedCode=${verificationCode.value.trim()}",
    );

    dynamic decodedData = jsonDecode(response.data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      GToast.succss((decodedData["message"] ?? "").toString(), context);

      GNav.goNav(context, GRouteConfig.loginUsaPageRoute);
      gLogger("API Response: ${response.data}");
    } else {
      GToast.error((decodedData["message"] ?? "").toString(), context);
      gLogger("Error: ${response.data.toString()}");
    }
  }

  confirmVerificationCode(context) async {
    gLogger("INSIDE VERIFY OTP API CALL");
    GProgressDialog(context).show();
    ResponseModel response = await APIsCallPut.updateRequestWithIdwithoutbody(
      "Users/ConfirmVerificationCode?Email=${invitedUserEmail.value.trim()}&VerificationCode=${otpController.text.trim()}",
    );
    GProgressDialog(context).hide();

    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic decodedData = jsonDecode(response.data);
      String accessToken1 = decodedData["payload"]["token"];
      accessToken = accessToken1;
      gLogger("accessToken: $accessToken");
      verifyOTP(context);
      gLogger("API Response: ${response.data}");
    } else {
      GToast.error("Invalid OTP", context);
      gLogger("Error: ${response.data.toString()}");
    }
  }

  resendOTP(BuildContext context) async {
    gLogger("INSIDE RESEND OTP API CALL");
    GProgressDialog(context).show();
    // (SP-2) ResendVerificationCode
    ResponseModel response = await APIsCallPost.submitRequestWithOutBodyWithOutAuth(
      "Users/ResendVerificationCode?Email=${invitedUserEmail.value.trim()}",
    );
    GProgressDialog(context).hide();
    dynamic decodedResponse = jsonDecode(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      GToast.succss((decodedResponse["message"] ?? "").toString(), context);
      gLogger("API Response: ${response.data}");
    } else {
      GToast.error((decodedResponse["message"] ?? "").toString(), context);
      gLogger("Error: ${response.data.toString()}");
    }
  }
}
