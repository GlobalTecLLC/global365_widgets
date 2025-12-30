import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/constants/branding.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/utils/print_log.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String packageName = "global365_widgets";
RxBool isLoggingInInvitedUser = false.obs;
bool isFirstpurchase = false;
String accessToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiZmFyb29xYXppekBnbWFpbC5jb20iLCJqdGkiOiI3NThlNGFiMC0zYTM2LTQ3YTgtYjU2ZC0yODE0MDdkNzU2NGYiLCJVc2VySWQiOiIwOWU5NTEwMS01YzUzLTQ3ZjQtYmQ5ZS1iYWIwMjA0ZjFmZTMiLCJleHAiOjE3NTIyMzM2MjIsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcxMTUiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjcxMTUifQ.Fx4Vszmpqpv6nfi-a17mxJvfFYErLd23ktBgrdKM26c";
String tokenType = "Bearer";
String apiLink = "https://api.global365.com/api/v1/";
String apiLink2 = "https://admindev.globalgroup.co/api/v2/";

String employeeId = "";
String contractorId = "";

G365Module g365Module = G365Module.accounting;
String applicationEnviroment = "";

String companyId = "";
late SharedPreferences prefs;

RxBool isPayrollDashboardStepsComplete = false.obs; // payrollDashboardStepsComplete

String companyname = "Technupur";
int fiscalYearId = 1;
String companyAddress = "";
String companyCompleteAddress = "";
String companyEmail = "";
String companyAddressLine1 = "";
String companyAddressLine2 = "";
String companyCity = "";
String companyState = "";
String companyZip = "";
String companyPhoneNo = "";
RxString userNameForGlobals = "John".obs;
RxString companyNameForGlobals = "".obs;
RxString companyIdentityID = "".obs;
RxString profileImage = "".obs;
// RxString companyId = "67".obs;
RxString companyLogo = "".obs;
bool isUserAlreadyLogedin = false;

extension TextEditingControllerExt on TextEditingController {
  void selectAll() {
    if (text.isEmpty) return;
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}

RxList dropDownValuesforSave = ["Save and New"].obs;

RxList dropDownValuesforSaveAndClose = ["Save and Close"].obs;

Widget globalSpinkit({double? size}) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: SpinKitRipple(color: mainColorPrimary, size: size ?? 150),
    ),
  );
}

Widget globalSpinkitForLoaders() {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: SpinKitThreeBounce(color: mainColorPrimary, size: 26.0),
    ),
  );
}

Widget globalSpinkitForLoaderswithBorder({
  bool isLessHeightLoader = false,
  double? height,
  double? width,
  bool isFieldForTable = false,
}) {
  return Container(
    height: height ?? (isLessHeightLoader ? 18 : 32),
    width: width,
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(isFieldForTable ? 0 : Branding.tFborderR),
      border: Border.all(width: isFieldForTable ? 0.5 : 1, style: BorderStyle.solid, color: borderColor),
    ),
    child: globalSpinkitForLoaders(),
  );
}

String getModuleLogo() {
  return g365Module == G365Module.merchant
      ? "assets/svg/logo_merchant_dark.svg"
      : g365Module == G365Module.payroll
      ? "assets/svg/payroll_dark.svg"
      : 'assets/svg/countylogo.svg';
}

Widget g365NetworkImage(
  String url,
  double height,
  double width, {
  BoxFit? fit = BoxFit.cover,
  Function? onTap,
  String placeHolderName = "",
}) {
  return FadeInImage(
    height: height,
    width: width,
    fit: fit,
    imageErrorBuilder: (context, e, stackTrace) => widgetTextPlaceHolder(placeHolderName: placeHolderName),
    image: NetworkImage(url),
    placeholder: const AssetImage('assets/imgs/logo2.png'),
  );
}

Widget widgetTextPlaceHolder({String placeHolderName = ""}) {
  String placeHolder = "";
  if (placeHolderName != "") {
    try {
      if (placeHolderName.isNotEmpty) {
        List companynameList = placeHolderName.split(" ");
        if (companynameList.length > 1) {
          String a = companynameList[0];
          String b = companynameList[1];
          if (a.isNotEmpty) {
            placeHolder += a.substring(0, 1);
          }
          if (b.isNotEmpty) {
            placeHolder += b.substring(0, 1);
          }
        } else {
          if (companynameList.length == 1) {
            placeHolder += companynameList[0].toString().substring(0, 1);
          }
        }
      } else {
        placeHolder = "T";
      }
    } catch (e) {
      placeHolder = "T";
    }
    return SizedBox(
      // color: mainColorPrimaryYellow.withOpacity(0.2),
      height: 30,
      width: 30,
      child: CircleAvatar(
        radius: 15,
        backgroundColor: Colors.transparent,
        child: Center(child: Opacity(opacity: 1, child: GTextHeading3(placeHolder))),
      ),
    );
  } else {
    try {
      if (companyname.isNotEmpty) {
        List companynameList = companyname.split(" ");
        if (companynameList.length > 1) {
          String a = companynameList[0];
          String b = companynameList[1];
          if (a.isNotEmpty) {
            placeHolder += a.substring(0, 1);
          }
          if (b.isNotEmpty) {
            placeHolder += b.substring(0, 1);
          }
        } else {
          if (companynameList.length == 1) {
            placeHolder += companynameList[0].toString().substring(0, 1);
          }
        }
      } else {
        placeHolder = "T";
      }
    } catch (e) {
      placeHolder = "T";
    }
    return SizedBox(
      // color: mainColorPrimaryYellow.withOpacity(0.2),
      height: 30,
      width: 30,
      child: CircleAvatar(
        radius: 15,
        backgroundColor: mainColorPrimaryYellow.withOpacity(0.2),
        child: Center(child: Opacity(opacity: 0.5, child: GTextHeading3(placeHolder))),
      ),
    );
  }
}

bool isValidEmail(String email) {
  String pattern = r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
  RegExp regex = RegExp(pattern);
  return regex.hasMatch(email);
}

bool isValidUrl(String url) {
  final Uri? uri = Uri.tryParse(url);
  gLogger("in the isValidUrl is $uri");
  return uri != null && (uri.scheme == 'http' || uri.scheme == 'https');
}

bool isValidPhoneNumber(String phonenumber) {
  String pattern = r'^[+]?[0-9]{1,4}[ -]?[0-9]{3}[ -]?[0-9]{3}[ -]?[0-9]{3}$';
  RegExp regexph = RegExp(pattern);
  return regexph.hasMatch(phonenumber);
}

String formateDateToSendToApi(String inputDate) {
  // printLog("formate date function is called data $inputDate");
  try {
    // Parse the date string using the expected input format
    DateFormat inputFormat = DateFormat('MM/dd/yyyy');
    DateTime dateTime = inputFormat.parse(inputDate);

    // Format the parsed DateTime object to the desired output format
    DateFormat outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(dateTime);
  } catch (e) {
    // Handle the exception and return an appropriate message or rethrow
    print('Error parsing date: $e');
    return '';
  }
}
