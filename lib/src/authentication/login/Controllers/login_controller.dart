import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/authentication/authentication_routes.dart';
import 'package:global365_widgets/src/utils/print_log.dart';
// import 'package:local_auth/local_auth.dart';

import 'package:url_launcher/url_launcher.dart';

class LoginController extends GetxController {
  static LoginController get to => Get.find();
  RxBool isSwitched = false.obs;
  RxString inviteCode = "".obs;

  String orgId = "0";

  RxBool checkedValueEmailLogin = true.obs;
  // final formKey = GlobalKey<FormState>();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController controllerusernmae = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();

  RxBool passwordVisible = true.obs;

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode rememberMeFocusNode = FocusNode();
  FocusNode forgotPasswordFocusNode = FocusNode();
  FocusNode loginButtonFocusNode = FocusNode();
  FocusNode signUpFocusNode = FocusNode();

  @override
  void onClose() {
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    rememberMeFocusNode.dispose();
    forgotPasswordFocusNode.dispose();
    loginButtonFocusNode.dispose();
    signUpFocusNode.dispose();
    super.onClose();
  }

  RxString phoneNumber = "".obs;

  String usernmae = "";
  String password = "";
  // LocalAuthentication auth = LocalAuthentication();
  RxString authorized = "Not authorized".obs;

  checkIsRememberUser() {
    if (prefs.getBool('remeberMe') != null) {
      bool flag = prefs.getBool('remeberMe')!;

      if (flag) {
        checkedValue.value = true;

        controllerpassword.text = prefs.getString('passwordforremeberMe').toString();

        tecEmail.text = prefs.getString('usernameforRemeberMe').toString();
      }
    }
  }

  login(context) async {
    gLogger("Login function called");
    if (tecEmail.text.isEmpty) {
      GToast.warning("Please enter email", context);
      return;
    } else if (controllerpassword.text.isEmpty) {
      GToast.warning("Please enter password", context);
      return;
    }

    if (checkedValue.value) {
      prefs.setBool('remeberMe', true);
      prefs.setString('usernameforRemeberMe', tecEmail.text);
      prefs.setString('passwordforremeberMe', controllerpassword.text);
    } else {
      prefs.setBool('remeberMe', false);
    }

    loogingIn.value = true;
    dynamic data = {"email": tecEmail.text, "password": controllerpassword.text};
    ResponseModel response = await APIsCallPost.submitRequestWithOutAuth(
      g365Module == G365Module.employeePortal
          ? "Users/EmployeeLogin"
          : g365Module == G365Module.contractorPortal
          ? "Users/ContractorLogin"
          : "Users/NewLoginV2",
      data,
    );
    loogingIn.value = false;
    gLogger(response.data);
    gLogger(response.statusCode);
    dynamic decodedData = jsonDecode(response.data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (g365Module == G365Module.employeePortal || g365Module == G365Module.contractorPortal) {
        loginResponseHandlerForEmployeePortal(context, decodedData);
      } else {
        if (decodedData["payload"] != null && decodedData["payload"]["mfaRequired"] == true) {
          // MFA Required - Handle it
          _handleMfaRequired(context, decodedData["payload"]);
        } else {
          loginResponsehandler(context, decodedData);
        }
      }
    } else {
      loogingIn.value = false;

      GToast.error(decodedData["message"].toString(), context);
    }
  }

  // OTP/MFA state variables
  RxList mfaMethods = [].obs;
  RxBool showOtpScreen = false.obs;
  RxInt otpSessionId = 0.obs;
  RxString otpMethod = "".obs;
  TextEditingController tecOtpController = TextEditingController();
  RxBool isOtpButtonEnabled = false.obs;
  RxBool rememberDevice = false.obs;
  void _handleMfaRequired(BuildContext context, dynamic payload) {
    int sessionId = payload["sessionId"];
    String method = payload["defaultMethod"] ?? "Email";
    List methods = payload["mfaMethods"] ?? [];
    print("method of the login api is $method");
    // Set state to show OTP screen inline
    otpSessionId.value = sessionId;
    otpMethod.value = method;
    mfaMethods.value = methods;

    showOtpScreen.value = true;

    print("showOtpScreen.value of the login api is ${showOtpScreen.value}");
    tecOtpController.clear();
    isOtpButtonEnabled.value = false;
    update();
  }

