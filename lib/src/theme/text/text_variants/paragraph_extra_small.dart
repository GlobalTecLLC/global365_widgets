import 'package:flutter/widgets.dart';
import '../../app_style.dart';
// import 'package:gcountyusa/theme/text_style.dart';

class ParagraphExtraSmall extends StatelessWidget {
  const ParagraphExtraSmall(this.text, {super.key, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(text, maxLines: 1, style: AppStyle.style10w400(color: color));
  }
}
