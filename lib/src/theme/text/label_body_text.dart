import 'package:flutter/material.dart';
import '../../constants/constants.dart';
import 'text_variants/label_semi_bold.dart';

import 'text_variants/body_text.dart';

class LabelBodyText extends StatelessWidget {
  const LabelBodyText(this.label, this.text, {super.key, this.icon});
  final String label;
  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) Icon(icon!, size: 16, color: titleColor),
        if (icon != null) SizedBox(width: 4),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [LabelSemiBold(label), BodyText(text)]),
      ],
    );
  }
}
