import 'package:flutter/widgets.dart';
import '../../app_style.dart';

class TextHeading6 extends StatelessWidget {
  const TextHeading6(this.text, {super.key, this.color, this.textAlign});

  final String text;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      text,
      style: AppStyle.style12w600(color: color),
    );
  }
}