  // Old dialog functions removed - now using inline OTP verification

  Future<void> verifyOtp(BuildContext context, int sessionId, String otp, bool rememberDevice) async {
    if (otp.isEmpty) return;
    loogingIn.value = true; // Show loading indicator if needed

    dynamic data = {"sessionId": sessionId, "otp": otp, "rememberDevice": rememberDevice};
    GProgressDialog(context).show();
    ResponseModel response = await APIsCallPost.submitRequestWithOutAuth("Users/VerifyOtp", data);
    GProgressDialog(context).hide();
    loogingIn.value = false;
    dynamic decodedData = jsonDecode(response.data);

    if (response.statusCode == 200) {
      // Reset OTP screen state
      showOtpScreen.value = false;
      tecOtpController.clear();
      loginResponsehandler(context, decodedData);
    } else {
      GToast.error(decodedData["message"].toString(), context);
    }
  }

  Future<void> resendOtp(BuildContext context) async {
    dynamic data = {"sessionId": otpSessionId.value, "method": otpMethod.value};
    GProgressDialog(context).show();
    ResponseModel response = await APIsCallPost.submitRequestWithOutAuth("Users/ResendOtp", data);
    GProgressDialog(context).hide();
    if (response.statusCode == 200) {
      GToast.succss("OTP Resent", context);
    } else {
      GToast.error("Failed to resend OTP", context);
    }
  }

  void verifyOtpInline(BuildContext context) {
    verifyOtp(context, otpSessionId.value, tecOtpController.text, rememberDevice.value);
  }

  void cancelOtpFlow() {
    showOtpScreen.value = false;
    tecOtpController.clear();
    isOtpButtonEnabled.value = false;
    rememberDevice.value = false;
  }

  Future<void> switchOtpMethod(BuildContext context, int sessionId, String method) async {
    dynamic data = {"sessionId": sessionId, "method": method};
    GProgressDialog(context).show();
    // (M-21)SwitchOtpMethod
    ResponseModel response = await APIsCallPost.submitRequestWithOutAuth("Users/SwitchOtpMethod", data);
    GProgressDialog(context).hide();

    dynamic decodedData = jsonDecode(response.data);

    if (response.statusCode == 200) {
      // Reset OTP screen state
      GToast.succss(decodedData["message"].toString(), context);
      tecOtpController.clear();
      otpMethod.value = method;
    } else {
      GToast.error(decodedData["message"].toString(), context);
    }
  }

  Future<void> acceptEmployeeInvite(BuildContext context) async {
    ResponseModel response = await APIsCallPut.updateRequestWithIdwithoutbody(
      "Users/InvitationEmpResponseVerfiiedUser?VerifiedCode=$inviteCode&IsAccepted=true",
    );
    inviteCode.value = "";
    gLogger(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic decodedData = jsonDecode(response.data);
      dynamic companyData = jsonEncode(decodedData["payload"] ?? {});
      gLogger("Accepted Invitation Company Data: $companyData");
      prefs.setString("acceptedInvitationCompanyData", companyData);
      gLogger("THIS IS STORED IN SHARED PREFS NOW :::::: ${prefs.getString("acceptedInvitationCompanyData")}");
      GToast.succss("Invitation accepted successfully", context);
    } else {
      GToast.error("Failed to accept invitation", context);
    }
  }

  Future<void> acceptPayrollUserInvite(BuildContext context) async {
    ResponseModel response = await APIsCallPut.updateRequestWithIdwithoutbody(
      "Users/InvitationResponseVerfiiedUser?IsAccepted=true&VerifiedCode=${inviteCode.value.trim()}",
    );
    gLogger(response.data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic decodedData = jsonDecode(response.data);
      prefs.setString("acceptedInvitationCompanyData", jsonEncode(decodedData["payload"] ?? {}));
      GToast.succss("Invitation accepted successfully", context);
    } else {
      dynamic decodedData = jsonDecode(response.data);
      GToast.error(decodedData["message"] ?? "Failed to accept invitation", context);
    }
    inviteCode.value = "";
  }

