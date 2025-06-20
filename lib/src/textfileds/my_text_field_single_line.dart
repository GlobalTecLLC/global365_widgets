import 'package:flutter/material.dart';
import 'package:global365_widgets/src/constants/branding.dart';

import '../constants/constants.dart';
import '../theme/text_filled_theme.dart';

class GTextFieldForSingleLine extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? intialValue;
  final String? helpText;
  final Function? validator;
  final Function? onSaved;
  final void Function(String?)? onChange;
  final Function? onEditingComplete;
  final int? maxLine;
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
  final bool isAutoFocus;
  final bool isNumberOnly;
  final bool isZeroPadding;
  final MainAxisAlignment? mainAxisAlignment;
  final bool isFilled;
  final bool isCustomHeight;
  final double? paddingBelowHeading;

  final double? containerHeight;
  final double? containerWidth;
  final double? fontSizeForAll;
  final double? fontSizeForLabel;

  final TextStyle? textStyleOfAll;
  final bool isFieldForTable;
  final void Function()? onTap;

  const GTextFieldForSingleLine({
    super.key,
    this.hintText,
    this.validator,
    this.onSaved,
    this.maxLine = 1,
    this.onChange,
    this.onEditingComplete,
    this.helpText,
    this.isPassword = false,
    this.isEmail = false,
    this.isEnabled = true,
    this.isRequired = false,
    this.isshowHelp = false,
    this.showheading = true,
    this.isFilled = false,
    this.isCustomHeight = false,
    this.labelText,
    this.suffixIcon,
    this.prefixIcon,
    this.intialValue,
    this.controller,
    this.onFieldSubmitted,
    this.onTap,
    this.mainAxisAlignment,
    this.containerColor = Colors.white,
    this.textFieldColor = Colors.white,
    this.isAutoFocus = false,
    this.isWidthForHeader = false,
    this.isNumberOnly = true,
    this.isZeroPadding = false,
    this.containerHeight,
    this.containerWidth,
    this.textStyleOfAll,
    this.fontSizeForAll,
    this.fontSizeForLabel,
    this.isFieldForTable = false,
    this.paddingBelowHeading,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showheading)
          Row(
            children: [
              Text(labelText.toString(), style: GTextFiledTheme.textStyleHeader(fontSizeForLabel)),
              if (isRequired) Text(" *", style: GTextFiledTheme.textStyleHeaderRequired(fontSizeForLabel)),
              if (isshowHelp)
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("help"),
                        content: Text(helpText ?? "No Content Provided by Global365 Admin"),
                        actions: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(padding: const EdgeInsets.all(15.0), child: Text("Ok")),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Icon(Icons.help, size: 15),
                ),
            ],
          ),
        if (paddingBelowHeading != null) SizedBox(height: paddingBelowHeading),
        Container(
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(isFieldForTable ? 0 : Branding.tFborderR),
            border: Border.all(width: isFieldForTable ? 0.5 : 1, color: borderColor),
          ),
          width: containerWidth,
          height: isCustomHeight ? containerHeight : Branding.tFHeight,
          child: Center(
            child: TextFormField(
              controller: controller,
              initialValue: intialValue,
              textDirection: TextDirection.ltr,
              autofocus: isAutoFocus,
              cursorColor: Colors.black,
              enabled: isEnabled,
              style: GTextFiledTheme.textStyle(fontSizeForAll),
              maxLines: maxLine,
              decoration: GTextFiledTheme.inputDecoration(
                fontSizeForAll: fontSizeForAll,
                isFieldForTable: isFieldForTable,
                isZeroPadding: isZeroPadding,
                hintText: hintText ?? "",
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
              ),
              obscureText: isPassword ? true : false,
              validator: validator as String? Function(String?)?,
              onTap: onTap,
              onSaved: onSaved as void Function(String?)?,
              onChanged: onChange,
              onFieldSubmitted: onFieldSubmitted as void Function(String?)?,
              keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
            ),
          ),
        ),
      ],
    );
  }
}
