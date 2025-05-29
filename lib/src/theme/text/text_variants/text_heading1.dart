import 'package:flutter/widgets.dart';
import '../../app_style.dart';
// import 'package:gcountyusa/theme/text_style.dart';

class TextHeading1 extends StatelessWidget {
  const TextHeading1(this.text, {super.key, this.color, this.textAlign});

  final String text;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      text,
      style: AppStyle.style32w600(color: color),
    );
  }
}
