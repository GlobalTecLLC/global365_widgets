import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/functions/functions.dart';
import 'package:global365_widgets/src/textfileds/formaters/phone_number_formater.dart';
import 'package:global365_widgets/src/textfileds/formaters/thousand_separator_formatter_with_dollar.dart';
import 'package:global365_widgets/src/textfileds/formaters/thousand_separator_formattr.dart';
import 'package:global365_widgets/src/theme/dropdown_theme.dart';
import 'package:global365_widgets/src/theme/text_filled_theme.dart';
import 'package:global365_widgets/src/theme/text_widgets/text_variants/label_semi_bold.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

class GNumberTextFormField extends StatefulWidget {
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
  final bool isPercentage;
  final bool isRequired;
  final bool isshowHelp;
  final bool showheading;
  final TextEditingController? controller;
  final Color containerColor;
  final Color? textFieldColor;
  final bool isWidthForHeader;
  final bool isAutoFocus;
  final bool isNumberOnly;
  final bool widthOutComma;
  final bool numberFormat;
  final bool isZeroPadding;
  final double? containerHeight;
  final double? containerWidth;
  final double? fontSizeForAll;
  final double? fontSizeForLabel;
  final bool isFieldForTable;
  final bool isFieldWithInReportWidgetMain;
  final void Function()? onTap;
  final TextAlign textAlign;
  final bool withCurrency;
  final bool allowNegtive;
  final TextDirection? hintTextDirection;
  final FocusNode? focusNode;

  const GNumberTextFormField({
    super.key,
    this.hintText,
    this.validator,
    this.onSaved,
    this.maxLine = 1,
    this.onChange,
    this.hintTextDirection,
    this.onEditingComplete,
    this.helpText,
    this.isPassword = false,
    this.isEmail = false,
    this.numberFormat = false,
    this.isEnabled = true,
    this.isPercentage = false,
    this.isRequired = false,
    this.isshowHelp = false,
    this.showheading = true,
    this.labelText,
    this.suffixIcon,
    this.intialValue,
    this.controller,
    this.onFieldSubmitted,
    this.onTap,
    this.containerHeight,
    this.containerWidth,
    this.containerColor = Colors.white,
    this.textFieldColor,
    this.isAutoFocus = false,
    this.isWidthForHeader = false,
    this.isNumberOnly = true,
    this.widthOutComma = false,
    this.isZeroPadding = false,
    this.fontSizeForAll,
    this.fontSizeForLabel,
    this.isFieldForTable = false,
    this.isFieldWithInReportWidgetMain = false,
    this.textAlign = TextAlign.end,
    this.withCurrency = false,
    this.focusNode,
    this.allowNegtive = false,
  });

  @override
  State<GNumberTextFormField> createState() => _GNumberTextFormFieldState();
}

class _GNumberTextFormFieldState extends State<GNumberTextFormField> {
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    // gLogger("initState is called");
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    // gLogger("dispose is called");
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    textSelected = false;
    if (!_focusNode.hasFocus) {
      if (widget.controller != null && widget.controller!.text.isNotEmpty) {
        if (!widget.widthOutComma) {
          widget.controller!.text = widget.withCurrency
              ? GAmountFunctions.formateAmountFromStringWithCurrency(
                  widget.controller!.text.replaceAll(",", "").replaceAll("\$", ""),
                  keepMinus: true,
                )
              : GAmountFunctions.formateAmountFromString(
                  widget.controller!.text.replaceAll(",", "").replaceAll("\$", ""),
                  keepMinus: true,
                );
        }
      }
    }
  }

  bool textSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showheading)
          Row(
            children: [
              Text(widget.labelText.toString(), style: GTextFiledTheme.textStyleHeader(widget.fontSizeForLabel)),
              if (widget.isRequired)
                Text(" *", style: GTextFiledTheme.textStyleHeaderRequired(widget.fontSizeForLabel)),
              if (widget.isshowHelp)
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Help"),
                        content: Text(widget.helpText ?? "No Content Provided by GLOBAL365 - Books"),
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
        Container(
          decoration: BoxDecoration(
            color: widget.isEnabled ? widget.containerColor : lightBackgroundColor,
            borderRadius: BorderRadius.circular(
              (widget.isFieldWithInReportWidgetMain || widget.isFieldForTable) ? 0 : Branding.tFborderR,
            ),
            border: Border.all(
              width: widget.isFieldWithInReportWidgetMain
                  ? 0
                  : widget.isFieldForTable
                  ? 0.5
                  : 1,
              color: borderColor,
            ),
          ),
          width: widget.containerWidth,
          height: Branding.tFHeight,
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: Material(
                    color: Colors.transparent,
                    child: TextFormField(
                      //focusNode: widget.focusNode,
                      focusNode: _focusNode,
                      onTap: () {
                        if (widget.controller != null) {
                          if (!textSelected) {
                            widget.controller!.selectAll();
                            textSelected = true;
                          }
                        }
                        if (widget.onTap != null) {
                          widget.onTap!();
                        }
                      },
                      controller: widget.controller,
                      initialValue: widget.intialValue,
                      textAlign: widget.textAlign,
                      textDirection: TextDirection.ltr,
                      autofocus: widget.isAutoFocus,
                      style: GTextFiledTheme.textStyle(widget.fontSizeForAll).copyWith(color: widget.textFieldColor),
                      inputFormatters: widget.numberFormat
                          ? <TextInputFormatter>[PhoneNumberFormatter()]
                          : widget.isNumberOnly
                          ? <TextInputFormatter>[
                              (widget.allowNegtive)
                                  ? FilteringTextInputFormatter.deny(RegExp(r'[^\d\.\-]|(?<=[\d\.])-'))
                                  : FilteringTextInputFormatter.deny(RegExp(r'[^\d\.]')),
                              widget.widthOutComma
                                  ? FilteringTextInputFormatter.digitsOnly
                                  : widget.withCurrency
                                  ? ThousandsSeparatorInputFormatterWithCurrency()
                                  : ThousandsSeparatorInputFormatter(),
                            ]
                          : null,
                      enabled: widget.isEnabled,
                      decoration: GTextFiledTheme.inputDecoration(
                        fontSizeForAll: widget.fontSizeForAll,
                        isFieldForTable: widget.isFieldForTable,
                        isZeroPadding: widget.isZeroPadding,
                        hintText: widget.hintText ?? "",
                        suffixIcon: widget.suffixIcon,
                        // hintTextDirection: TextDirection.rtl,
                      ),
                      obscureText: widget.isPassword ? true : false,
                      validator: widget.validator as String? Function(String?)?,
                      onSaved: widget.onSaved as void Function(String?)?,
                      onChanged: widget.onChange as void Function(String?)?,
                      onFieldSubmitted: widget.onFieldSubmitted as void Function(String?)?,
                      keyboardType: widget.isEmail ? TextInputType.emailAddress : TextInputType.text,
                    ),
                  ),
                ),
              ),
              widget.isPercentage ? const GLabelSemiBold("%") : Container(),
              widget.isPercentage ? const Text(" ") : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
