import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/src/constants/branding.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';


const String packageName = "global365_widgets";
RxBool isLoggingInInvitedUser = false.obs;
bool isFirstpurchase = false;
String accessToken = "";
String tokenType = "Bearer";
String apiLink = "https://api.global365.com/api/v1/";
String apiLink2 = "https://api.global365.com/api/v1/";

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
