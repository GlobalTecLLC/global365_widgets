import 'package:flutter/widgets.dart';
import '../../app_style.dart';

class GTextHeading5 extends StatelessWidget {
  const GTextHeading5(this.text, {super.key, this.color, this.textAlign});

  final String text;
  final Color? color;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      textAlign: textAlign,
      text,
      style: GAppStyle.style14w600(color: color),
    );
  }
}
