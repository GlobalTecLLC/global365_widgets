import 'package:flutter/widgets.dart';

import '../../app_style.dart';

// import 'package:gcountyusa/theme/text_style.dart';

class BodyText extends StatelessWidget {
  const BodyText(this.text, {super.key, this.color, this.textAlign});

  final String text;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppStyle.style12w400(color: color));
  }
}
