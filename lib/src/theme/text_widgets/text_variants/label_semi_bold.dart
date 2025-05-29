import 'package:flutter/widgets.dart';
import '../../app_style.dart';
// import 'package:gcountyusa/theme/text_style.dart';

class GLabelSemiBold extends StatelessWidget {
  const GLabelSemiBold(this.text, {super.key, this.color, this.textAlign, this.isUnderLine = false});

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final bool isUnderLine;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: GAppStyle.style12w600(color: color, isUnderLine: isUnderLine),
    );
  }
}
