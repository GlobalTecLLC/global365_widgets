import 'package:flutter/widgets.dart';

import '../../app_style.dart';

// import 'package:gcountyusa/theme/text_style.dart';

class GBodyText extends StatelessWidget {
  const GBodyText(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.isSmall = false,
    this.isBorderHide = false,
    this.isBorderHideLeft = false,
    this.isCompleteTextShow = false,
    this.style,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final bool isSmall;
  final bool isBorderHide;
  final bool isBorderHideLeft;
  final bool isCompleteTextShow;
  final TextStyle? style;


  @override
  Widget build(BuildContext context) {
  return Text(
      text,
      maxLines: maxLines,
      overflow: isCompleteTextShow ? TextOverflow.visible : TextOverflow.ellipsis,
      textAlign: textAlign ?? TextAlign.start,
      style: style ?? ( isSmall ? GAppStyle.style10w400(color: color) : GAppStyle.style12w400(color: color)),
    );
  }
}
