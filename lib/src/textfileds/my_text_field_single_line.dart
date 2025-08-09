import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/constants/branding.dart';
import 'package:global365_widgets/src/constants/constants.dart';


class GTextFieldForSingleLine extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? intialValue;
  final String? helpText;
  final Function? validator;
  final Function? onSaved;
  final Function? onChange;
  final Function? onEditingComplete;
  final int? maxLine;
  final Function? onFieldSubmitted;
  final Widget? suffixIcon;
  final bool isPassword;
  final bool isEmail;
  final bool isEnabled;
  final bool isRed;
  final bool isRequired;
  final bool isshowHelp;
  final bool isShowEdit;

  final bool showheading;
  final TextEditingController? controller;
  final Color containerColor;
  final Color? textFieldColor;
  final bool isWidthForHeader;
  final bool isAutoFocus;
  final bool isNumberOnly;
  final bool isZeroPadding;
  final bool isExtraHeightField;
  final MainAxisAlignment? mainAxisAlignment;
  final bool isFilled;
  final bool isCustomHeight;
  final bool cvvNumber;
  final bool cardNumber;
  final bool cardExpiry;
  final bool isInValid;
  final int? maxLength;

  final double? paddingBelowHeading;
  final FocusNode? focusNode;
  final double? containerHeight;
  final double? containerWidth;
  final double? fontSizeForAll;
  final double? fontSizeForLabel;
  final bool? isDropdownStyle;

  final TextStyle? textStyleOfAll;
  final bool isFieldForTable;
  final void Function()? onTap;
  final void Function()? onTapOfEdit;
  final Key? key1;
  final List<TextInputFormatter>? customInputFormatters;

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
    this.cvvNumber = false,
    this.cardNumber = false,
    this.cardExpiry = false,
    this.isEnabled = true,
    this.isRed = false,
    this.isRequired = false,
    this.isshowHelp = false,
    this.isShowEdit = false,
    this.showheading = true,
    this.isFilled = false,
    this.isInValid = false,
    this.isCustomHeight = false,
    this.isDropdownStyle = false,
    this.labelText,
    this.suffixIcon,
    this.intialValue,
    this.controller,
    this.onFieldSubmitted,
    this.onTap,
    this.onTapOfEdit,
    this.mainAxisAlignment,
    this.containerColor = Colors.white,
    this.textFieldColor,
    this.isAutoFocus = false,
    this.isWidthForHeader = false,
    this.isNumberOnly = true,
    this.isZeroPadding = false,
    this.isExtraHeightField = false,
    this.containerHeight,
    this.containerWidth,
    this.textStyleOfAll,
    this.fontSizeForAll,
    this.fontSizeForLabel,
    this.isFieldForTable = false,
    this.paddingBelowHeading,
    this.focusNode,
    this.maxLength,
    this.key1,
    this.customInputFormatters,
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
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Tooltip(
                    message: helpText ?? "No Content Provided by G365",
                    verticalOffset: 10,
                    // onTap: () {
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) => AlertDialog(
                    //       title: Text(T("pos_Help")),
                    //       content: Text(helpText ?? "No Content Provided by GLOBAL365 - Books"),
                    //       actions: <Widget>[
                    //         InkWell(
                    //           onTap: () {
                    //             Navigator.pop(context);
                    //           },
                    //           child: Padding(
                    //             padding: const EdgeInsets.all(15.0),
                    //             child: Text(T("login_ok")),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   );
                    // },
                    child: Icon(Icons.help, size: 15),
                  ),
                ),
              if (isShowEdit)
                Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Tooltip(
                    message: "Edit",
                    verticalOffset: 10,
                    child: InkWell(onTap: onTapOfEdit, child: Icon(BootstrapIcons.pencil_fill, size: 12)),
                  ),
                )
            ],
          ),
        if (paddingBelowHeading != null) SizedBox(height: paddingBelowHeading),
        Container(
          decoration: BoxDecoration(
            color: isRed ? Colors.red : (isEnabled ? containerColor : lightBackgroundColor),
            borderRadius: BorderRadius.circular(isFieldForTable ? 0 : Branding.tFborderR),
            border: Border.all(width: isFieldForTable ? 0.5 : 1, color: isInValid ? Colors.red : borderColor),
          ),
          width: containerWidth,
          height: isCustomHeight ? containerHeight : Branding.tFHeight,
          child: Center(
            child: Material(
              color: Colors.transparent,
              child: TextFormField(
                key: key1,
                controller: controller,
                focusNode: focusNode,
                initialValue: intialValue,
                textDirection: TextDirection.ltr,
                autofocus: isAutoFocus,
                cursorColor: Colors.black,
                enabled: isEnabled,
                inputFormatters:
                    customInputFormatters ??
                    ((maxLength != null)
                    ? [
                        LengthLimitingTextInputFormatter(maxLength), // Limits the input length to 3
                        FilteringTextInputFormatter.digitsOnly, // Allows only digits
                      ]
                    : cvvNumber
                    ? [
                        LengthLimitingTextInputFormatter(3), // Limits the input length to 3
                        FilteringTextInputFormatter.digitsOnly, // Allows only digits
                      ]
                    : cardNumber
                    ? [
                        FilteringTextInputFormatter.digitsOnly, // Allow only digits
                        CardNumberInputFormatter(), // Apply the custom formatter
                      ]
                    : cardExpiry
                    ? [
                        FilteringTextInputFormatter.digitsOnly, // Allow only digits
                        ExpirationDateInputFormatter(),
                      ]
                        : []),
                style: (isDropdownStyle ?? false)
                    ? const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: bodyTextDark,
                        decorationThickness: 1.5,
                      )
                    : GTextFiledTheme.textStyle(fontSizeForAll).copyWith(color: textFieldColor),
                maxLines: maxLine,
                decoration: GTextFiledTheme.inputDecoration(
                  fontSizeForAll: fontSizeForAll,
                  isFieldForTable: isFieldForTable,
                  isZeroPadding: isZeroPadding,
                  // isExtraHeightField: isExtraHeightField,
                  hintText: hintText ?? "",
                  suffixIcon: suffixIcon,
                  // hintTextDirection
                ),
                obscureText: isPassword ? true : false,
                validator: validator as String? Function(String?)?,
                onTap: onTap,
                onSaved: onSaved as void Function(String?)?,
                onChanged: onChange as void Function(String?)?,
                onFieldSubmitted: onFieldSubmitted as void Function(String?)?,
                keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Custom Input Formatter
class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    int maxLength = 16; // Maximum digits to allow
    String text = newValue.text;

    // If text length exceeds maxLength, retain only maxLength characters
    if (text.length > maxLength) {
      text = text.substring(0, maxLength);
    }

    // Format the text in 1111-1111-1111-1111 pattern
    final StringBuffer newText = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i > 0 && i % 4 == 0) {
        newText.write('-');
      }
      newText.write(text[i]);
    }

    // Create a new TextEditingValue to apply the formatted text
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class ExpirationDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Remove all non-digit characters
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Ensure the length does not exceed 4
    if (newText.length > 4) {
      newText = newText.substring(0, 4);
    }

    // Insert the slash at the appropriate position
    String formattedText = '';
    if (newText.length > 2) {
      formattedText = '${newText.substring(0, 2)}/${newText.substring(2)}';
    } else {
      formattedText = newText;
    }

    // Validate month
    String month = '';
    if (formattedText.length >= 2) {
      month = formattedText.substring(0, 2);
      int monthValue = int.tryParse(month) ?? 0;
      if (monthValue > 12) {
        month = '12'; // Limit month to 12 if it exceeds
        formattedText = '$month${formattedText.length > 2 ? '/${formattedText.substring(3)}' : ''}';
      }
    }

    // Get the current year (last two digits of the year)
    final currentYear = DateTime.now().year % 100;

    // Validate year
    String year = '';
    if (formattedText.length > 3) {
      year = formattedText.substring(3);
      int? yearValue = int.tryParse(year);

      if (year.length == 2) {
        // Check if year is less than the current year
        if (yearValue != null && yearValue < currentYear) {
          year = currentYear.toString(); // Set year to the current year if it's invalid
          formattedText = '${formattedText.substring(0, 3)}$year';
        }
        if (yearValue == 0) {
          year = '01'; // Avoid "00" in the year field
          formattedText = '${formattedText.substring(0, 3)}$year';
        }
      }
    }

    // Return the new text value with updated cursor position
    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
