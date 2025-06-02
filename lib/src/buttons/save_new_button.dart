import 'package:flutter/material.dart';
import 'package:global365_widgets/src/buttons/custom_button.dart';

class GSaveNewButton extends StatelessWidget {
  const GSaveNewButton({
    super.key,
    required this.onTap,
    this.text = 'Save & New',
    this.bgColor,
    this.textColor,
    this.leftIcon,
  });
  final Function()? onTap;
  final String text;
  final Color? bgColor;
  final Color? textColor;
  final String? leftIcon;

  @override
  Widget build(BuildContext context) {
    return GCustomButton(
      onTap: onTap,
      btnText: text,
      backgroundColor: bgColor,
      textColor: textColor,
      svgPath: leftIcon,
    );
  }
}
