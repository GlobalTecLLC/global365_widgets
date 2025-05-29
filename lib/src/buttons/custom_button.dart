import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../global365_widgets.dart';
import '../constants/branding.dart';
import '../constants/colors.dart';
import '../constants/constants.dart';

// ignore: must_be_immutable
class GCustomButton extends StatelessWidget {
  GCustomButton({
    super.key,
    required this.onTap,
    required this.btnText,
    this.backgroundColor,
    this.textColor,
    this.iconColor,
    this.bColor,
    this.isIcon = false,
    this.isIconLeft = true,
    this.isOnDark = false,
    this.onlyIcon = false,
    this.icon,
    this.svgPath,
    this.extraPadding = false,
    this.extraSmallPaddingVertical = false,
    this.isSaveButton = false,
    this.variant,
    this.hoveredVariant,
    this.isUnderLine = false,
    this.isButtonInHeader = false,
    this.customPadding,
  });
  final Function()? onTap;
  final String btnText;
  Color? backgroundColor;
  Color? textColor;
  Color? iconColor;
  Color? bColor;
  final bool isIcon;
  final bool isIconLeft;
  final bool extraPadding;
  final bool extraSmallPaddingVertical;
  final bool isOnDark;
  final bool onlyIcon;
  final bool isSaveButton;
  final IconData? icon;
  final String? svgPath;
  final ButtonVariant? variant;
  final ButtonVariant? hoveredVariant;
  final bool isUnderLine;
  final bool isButtonInHeader;
  final EdgeInsets? customPadding;

  RxBool isHovered = false.obs;
  @override
  Widget build(BuildContext context) {
    if (variant != null) {
      ButtonColorPalete colorPalete = ButtonThemeCustom.getTheme(variant);
      backgroundColor = colorPalete.backgroundColor;
      textColor = colorPalete.textColor;
      iconColor = colorPalete.iconColor;
      bColor = colorPalete.borderColor;
    }
    return InkWell(
      onTap: onTap,
      onHover: (isHovered) {
        this.isHovered.value = isHovered;
      },
      // mouseCursor: SystemMouseCursors.grab,
      child: Obx(() {
        if (isHovered.value && hoveredVariant != null) {
          ButtonColorPalete colorPalete = ButtonThemeCustom.getTheme(hoveredVariant);
          backgroundColor = colorPalete.backgroundColor;
          textColor = colorPalete.textColor;
          iconColor = colorPalete.iconColor;
          bColor = colorPalete.borderColor;
        } else {
          if (variant != null) {
            ButtonColorPalete colorPalete = ButtonThemeCustom.getTheme(variant);
            backgroundColor = colorPalete.backgroundColor;
            textColor = colorPalete.textColor;
            iconColor = colorPalete.iconColor;
            bColor = colorPalete.borderColor;
          }
        }
        return Container(
          padding:
              customPadding ??
              EdgeInsets.symmetric(horizontal: extraPadding ? 12 : 6, vertical: extraSmallPaddingVertical ? 4 : 5),
          decoration: isSaveButton
              ? BoxDecoration(
                  color: backgroundColor ?? (isOnDark ? Colors.transparent : lightBackgroundColor),
                  border: isButtonInHeader
                      ? Border.all(color: Colors.white.withValues(alpha: 0.25))
                      : Border(right: BorderSide(color: Colors.white.withValues(alpha: 0.25))),
                  // border: Border.all(color: Colors.white.withOpacity(0.5)),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Branding.tFborderR),
                    topLeft: Radius.circular(Branding.tFborderR),
                  ),
                )
              : ShapeDecoration(
                  color: backgroundColor ?? (isOnDark ? Colors.transparent : lightBackgroundColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Branding.tFborderR),
                    side: BorderSide(color: bColor ?? (isOnDark ? whiteColor.withValues(alpha: 0.25) : borderColor)),
                  ),
                ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (isIconLeft)
                  if (icon != null || svgPath != null)
                    (icon != null)
                        ? Icon(icon, color: iconColor ?? (isOnDark ? whiteColor : bodyTextDark), size: 16)
                        : SvgPicture.asset(
                            svgPath ?? "",
                            width: 14,
                            height: 14,
                            colorFilter: ColorFilter.mode(
                              iconColor ?? (isOnDark ? whiteColor : bodyTextDark),
                              BlendMode.srcIn,
                            ),
                          ),
                if (icon != null || svgPath != null)
                  if (isIconLeft && !onlyIcon) SizedBox(width: 4),
                if (!onlyIcon)
                  GLabelSemiBold(
                    isUnderLine: isUnderLine,
                    btnText,
                    color: textColor ?? (isOnDark ? whiteColor : bodyTextDark),
                  ),
                if (icon != null || svgPath != null)
                  if (!isIconLeft) SizedBox(width: 4),
                if (!isIconLeft)
                  if (icon != null || svgPath != null)
                    (icon != null)
                        ? Icon(icon, color: iconColor ?? (isOnDark ? whiteColor : bodyTextDark), size: 16)
                        : SvgPicture.asset(
                            svgPath ?? "",
                            width: 14,
                            height: 14,
                            colorFilter: ColorFilter.mode(
                              iconColor ?? (isOnDark ? whiteColor : bodyTextDark),
                              BlendMode.srcIn,
                            ),
                          ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
