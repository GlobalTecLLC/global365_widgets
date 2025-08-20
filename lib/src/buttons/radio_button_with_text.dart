import 'package:flutter/material.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/constants/constants.dart';

class RadioButtonWithText extends StatelessWidget {
  const RadioButtonWithText({super.key, required this.groupValue, required this.value, required this.text, this.onChanged});

  final dynamic groupValue;
  final dynamic value;
  final String text;
  final void Function(dynamic)? onChanged;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => onChanged!(value),
      child: Row(
        children: [
          SizedBox(
            height: 10,
            child: Radio(
              splashRadius: 0,
              hoverColor: Colors.transparent,
              activeColor: primaryColor,
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          ),
          GTextHeading6(text, color: groupValue == value ? primaryColor : bodyText),
        ],
      ),
    );
  }
}
