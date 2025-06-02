import 'package:flutter/material.dart';
import 'package:global365_widgets/src/buttons/custom_icon.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/theme/text_widgets/export_textvarients.dart';
import 'package:global365_widgets/src/theme/theme_export.dart';

class GIconTextButton extends StatelessWidget {
  const GIconTextButton({super.key, this.svgPath, this.icon, required this.text, this.onTap, this.subText});
  final String? svgPath;
  final IconData? icon;
  final String text;
  final String? subText;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            GCustomIcon(icon: icon, svgPath: svgPath, iconOnly: true, size: 16, iconColor: bodyTextDark),
            GSizeW(6),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                GBodyText(text),
                if (subText != null) ...[GSizeW(6), Text(subText!, style: GAppStyle.style10w400(color: bodyTextDark))],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
