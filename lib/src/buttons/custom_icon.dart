import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';

class GCustomIcon extends StatelessWidget {
  const GCustomIcon({
    super.key,
    this.size = 14,
    this.svgPath,
    this.icon,
    this.onTap,
    this.isFilled = false,
    this.padding,
    this.iconColor,
    this.isOnDark = false,
    this.iconOnly = false,
  });
  final double size;
  final String? svgPath;
  final IconData? icon;
  final void Function()? onTap;
  final bool isFilled;
  final bool isOnDark;
  final bool iconOnly;
  final Color? iconColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: size,
        width: size,
        padding: iconOnly
            ? EdgeInsets.zero
            : (padding ?? ((svgPath == null) ? EdgeInsets.zero : EdgeInsets.all((size / 4.66666666667)))),
        decoration: iconOnly
            ? null
            : BoxDecoration(
                color: isFilled ? (isOnDark ? borderColor : primaryColor) : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                  color: isOnDark ? Colors.white.withValues(alpha: 0.25) : primaryColor,
                  width: size / 28,
                ),
              ),
        child: svgPath != null
            ? SvgPicture.asset(
                svgPath ?? "assets/icons/edit.svg",
                colorFilter: ColorFilter.mode(
                  iconColor ??
                      (isFilled ? (isOnDark ? borderColor : whiteColor) : (isOnDark ? borderColor : primaryColor)),
                  BlendMode.srcIn,
                ),
              )
            : Icon(
                icon,
                color:
                    iconColor ??
                    (isFilled ? (isOnDark ? borderColor : whiteColor) : (isOnDark ? borderColor : primaryColor)),
                size: iconOnly ? size : (size - ((size / 4.66666666667) * 2)),
              ),
      ),
    );
  }
}
