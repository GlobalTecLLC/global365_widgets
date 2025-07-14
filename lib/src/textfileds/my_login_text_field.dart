import 'package:flutter/material.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/constants/branding.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class GLoginEmailField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? intialValue;
  final String? helpText;
  final Function? validator;
  final Function? onSaved;
  final Function? onChange;
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
  final Key? key;
  // final bool isHeightForChecksOnPopUp;

  GLoginEmailField({
    this.hintText,
    this.validator,
    this.onSaved,
    this.maxLine = 1,
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
    this.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showheading)
          Row(
            children: [
              GTextHeading5(labelText.toString()),
              if (isRequired) GTextHeading5(" *", color: Colors.red),
              if (isshowHelp)
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("help"),
                        content: Text(helpText ?? "No Content Provided by GLOBAL365 - Books"),
                        actions: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              child: Text("Ok"),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Icon(Icons.help, size: 15),
                ),
            ],
          ),
    
        if (showheading) GSizeH(4),
        Directionality(
          textDirection: TextDirection.ltr,
          child: SizedBox(
            height: 48,
            child: TextFormField(
              key: key,
              controller: controller,
              initialValue: intialValue,
              maxLines: maxLine,
              enabled: isEnabled,
              cursorColor: Colors.black,
              style: GAppStyle.style14w500(color: bodyTextDark),
              decoration: InputDecoration(
                isDense: true,
                hintText: hintText ?? 'Enter text here',
                hintStyle: TextStyle(
                  color: placeHolderColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  // fontFamily: "Mon",
                ),
                // hintStyle: AppStyle.style14w600(
                //   color: placeHolderColor,
                // ),
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(width: 1, color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(width: 1, color: borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(width: 1, color: borderColor),
                ),
                filled: true,
                hoverColor: Colors.transparent,
                suffixIcon: suffixIcon,
                prefixIcon: prefixIcon,
                prefixIconConstraints: BoxConstraints(maxHeight: 16, maxWidth: 26),
                suffixIconConstraints: BoxConstraints(maxHeight: 16, maxWidth: 26),
                fillColor: isEnabled ? whiteColor : lightBackgroundColor,
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              ),
              obscureText: isPassword ? true : false,
              validator: validator as String? Function(String?)?,
              onSaved: onSaved as void Function(String?)?,
              onChanged: onChange as void Function(String?)?,
              onFieldSubmitted: onFieldSubmitted as void Function(String?)?,
              keyboardType: isEmail
                  ? TextInputType.emailAddress
                  : (maxLine! > 1)
                  ? TextInputType.multiline
                  : TextInputType.text,
            ),
          ),
        ),
      ],
    );
  }
}
