import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:intl/intl.dart';

import '../../constants/app_assets.dart';
import '../../constants/branding.dart';
import '../../constants/colors.dart';
import '../../constants/constants.dart';
import '../../theme/dropdown_theme.dart' hide Branding;
import '../../theme/text_filled_theme.dart';
import 'date_formater.dart';
import 'src/web_date_picker.dart';

// ignore: must_be_immutable
class GDateTextFiled extends StatefulWidget {
  GDateTextFiled({
    super.key,
    required this.labelText,
    required this.selectedDate,
    required this.dateController,
    this.focusNode,
    this.containerHeight,
    this.containerWidth,
    this.isShowHeading = true,
    this.isDateChangeAble = true,
    this.fontSizeForAll,
    this.fontSizeForLabel,
    this.onChange,
    this.firstDate,
    this.isRequired = false,
    this.disableBorderRadius = false,
    this.onTap,
  });
  final String labelText;
  final double? containerWidth;
  late DateTime selectedDate;
  final DateTime? firstDate;
  final double? containerHeight;
  final bool isDateChangeAble;
  final Function? onChange;
  final double? fontSizeForAll;
  final double? fontSizeForLabel;
  final FocusNode? focusNode;
  late TextEditingController dateController;
  final bool isShowHeading;
  final bool isRequired;
  final bool disableBorderRadius;
  final void Function()? onTap;

  @override
  State<GDateTextFiled> createState() => _GDateTextFiledState();
}

class _GDateTextFiledState extends State<GDateTextFiled> {
  // late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    // _selectedDate = DateTime.now();
    // _controller = TextEditingController(text: _selectedDate.toString().split(' ')[0]);
  }

  Future<void> _selectDate(BuildContext context, bool flag) async {
    final pickedDate = await showWebDatePicker(
      width: 250,
      context: context,
      initialDate: widget.selectedDate,
      firstDate: widget.firstDate ?? DateTime(1970),
      lastDate: DateTime(2101),
      weekendDaysColor: mainColorPrimaryYellow,
      withoutOkButtons: true,
      //width: 300,
      // withoutActionButtons: true,
      // weekendDaysColor: Colors.red,
      // firstDayOfWeekIndex: 1,
    );
    if (pickedDate != null) {
      setState(() {
        widget.selectedDate = pickedDate.start;
        widget.dateController.text = DateFormat('MM/dd/yyyy').format(widget.selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.isShowHeading)
          Row(
            children: [
              GDropDownTheme.headerText(widget.labelText),
              if (widget.isRequired) Text(" *", style: GTextFiledTheme.textStyleHeaderRequired(12)),
            ],
          ),

        // onTap: () => {widget.isDateChangeAble ? _selectDate(context, false) : null},
        SizedBox(
          width: widget.containerWidth,
          height: widget.containerHeight ?? Branding.tFHeight,
          child: TextField(
            // key: textFieldKey,
            controller: widget.dateController,
            readOnly: false,
            focusNode: widget.focusNode,
            onChanged: widget.onChange as void Function(String?)?,
            onTap: widget.onTap,
            // onTap: ,
            style: TextStyle(
              color: bodyTextDark,
              fontSize: widget.fontSizeForAll ?? 12,
              fontWeight: FontWeight.w400,
              fontFamily: 'Montserrat',
            ),
            enabled: widget.isDateChangeAble,
            keyboardType: TextInputType.text,
            inputFormatters: [DateTextFormatter()],
            decoration: InputDecoration(
              hintText: "MM/DD/YYYY",
              isDense: true,
              constraints: BoxConstraints(minHeight: widget.containerHeight ?? Branding.tFHeight, minWidth: 30),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              disabledBorder: OutlineInputBorder(
                borderRadius: widget.disableBorderRadius
                    ? BorderRadius.circular(0)
                    : BorderRadius.circular(Branding.tFborderR),
                borderSide: BorderSide(width: 1, color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: widget.disableBorderRadius
                    ? BorderRadius.circular(0)
                    : BorderRadius.circular(Branding.tFborderR),
                borderSide: BorderSide(
                  color: borderColor,
                  width: 1,
                  // style: BorderStyle.none,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: widget.disableBorderRadius
                    ? BorderRadius.circular(0)
                    : BorderRadius.circular(Branding.tFborderR),
                borderSide: BorderSide(
                  color: borderColor, // Set the color of the border when focused
                  width: 1,
                ),
              ),
              labelStyle: TextStyle(
                color: titleColor,
                fontSize: widget.fontSizeForLabel ?? 12,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
              floatingLabelStyle: TextStyle(
                color: titleColor,
                fontSize: widget.fontSizeForAll ?? 11,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
              helperStyle: TextStyle(
                color: titleColor,
                fontSize: widget.fontSizeForAll ?? 11,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
              hintStyle: TextStyle(
                color: placeHolderColor,
                fontSize: widget.fontSizeForAll ?? 12,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              fillColor: widget.isDateChangeAble ? Colors.white : lightBackgroundColor,
              suffixIcon: InkWell(
                focusNode: FocusNode(skipTraversal: true),
                onTap: () async {
                  if (widget.isDateChangeAble) {
                    await _selectDate(context, false); // Open the date picker and update the date
                    if (widget.onChange != null) {
                      // Trigger the onChange callback after updating the date
                      widget.onChange!(widget.dateController.text);
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Icon(
                    BootstrapIcons.calendar2,
                    color: widget.isDateChangeAble ? titleColor : placeHolderColor,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
