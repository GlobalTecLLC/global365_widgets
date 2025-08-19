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

  String orgId = "0";

  RxBool checkedValueEmailLogin = true.obs;
  // final formKey = GlobalKey<FormState>();
  TextEditingController tecEmail = TextEditingController();
  TextEditingController controllerusernmae = TextEditingController();
  TextEditingController controllerpassword = TextEditingController();

  RxBool passwordVisible = true.obs;

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
    ResponseModel response = await APIsCallPost.submitRequestWithOutAuth("Users/NewLogin", data);
    loogingIn.value = false;
    gLogger(response.data);
    gLogger(response.statusCode);
    dynamic decodedData = jsonDecode(response.data);

    if (response.statusCode == 200 || response.statusCode == 201) {
      loginResponsehandler(context, decodedData);
    } else {
      loogingIn.value = false;

      GToast.error(decodedData["message"].toString(), context);
    }
  }

  loginResponsehandler(BuildContext context, dynamic decodedData) async {
    accessToken = (decodedData["payload"] ?? {})["token"];

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
      GNav.pushNav(context, "${GRouteConfig.setUpScreenRoute}?orgId=$orgId");
      return;
    }

    Global365Widgets.loginCallBack((decodedData["payload"] ?? {}));
    dynamic defaultCompany = listOfConpanies.firstWhere(
      (element) => element["companyId"].toString() == (decodedData["payload"] ?? {})['defaultCompanyId'].toString(),
      orElse: () => listOfConpanies.first,
    );

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
    userNameForGlobals.value = (decodedData["payload"] ?? {})["firstName"] ?? "Mr.";
    //     gLogger("Company name and id is $companyId and $companyNameForGlobals");
    prefs.setString("accessToken", accessToken);
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
    prefs.setString("userFirstName", userNameForGlobals.value);
    prefs.setString("companyCompleteAddress", companyCompleteAddress);
    gLogger("Company Complete Address is $companyCompleteAddress");




    // prefs.setBool("isMerchant", isMerchant);
    prefs.setBool("isAppOpen", true);

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

  Future<void> redirectLogin(BuildContext context, String code) async {
    ResponseModel response = await APIsCallPost.submitRequest("Users/NewLoginByUniqueCode?UniqueCode=$code", {});

    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic decodedData = jsonDecode(response.data);

      loginResponsehandler(context, decodedData);
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
