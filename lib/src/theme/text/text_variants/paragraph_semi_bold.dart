import 'package:flutter/widgets.dart';
import '../../app_style.dart';
// import 'package:gcountyusa/theme/text_style.dart';

class ParagraphSemiBold extends StatelessWidget {
  const ParagraphSemiBold(this.text, {super.key, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppStyle.style11w600(color: color));
  }
}
