import 'package:flutter/widgets.dart';
import '../../app_style.dart';
// import 'package:gcountyusa/theme/text_style.dart';

class StatsLabel extends StatelessWidget {
  const StatsLabel(this.text, {super.key, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppStyle.style11w700(color: color));
  }
}
