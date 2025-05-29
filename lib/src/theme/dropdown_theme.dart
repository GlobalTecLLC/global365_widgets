import 'package:flutter/material.dart';
import 'package:global365_widgets/src/theme/text_widgets/text_variants/text_heading5.dart';

import '../../global365_widgets.dart';
import '../constants/colors.dart';
import '../constants/constants.dart';
import 'app_style.dart';

class GDropDownTheme {
  /// Header Text Widget
  static Text headerText(String label) {
    return Text(
      label,
      style: TextStyle(color: titleColor, fontFamily: "Montserrat", fontSize: 12, fontWeight: FontWeight.w600),
    );
  }

  static GTextHeading5 headerTextBold(String label) {
    return GTextHeading5(label);
  }

  // BorderRadius.circular(isFieldForTable ? 0 : 5),
  // DropDown Decoration
  static InputDecoration dropDownDecoration(
    String hintText, {
    bool isFieldForTable = false,
    bool isBorder = true,
    Color filledColor = primaryWhite,
    double? paddingVertical,
  }) {
    return InputDecoration(
      suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: placeHolderColor),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: paddingVertical ?? 8.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(isFieldForTable ? 0 : Branding.tFborderR),
        borderSide: isBorder ? BorderSide(width: isFieldForTable ? 0.5 : 1, color: borderColor) : BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(isFieldForTable ? 0 : Branding.tFborderR),
        borderSide: isBorder ? BorderSide(width: isFieldForTable ? 0.5 : 1, color: borderColor) : BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(isFieldForTable ? 0 : Branding.tFborderR),
        borderSide: isBorder ? BorderSide(width: isFieldForTable ? 0.5 : 1, color: borderColor) : BorderSide.none,
      ),
      hintText: 'Select $hintText',
      hintStyle: GAppStyle.style12w400(color: placeHolderColor),
      filled: true,
      fillColor: filledColor,
      hintMaxLines: 1,
      errorMaxLines: 1,
      helperMaxLines: 1,
    );
  }

  static InputDecoration dropDownDecorationBold(
    String hintText, {
    bool isFieldForTable = false,
    bool isBorder = true,
    Color filledColor = primaryWhite,
    double? paddingVertical,
  }) {
    return InputDecoration(
      suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded, color: placeHolderColor),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(horizontal: 8.0, vertical: paddingVertical ?? 8.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(isFieldForTable ? 0 : Branding.tFborderR),
        borderSide: isBorder ? BorderSide(width: isFieldForTable ? 0.5 : 1, color: borderColor) : BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(isFieldForTable ? 0 : Branding.tFborderR),
        borderSide: isBorder ? BorderSide(width: isFieldForTable ? 0.5 : 1, color: borderColor) : BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(isFieldForTable ? 0 : Branding.tFborderR),
        borderSide: isBorder ? BorderSide(width: isFieldForTable ? 0.5 : 1, color: borderColor) : BorderSide.none,
      ),
      hintText: 'Select $hintText',
      hintStyle: GAppStyle.style12w600(color: placeHolderColor),
      filled: true,
      fillColor: filledColor,
      hintMaxLines: 1,
      errorMaxLines: 1,
      helperMaxLines: 1,
    );
  }

  /// Display Text Stlye

  static TextStyle displayTextStyle() {
    return TextStyle(color: bodyTextDark, fontSize: 12, fontFamily: 'Montserrat', fontWeight: FontWeight.w400);
  }

  static TextStyle displayTextStyleBold() {
    return GAppStyle.style12w600(color: bodyTextDark);
  }

  /// Dropdown item Style
  static TextStyle dropDownItemStyle({
    Color color = bodyTextDark,
    String fontFamily = 'Montserrat',
    FontWeight? fontWeight,
    double? fontSize,
  }) {
    return TextStyle(color: color, fontSize: fontSize ?? 12, fontFamily: fontFamily, fontWeight: fontWeight);
  }
}

dropDownSizedBox({required Widget child, double? height, double? width}) {
  return SizedBox(height: height ?? Branding.dropDHeight, width: width, child: child);
}

class Branding {
  /// Text Field Border Radius
  static double tFborderR = 4;

  /// Text Field Height
  static double tFHeight = 30;

  /// DropDown Height
  static double dropDHeight = 30;
}
