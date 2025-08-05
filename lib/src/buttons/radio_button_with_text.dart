
import 'package:flutter/material.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/theme/text_widgets/text_variants/paragraph_normal.dart';

class RadioButtonWithText extends StatelessWidget {
  const RadioButtonWithText({
    super.key,
    required this.groupValue,
    required this.value,
    required this.text,
    this.onChanged,
  });

  final dynamic groupValue;
  final dynamic value;
  final String text;
  final void Function(dynamic)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 10,
          child: Radio(activeColor: primaryColor, value: value, groupValue: groupValue, onChanged: onChanged),
        ),
        GParagraphNormal(text, color: groupValue == value ? primaryColor : bodyText),
      ],
    );
  }
}
