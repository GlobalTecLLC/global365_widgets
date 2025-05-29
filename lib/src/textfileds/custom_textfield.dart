import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/colors.dart';
import '../constants/constants.dart';
import 'decimal_text_input_formater.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';

class GTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? intialValue;
  final String? helpText;
  final Function? validator;
  final Function? onSaved;
  final Function? onChange;
  final int? maxLine;
  final Function? onFieldSubmitted;
  final IconButton? suffixIcon;
  final bool isPassword;
  final bool isEmail;
  final bool isEnabled;
  final bool isRequired;
  final bool isshowHelp;
  final bool showheading;
  final bool? isNumberOnly;
  final int? maxCharacters;
  final bool? wordsLimit;
  final TextEditingController? controller;
  final EdgeInsets? contentPadding;

  GTextFormField({
    super.key,
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
    this.intialValue,
    this.controller,
    this.onFieldSubmitted,
    this.contentPadding,
    this.isNumberOnly,
    this.maxCharacters = 200,
    this.wordsLimit = false,
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
              Text(
                labelText.toString(),
                style: TextStyle(
                  color: fontColorusedLikeBlack,
                  fontSize: 12,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (isRequired)
                Text(
                  " *",
                  style: TextStyle(
                    color: redColor,
                    fontSize: 11,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                ),
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
                  child: const Icon(Icons.help, size: 15),
                ),
            ],
          ),
        TextFormField(
          textDirection: TextDirection.ltr,
          controller: controller,
          initialValue: intialValue,
          maxLines: maxLine,
          enabled: isEnabled,
          style: TextStyle(color: hintTextColor, fontSize: 12, fontFamily: 'Montserrat', fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintTextColor,
              fontSize: 12,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w400,
            ),
            isDense: true,
            contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(width: 1, color: dashBoardHeaderbg),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(width: 1, color: dashBoardHeaderbg),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: BorderSide(width: 1, color: dashBoardHeaderbg),
            ),
            filled: true,
            suffixIcon: suffixIcon,
            fillColor: whiteColor,
          ),
          obscureText: isPassword ? true : false,
          validator: validator as String? Function(String?)?,
          onSaved: onSaved as void Function(String?)?,
          onChanged: onChange as void Function(String?)?,
          onFieldSubmitted: onFieldSubmitted as void Function(String?)?,
          inputFormatters: (isNumberOnly ?? false)
              ? <TextInputFormatter>[
                  DecimalTextInputFormatter(), // Filters out non-digit input
                ]
              : (wordsLimit ?? false)
              ? <TextInputFormatter>[LengthLimitingTextInputFormatter(maxCharacters!)]
              : null,
          keyboardType: (isNumberOnly ?? false)
              ? const TextInputType.numberWithOptions(decimal: true)
              : isEmail
              ? TextInputType.emailAddress
              : (maxLine! > 1)
              ? TextInputType.multiline
              : TextInputType.text,
        ),
        // ),
      ],
    );
  }
}
