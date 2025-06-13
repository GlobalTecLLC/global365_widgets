import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/intializer.dart';
import 'package:global365_widgets/src/constants/branding.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';

const String packageName = "global365_widgets";
RxBool isLoggingInInvitedUser = false.obs;
bool isFirstpurchase = false;
String accessToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiZmFyb29xYXppekBnbWFpbC5jb20iLCJqdGkiOiI3NThlNGFiMC0zYTM2LTQ3YTgtYjU2ZC0yODE0MDdkNzU2NGYiLCJVc2VySWQiOiIwOWU5NTEwMS01YzUzLTQ3ZjQtYmQ5ZS1iYWIwMjA0ZjFmZTMiLCJleHAiOjE3NTIyMzM2MjIsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcxMTUiLCJhdWQiOiJodHRwOi8vbG9jYWxob3N0OjcxMTUifQ.Fx4Vszmpqpv6nfi-a17mxJvfFYErLd23ktBgrdKM26c";
String tokenType = "Bearer";
String apiLink = "https://api.global365.com/api/v1/";
String apiLink2 = "https://admindev.globalgroup.co/api/v2/";


G365Module g365Module = G365Module.accounting;

String companyId = "";

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

Widget globalSpinkitForLoaderswithBorder({bool isLessHeightLoader = false, double? height, double? width, bool isFieldForTable = false}) {
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
