import 'package:flutter/material.dart';
import 'package:global365_widgets/src/constants/constants.dart';

//const Color Color = Color(0xFF0055FF);

Color textColor = const Color(0xFFA1B1C2);
Color subTextColor = const Color(0xFF707070);
Color greyBackground = const Color.fromARGB(255, 252, 252, 252);
Color mainColorPrimary = primaryColor;
Color mainColorPrimaryYellow = secondaryColorOrange;
Color mainColorSecondry = const Color.fromARGB(255, 252, 252, 252);
Color maingreen = const Color.fromRGBO(37, 207, 75, 1);
Color maingrey = const Color.fromRGBO(137, 153, 159, 1);
Color dashboardtitilecolor = const Color.fromRGBO(45, 44, 44, 1);
Color selectedBackground = const Color.fromRGBO(255, 255, 255, 1);
Color whiteColor = Colors.white;
const cancelBorder = Color(0xffD9E2E4);

Color? textFieldFillColor = Colors.grey[50];
const Color textFieldIconColor = Color(0xFF5D6A78);
const Color categoryIconColor = Color(0xFFB3C0C8);
const Color backgroundcustomer = Color(0xFFF8F8F8);
const Color borderCustomer = Color(0xFFC4D2D8);
const Color txtCustomer = Color(0xFF777777);
const Color greyC0C0C0 = Color(0xFFC0C0C0);
const Color cTitleColor = Color(0XFF2D2C2C);
const Color primaryWhite = Colors.white;

const Color kCustomBlackColor = Color(0xff000000);
const Color kCustomGreyColor = Color(0xff89999F);
const Color kCustomBlueColor = Color(0xff003A4D);
const Color kCustomLightestGreyColor = Color(0xfff0f6f8);

Color colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}
