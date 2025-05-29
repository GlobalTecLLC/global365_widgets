import 'package:flutter/widgets.dart';
import '../../app_style.dart';
// import 'package:gcountyusa/theme/text_style.dart';

class GParagraphExtraSmall extends StatelessWidget {
  const GParagraphExtraSmall(this.text, {super.key, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(text, maxLines: 1, style: GAppStyle.style10w400(color: color));
  }
}
