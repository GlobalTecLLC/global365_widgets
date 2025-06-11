import 'package:flutter/material.dart';

import '../constants/constants.dart';

class GTextFiledTheme {
  // DropDown Decoration
  static InputDecoration inputDecoration({
    double? fontSizeForAll,
    bool isFieldForTable = false,
    bool isZeroPadding = false,
    String hintText = "",
    Widget? suffixIcon,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: placeHolderColor,
        fontSize: fontSizeForAll ?? 12,
        fontWeight: FontWeight.w400,
        fontFamily: "Montserrat",
      ),
      isDense: true,
      border: InputBorder.none,
      contentPadding: isZeroPadding
          ? EdgeInsets.symmetric(horizontal: 3, vertical: 10)
          : EdgeInsets.symmetric(horizontal: 8, vertical: 9),
      // border: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(isFieldForTable ? 0 : Branding.tFborderR),
      //   borderSide: BorderSide(width: isFieldForTable ? 0.5 : 1.cWE, color: borderColor),
      // ),
      // disabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(isFieldForTable ? 0 : Branding.tFborderR),
      //   borderSide: BorderSide(width: isFieldForTable ? 0.5 : 1.cWE, color: borderColor),
      // ),
      // focusedBorder: OutlineInputBorder(

      //   borderRadius: BorderRadius.circular(isFieldForTable ? 0 : Branding.tFborderR),
      //   borderSide: BorderSide(width: isFieldForTable ? 0.5 : 1.cWE, color: borderColor),
      // ),
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(isFieldForTable ? 0 : Branding.tFborderR),
      //   borderSide: BorderSide(width: isFieldForTable ? 0.5 : 1.cWE, color: borderColor),
      // ), // labelText: labelText,
      // filled: true,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      // fillColor: whiteColor,
    );
  }

  /// Display Text Stlye

  static TextStyle textStyle(double? fontSizeForAll) {
    return TextStyle(
      color: bodyTextDark,
      fontSize: fontSizeForAll ?? 12,
      fontWeight: FontWeight.w400,
      fontFamily: "Montserrat",
    );
  }

  static TextStyle textStyleHeader(double? fontSizeForLabel) {
    return TextStyle(
      color: titleColor,
      fontSize: fontSizeForLabel ?? 12,
      fontWeight: FontWeight.w600,
      fontFamily: "Montserrat",
    );
  }

  static TextStyle textStyleHeaderRequired(double? fontSizeForLabel) {
    return TextStyle(
      color: redColor,
      fontSize: fontSizeForLabel ?? 12,
      fontWeight: FontWeight.w600,
      fontFamily: "Montserrat",
    );
  }

  /// Dropdown item Style
  static TextStyle dropDownItemStyle() {
    return TextStyle(color: bodyTextDark, fontSize: 12, fontFamily: 'Montserrat', fontWeight: FontWeight.w400);
  }

  static InputBorder focusedBorderStyle({bool isFieldForTable = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(isFieldForTable ? 0 : 4),
      borderSide: BorderSide(width: 1, color: titleColor),
    );
  }
}