  loginResponseHandlerForEmployeePortal(BuildContext context, dynamic decodedData) async {
    accessToken = (decodedData["payload"] ?? {})["token"];
    companyId = (decodedData["payload"] ?? {})['defaultCompanyId'].toString();
    employeeId = (decodedData["payload"] ?? {})['employeeId'].toString();
    contractorId = (decodedData["payload"] ?? {})['contractorId'].toString();
    userNameForGlobals.value = (decodedData["payload"] ?? {})["firstName"] ?? "Mr.";
    if (inviteCode.value.isNotEmpty) {
      await acceptEmployeeInvite(context);
    }
    Global365Widgets.loginCallBack((decodedData["payload"] ?? {}));

    prefs.setString("accessToken", accessToken);
    prefs.setString("employeeId", employeeId);
    prefs.setString("contractorId", contractorId);
    prefs.setString("companyId", companyId.toString());
    prefs.setString("companyLogo", companyLogo.value);
    prefs.setString("userFirstName", userNameForGlobals.value);
    prefs.setBool("isAppOpen", true);

    GNav.goNav(context, GRouteConfig.dashboard);
  }

  loginResponsehandler(BuildContext context, dynamic decodedData, {bool? companyStatus, bool? isRedirectLogin}) async {
    accessToken = (decodedData["payload"] ?? {})["token"];

    // if I am redirecting from Accounting and status of Merchant is false, it will redirect me to setup screen no matter what.
    if (companyStatus == false && g365Module != G365Module.payroll) {
      GNav.pushNav(context, "${GRouteConfig.setUpScreenRoute}?orgId=$orgId");
      return;
    }
    gLogger(((decodedData["payload"] ?? {})["userPreferences"]));
    //     PreferencesData.myPreferencesGeneral = ((decodedData["payload"] ?? {})["userPreferences"]) == null
    //         ? PreferencesData.myPreferencesGeneral
    //         : jsonDecode((decodedData["payload"] ?? {})["userPreferences"]);
    //     gLogger("myPreferencesGeneral.myPreferencesGeneral  is in login is ${PreferencesData.myPreferencesGeneral}");

    //     profileImage.value = (decodedData["payload"] ?? {})["profileImage"] ?? "";

    //     isPaymentRedirectionPopupDisable.value = (decodedData["payload"] ?? {})["isPaymentRedirectionPopupDisable"] ?? false;
    //     gLogger(decodedData["payload"]);
    //     gLogger("Default Company Id is ${decodedData["payload"]["defaultCompanyId"]}");
    List listOfConpanies = (decodedData["payload"] ?? {})['loggedCompanies'] ?? [];
    //     bool isPaymentMethodVerified = (decodedData["payload"] ?? {})['isPaymentMethodVerfied'] ?? false;
    //     if (isPaymentMethodVerified == false) {
    //       GNav.pushNav(context, RouteConfig.paymentInfoRoute);
    //       return;
    //     }
    if (listOfConpanies.isEmpty) {
      if ((decodedData["payload"] ?? {})["isPaymentMethodVerfied"] == false) {
        GNav.pushNav(context, GRouteConfig.paymentInfoRoute);
        return;
      } else {
        GNav.pushNav(context, "${GRouteConfig.setUpScreenRoute}?orgId=$orgId");
        return;
      }
    }
    // isPayrollDashboardStepsComplete.value = (decodedData["payload"] ?? {})['isCompanyTabs'] ?? false;

    Global365Widgets.loginCallBack((decodedData["payload"] ?? {}));
    dynamic defaultCompany = listOfConpanies.firstWhere(
      (element) => element["companyId"].toString() == (decodedData["payload"] ?? {})['defaultCompanyId'].toString(),
      orElse: () => listOfConpanies.first,
    );
    totalNoOfUsersSlots = (defaultCompany["subscription"] ?? {})["totalNoOfUsersSlots"] ?? 0;
    usedSlotsOfUsers = (defaultCompany["subscription"] ?? {})["usedSlotsOfUsers"] ?? 0;
    totalNoOfEmployeeSlots = (defaultCompany["subscription"] ?? {})["totalNoOfEmployeeSlots"] ?? 0;
    usedSlotsOfEmployees = (defaultCompany["subscription"] ?? {})["usedSlotsOfEmployee"] ?? 0;
    usedSlotsOfContractors = (defaultCompany["subscription"] ?? {})["usedSlotsOfContractors"] ?? 0;
    loggedInUserRole = (defaultCompany)["role"] ?? "";

    companyId = (defaultCompany["companyId"] ?? 0).toString();
    // locationId = (defaultCompany["locationId"] ?? 0).toString();
    // companyLogo.value = defaultCompany["companyLogo"] ?? "";
    //     gLogger("Company Logo ####   ${companyLogo.value} ");
    companyAddress = defaultCompany["companyAddress"] ?? "";
    companyAddressLine1 = defaultCompany["addressLineOne"] ?? "";
    companyAddressLine2 = defaultCompany["addressLineTwo"] ?? "";
    if (companyAddress.isEmpty) {
      companyAddress = "$companyAddressLine1 $companyAddressLine2";
      companyAddress = companyAddress.trim();
    }
    companyCity = defaultCompany["city"] ?? "";
    companyState = defaultCompany["state"] ?? "";
    companyZip = defaultCompany["zip"] ?? "";
    final addressBuffer = StringBuffer();
    if (companyAddressLine1.isNotEmpty) addressBuffer.writeln(companyAddressLine1);
    if (companyAddressLine2.isNotEmpty) addressBuffer.writeln(companyAddressLine2);
    if (companyCity.isNotEmpty || companyState.isNotEmpty || companyZip.isNotEmpty) {
      addressBuffer.write(companyCity);
      if (companyCity.isNotEmpty && companyState.isNotEmpty) addressBuffer.write(", ");
      addressBuffer.write(companyState);
      if ((companyCity.isNotEmpty || companyState.isNotEmpty) && companyZip.isNotEmpty) addressBuffer.write(" ");
      addressBuffer.write(companyZip);
    }

    final formattedAddress = addressBuffer.toString().trim();
    companyCompleteAddress = formattedAddress.isNotEmpty ? formattedAddress : "No Address Provided";

    // isAccountant.value = defaultCompany["isAccountant"] ?? false;
    companyPhoneNo = defaultCompany["companyPhoneNumber"] ?? "";
    companyEmail = defaultCompany["companyEmail"] ?? "";
    // isMerchant = defaultCompany["isMerchant"] ?? false;
    //     // isMerchant = false;
    //     globals.permissions = Permissions.fromJson(defaultCompany["companywisePermissions"]);
    //     MainDashBoardController.to.listOfWidgets.value =
    //         (defaultCompany["dashboardPreference"] == null || defaultCompany["dashboardPreference"] == "string" || defaultCompany["dashboardPreference"].isEmpty)
    //             ? MainDashBoardController.to.listOfWidgetsDefualt
    //             : jsonDecode(defaultCompany["dashboardPreference"] ?? []);
    //     prefs.setString("listOfWidgets", jsonEncode(MainDashBoardController.to.listOfWidgets.value));
    //     gLogger(defaultCompany["companyPreferences"]);
    //     PreferencesData.preferencesGeneral = ((defaultCompany["companyPreferences"] == null) ||
    //             ((defaultCompany["companyPreferences"] ?? {})["general"]) == null ||
    //             ((defaultCompany["companyPreferences"] ?? {})["general"]) == "string")
    //         ? PreferencesData.preferencesGeneral
    //         : jsonDecode((defaultCompany["companyPreferences"] ?? {})["general"] ?? {});

    //     gLogger("PreferencesData.preferencesGeneral  is in login is ${PreferencesData.preferencesGeneral}");
    //     gLogger("permissions ---=> ${permissions.apDetail.export}");

    //     final jsonString = defaultCompany["companywisePermissions"];
    //     prefs.setString("permissions", jsonEncode(jsonString));
    companyNameForGlobals.value = defaultCompany["companyName"] ?? "Globals";
    companyIdentityID.value = defaultCompany["companyIdentityId"] ?? "";
    userNameForGlobals.value = (decodedData["payload"] ?? {})["firstName"] ?? "Mr.";
    //     gLogger("Company name and id is $companyId and $companyNameForGlobals");
    prefs.setInt("totalNoOfUsersSlots", totalNoOfUsersSlots);
    prefs.setInt("usedSlotsOfUsers", usedSlotsOfUsers);
    prefs.setInt("totalNoOfEmployeeSlots", totalNoOfEmployeeSlots);
    prefs.setInt("usedSlotsOfEmployee", usedSlotsOfEmployees);
    prefs.setInt("usedSlotsOfContractors", usedSlotsOfContractors);
    prefs.setString("loggedInUserRole", loggedInUserRole);
    prefs.setString("accessToken", accessToken);
    prefs.setBool("isPayrollDashboardStepsComplete", isPayrollDashboardStepsComplete.value);
    prefs.setString('usernameforInvitationCompare', tecEmail.text);
    prefs.setString("companyId", companyId.toString());
    prefs.setString("companyLogo", companyLogo.value);
    gLogger("Company Logo after save ####   ${companyLogo.value} ");
    prefs.setString("companyAddress", companyAddress);
    prefs.setString("addressLine1", companyAddressLine1);
    prefs.setString("addressLine2", companyAddressLine2);
    prefs.setString("companyCity", companyCity);
    prefs.setString("companyState", companyState);
    prefs.setString("companyZip", companyZip);
    prefs.setString("companyPhoneNo", companyPhoneNo);
    prefs.setString("companyEmail", companyEmail);
    prefs.setString("companyName", companyNameForGlobals.value);
    prefs.setString("companyIdentityID", companyIdentityID.value);

    prefs.setString("userFirstName", userNameForGlobals.value);
    prefs.setString("companyCompleteAddress", companyCompleteAddress);
    prefs.setBool("isAppOpen", true);
    gLogger("Company Complete Address is $companyCompleteAddress");

    // prefs.setBool("isMerchant", isMerchant);

    //     if (listOfConpanies != null && listOfConpanies.isNotEmpty) {
    //       globals.loggedCompanyModel = LoggedCompanyModel.fromJson(defaultCompany);
    //       List<LoggedCompanyModel> templist = [];
    //       for (var item in listOfConpanies) {
    //         templist.add(LoggedCompanyModel.fromJson(item));
    //       }
    //       listLoggedCompanies.value = templist;
    //       prefs.setString("listLoggedCompanies", jsonEncode(listOfConpanies));
    //       log("globals.loggedCompanyModel => ${globals.loggedCompanyModel}");
    //       final jsonString = json.encode(globals.loggedCompanyModel.toJson());
    //       prefs.setString("loggedCompanyModel", jsonString);
    //       log("globals.loggedCompanyModel after set => ${globals.loggedCompanyModel}");
    //     }
    //     loogingIn.value = false;
    //     // Deleting existing controllers
    //     Get.delete<CustomerDashBoardController>();
    //     Get.delete<FdashbordController>();
    //     Get.delete<VendorDashBoardController>();
    //     Get.delete<EnterBillController>();
    //     Get.delete<ReportsDashboardController>();
    //     Get.delete<SalesReceiptController>();
    //     Get.delete<FinancialAddAccountController>();
    //     Get.delete<CustomerHeaderController>();
    //     Get.delete<EstimateFormController>();
    //     Get.delete<VendorHeaderController>();
    //     Get.delete<ReportHeaderController>();
    //     Get.delete<FinancialHeaderController>();
    //     Get.delete<DashBoardHeaderController>();
    //     Get.delete<SettingsHeaderController>();
    //     Get.delete<MakeDepositsController>();
    //     Get.delete<CreateStatementController>();
    //     Get.delete<PrintingController>();
    //     Get.delete<FinancialController>();
    //     Get.delete<CustomizationController>();
    //     Get.delete<CustomerRefundController>();
    //     Get.delete<CustomerRefundHistoryController>();

    // // Registering controllers to be lazily instantiated
    //     Get.lazyPut(() => CustomerDashBoardController());
    //     Get.lazyPut(() => FdashbordController());
    //     Get.lazyPut(() => VendorDashBoardController());
    //     Get.lazyPut(() => EnterBillController());
    //     Get.lazyPut(() => ReportsDashboardController());
    //     Get.lazyPut(() => SalesReceiptController());
    //     Get.lazyPut(() => FinancialAddAccountController());
    //     Get.lazyPut(() => CustomerHeaderController());
    //     Get.lazyPut(() => EstimateFormController());
    //     Get.lazyPut(() => VendorHeaderController());
    //     Get.lazyPut(() => ReportHeaderController());
    //     Get.lazyPut(() => FinancialHeaderController());
    //     Get.lazyPut(() => DashBoardHeaderController());
    //     Get.lazyPut(() => SettingsHeaderController());
    //     Get.lazyPut(() => MakeDepositsController());
    //     Get.lazyPut(() => CreateStatementController());
    //     Get.lazyPut(() => PrintingController());
    //     Get.lazyPut(() => FinancialController());
    //     Get.lazyPut(() => CustomizationController());
    //     Get.lazyPut(() => CustomerRefundController());
    //     Get.lazyPut(() => CustomerRefundHistoryController());
    //     Get.delete<ProfitLossReportController>();
    //     Get.lazyPut(() => ProfitLossReportController());
    //     Get.delete<UsersPageController>();
    //     Get.put(UsersPageController());
    //     if (globals.isLoggingInInvitedUser.isTrue) {
    //       UserInvitationController.to.pageNumber.value = 0;
    //       globals.isUserAlreadyLogedin = true;
    //       GNav.goNav(context, RouteConfig.userInvitationPageRoute);
    //       // AutoRouter.of(context).push(const UserInvitationPageRoute());
    //     } else {

    // Accept payroll user invitation if inviteCode is present
    if (inviteCode.value.isNotEmpty) {
      await acceptPayrollUserInvite(context);
    }
    if (g365Module == G365Module.merchant &&
        (defaultCompany ?? {})["merchantApprovalStatus"].toString().toLowerCase() == "IN_PROGRESS".toLowerCase() &&
        isRedirectLogin == true) {
      GNav.pushNavWithExtra(context, GRouteConfig.dashboard, {"isFromSignup": true});
      return;
    }
    GNav.goNav(context, GRouteConfig.dashboard);
    gLogger("Withing login go route");
    //       // context.go('/Dashboard');
    //       // context.go(RouteConfig.dashboardRoute);
    //       // AutoRouter.of(context).replaceAll([const DashboardRoute()]);
    //     }
    tecEmail.text = "";
    controllerpassword.text = "";
  }

