import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global365_widgets/src/constants/constants.dart';

import '../constants/branding.dart';
import '../theme/text_filled_theme.dart';


class GTextFormFieldForMultipleLine extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? intialValue;
  final String? helpText;
  final Function? validator;
  final Function? onSaved;
  final Function? onChange;
  final Function? onFieldSubmitted;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool isPassword;
  final bool isEmail;
  final bool isEnabled;
  final bool isRequired;
  final bool isshowHelp;
  final bool showheading;
  final TextEditingController? controller;
  final Color containerColor;
  final Color textFieldColor;
  final bool isWidthForHeader;
  final double? containerHeight;
  final double? containerWidth;
  final double? fontSizeForAll;
  final double? fontSizeForLabel;
  final int? maxCharacters;
  final bool? wordsLimit;
  // final bool isHeightForChecksOnPopUp;

  GTextFormFieldForMultipleLine({
    this.hintText,
    this.validator,
    this.onSaved,
    this.onChange,
    this.helpText,
    this.isPassword = false,
    this.isEmail = false,
    this.isEnabled = true,
    this.isRequired = false,
    this.isshowHelp = false,
    this.showheading = true,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.intialValue,
    this.controller,
    this.onFieldSubmitted,
    this.containerColor = Colors.white,
    this.textFieldColor = Colors.white,
    this.isWidthForHeader = false,
    this.containerHeight,
    this.containerWidth,
    this.fontSizeForAll,
    this.fontSizeForLabel,
     this.maxCharacters = 200, 
    this.wordsLimit = false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showheading)
          Row(
            children: [
              Text(
                labelText.toString(),
                style: GTextFiledTheme.textStyleHeader(fontSizeForLabel),
              ),
              if (isRequired)
                Text(
                  " *",
                  style:
                      GTextFiledTheme.textStyleHeaderRequired(fontSizeForLabel),
                ),
              if (isshowHelp)
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Help"),
                        content:
                            Text(helpText ?? "No Content Provided by Global365 Admin"),
                        actions: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("Ok"),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Icon(
                    Icons.help,
                    size: 15,
                  ),
                )
            ],
          ),

        Container(
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(Branding.tFborderR),
            border: Border.all(width: 1, color: borderColor),
          ),
          width: containerWidth,
          height: containerHeight ?? Branding.tFHeight,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: TextFormField(
                controller: controller,
                initialValue: intialValue,
                style: GTextFiledTheme.textStyle(fontSizeForAll),

                // scrollPadding: EdgeInsets.all(0),
                maxLines: 50,
                enabled: isEnabled,
                cursorColor: Colors.black,
                decoration: GTextFiledTheme.inputDecoration(
                    fontSizeForAll: fontSizeForAll,
                    isFieldForTable: false,
                    isZeroPadding: false,
                    hintText: hintText ?? "",
                    suffixIcon: suffixIcon,
                    prefixIcon: prefixIcon),
                obscureText: isPassword ? true : false,
                validator: validator as String? Function(String?)?,
                onSaved: onSaved as void Function(String?)?,
                onChanged: onChange as void Function(String?)?,
                onFieldSubmitted: onFieldSubmitted as void Function(String?)?,
                inputFormatters: [
                  if (wordsLimit!)
                    LengthLimitingTextInputFormatter(maxCharacters!)
                ],
                keyboardType: isEmail
                    ? TextInputType.emailAddress
                    : TextInputType.multiline),
          ),
        ),
        // SizedBox(
        //   height: 10,
        // ),
        // Container(
        //   decoration: ShapeDecoration(
        //     color: Colors.white,
        //     shape: RoundedRectangleBorder(
        //       side: BorderSide(width: 1, color: dashSecondHeaderPrimaryColor),
        //       borderRadius: BorderRadius.circular(5),
        //     ),
        //   ),
        //   height: maxLine == 10
        //       ? 150
        //       : maxLine == 4
        //           ? 100
        //           : 48,
        //   child: Directionality(
        //     textDirection: TextDirection.ltr,
        //     child: TextFormField(
        //       controller: controller,
        //       initialValue: intialValue,
        //       // scrollPadding: EdgeInsets.all(0),
        //       maxLines: maxLine,
        //       enabled: isEnabled,

        //       decoration: InputDecoration(
        //         //  hintText: 'Enter text here',
        //         hintStyle: TextStyle(color: bodyTextColor),
        //         // contentPadding: EdgeInsets.symmetric(
        //         //     vertical: 10), // Adjust padding as needed
        //         // Center-align the text
        //         alignLabelWithHint: true,

        //         border: InputBorder.none,

        //         hintText: hintText,
        //         contentPadding: EdgeInsets.all(10.0),

        //         // border: OutlineInputBorder(
        //         //   borderRadius: BorderRadius.circular(4),
        //         //   borderSide: BorderSide(
        //         //     width: 0.3,
        //         //     style: BorderStyle.none,
        //         //   ),
        //         // ),
        //         // labelText: labelText,
        //         filled: true,
        //         suffixIcon: this.suffixIcon,
        //         fillColor: Colors.white,
        //       ),
        //       obscureText: isPassword ? true : false,
        //       validator: validator as String? Function(String?)?,
        //       onSaved: onSaved as void Function(String?)?,
        //       onChanged: onChange as void Function(String?)?,

        //       onFieldSubmitted: onFieldSubmitted as void Function(String?)?,
        //       keyboardType: isEmail
        //           ? TextInputType.emailAddress
        //           : (maxLine! > 1)
        //               ? TextInputType.multiline
        //               : TextInputType.text,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
