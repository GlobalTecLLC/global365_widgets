import 'package:flutter/widgets.dart';

import '../../app_style.dart';

// import 'package:gcountyusa/theme/text_style.dart';

class GBodyText extends StatelessWidget {
  const GBodyText(this.text, {super.key, this.color, this.textAlign});

  final String text;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: GAppStyle.style12w400(color: color));
  }
}