  Future<void> redirectFromCPA(BuildContext context, String code) async {
    // ResponseModel response = await APIsCallPost.submitRequest("Users/NewLoginByUniqueCode?UniqueCode=$code", {});
    // dynamic decodedData = jsonDecode(response.data);

    // if (response.statusCode == 200 || response.statusCode == 201) {
    //   loginResponsehandler(context, decodedData);
    // } else {
    //   GToast.error(decodedData["message"].toString(), context);
    //   GNav.goNav(context, RouteConfig.loginUsaPageRoute);
    // }
  }

  Future<void> redirectLogin(BuildContext context, String code, bool companyStatus) async {
    ResponseModel response = await APIsCallPost.submitRequest(
      g365Module == G365Module.payroll
          ? "Users/LoginByUniqueCode?UniqueCode=$code"
          : "Users/NewLoginByUniqueCode?UniqueCode=$code",
      {},
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic decodedData = jsonDecode(response.data);

      loginResponsehandler(context, decodedData, companyStatus: companyStatus, isRedirectLogin: true);
    } else {
      GToast.error(response.data.toString(), context);
      GNav.goNav(context, GRouteConfig.loginUsaPageRoute);
    }
  }

  RxBool loogingIn = false.obs;

  RxBool checkedValue = false.obs;

  void launchURL(String url) async => await canLaunch(url)
      ? await launch(url, forceSafariVC: true, forceWebView: true, webOnlyWindowName: '_self')
      : throw 'Could not launch $url';
}
