import 'package:flutter/material.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/theme/dropdown_theme.dart';

class GCustomCheckBox extends StatelessWidget {
  GCustomCheckBox({
    super.key,
    required this.value,
    this.onChanged,
    this.size = 20,
    this.isMarginLeft = false,
    this.isMarginRight = false,
    this.marginRight,
    this.marginLeft,
  });

  final bool value;
  final void Function(bool?)? onChanged;
  final double size;
  final bool isMarginLeft;
  final bool isMarginRight;
  final double? marginRight;
  final double? marginLeft;

  @override
  Widget build(BuildContext context) {
    return onChanged == null
        ? Container(
            height: size,
            width: size,
            margin: EdgeInsets.only(
              left: isMarginLeft ? (marginLeft ?? 8) : 0,
              right: isMarginRight ? (marginRight ?? 8) : 0,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(Branding.tFborderR),
              border: Border.all(color: value ? primaryColor : borderColor, width: 1.2),
            ),
            child: value ? Icon(Icons.check_rounded, color: primaryColor, size: size * 0.8) : null,
          )
        : Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                onChanged!(!value);
              },
              child: Container(
                height: size,
                width: size,
                margin: EdgeInsets.only(left: isMarginLeft ? 8 : 0, right: isMarginRight ? 8 : 0),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(Branding.tFborderR),
                  border: Border.all(color: value ? primaryColor : borderColor, width: 1.2),
                ),
                child: value ? Icon(Icons.check_rounded, color: primaryColor, size: size * 0.8) : null,
              ),
            ),
          );
  }
}
