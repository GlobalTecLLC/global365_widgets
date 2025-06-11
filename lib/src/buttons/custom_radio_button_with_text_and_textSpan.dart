import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:global365_widgets/src/constants/app_assets.dart';

class GCustomRadioButtonWithTextAndTextSpan extends StatelessWidget {
  final int groupValue;
  final int radioValue;
  final void Function()? onTap;
  final TextSpan textSpan;

  const GCustomRadioButtonWithTextAndTextSpan({
    Key? key,
    required this.groupValue,
    required this.radioValue,
    this.onTap,
    required this.textSpan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            SvgPicture.asset(
              groupValue == radioValue ? AppAssets.radioOnIcon : AppAssets.radioOffIcon,
              height: 16,
              width: 16,
            ),
            SizedBox(width: 10),
            RichText(text: textSpan),
            SizedBox(width: 15),
          ],
        ),
      ),
    );
  }
}
