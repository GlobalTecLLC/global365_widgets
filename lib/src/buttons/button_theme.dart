import 'package:flutter/material.dart';
import 'package:global365_widgets/src/constants/colors.dart';

import '../constants/constants.dart';

enum ButtonVariant {
  outlineWhite,
  outlineWhite25,
  outlineBodyText,
  outlineBorderColor,
  outlineBodyTextDark,
  outlinePrimary,
  outlineSecondary,
  outlineTitleColorWithBorder,

  emptyUnderLineWithSecondary,

  filledWhite,
  filledBodyText,
  filledBodyTextDark,
  filledPrimary,
  filledSecondary,

  filledWhiteWithPrimary,
  filledWhiteWithSecondary,
  filledPrimaryWithBodyText,
  filledPrimaryWithWhiteBodyText,

  filledPrimaryWithBodyTextDark,

  filledOrangeWithPrimaryColorIconAndText,
}

class ButtonThemeCustom {
  static ButtonColorPalete getTheme(ButtonVariant? variant) {
    switch (variant) {
      case ButtonVariant.outlineWhite:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: whiteColor,
          borderColor: whiteColor,
          iconColor: whiteColor,
        );
      case ButtonVariant.outlineWhite25:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: whiteColor,
          borderColor: whiteColor.withOpacity(0.25),
          iconColor: whiteColor,
        );
      case ButtonVariant.outlineBodyText:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: bodyText,
          borderColor: bodyText,
          iconColor: bodyText,
        );
      case ButtonVariant.outlineBorderColor:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: borderColor,
          borderColor: borderColor,
          iconColor: borderColor,
        );
      case ButtonVariant.outlineBodyTextDark:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: bodyTextDark,
          borderColor: bodyTextDark,
          iconColor: bodyTextDark,
        );
      case ButtonVariant.outlinePrimary:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: primaryColor,
          borderColor: primaryColor,
          iconColor: primaryColor,
        );
      case ButtonVariant.outlineTitleColorWithBorder:
        return ButtonColorPalete(
          backgroundColor: lightBackgroundColor,
          textColor: titleColor,
          borderColor: borderColor,
          iconColor: titleColor,
        );
      case ButtonVariant.outlineSecondary:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: secondaryColorOrange,
          borderColor: secondaryColorOrange,
          iconColor: secondaryColorOrange,
        );
      case ButtonVariant.filledWhite:
        return ButtonColorPalete(
          backgroundColor: whiteColor,
          textColor: Colors.black,
          borderColor: whiteColor,
          iconColor: Colors.black,
        );
      case ButtonVariant.filledBodyText:
        return ButtonColorPalete(
          backgroundColor: bodyText,
          textColor: whiteColor,
          borderColor: bodyText,
          iconColor: whiteColor,
        );
      case ButtonVariant.filledBodyTextDark:
        return ButtonColorPalete(
          backgroundColor: bodyTextDark,
          textColor: whiteColor,
          borderColor: bodyTextDark,
          iconColor: whiteColor,
        );
      case ButtonVariant.filledPrimary:
        return ButtonColorPalete(
          backgroundColor: primaryColor,
          textColor: whiteColor,
          borderColor: primaryColor,
          iconColor: whiteColor,
        );
      case ButtonVariant.filledSecondary:
        return ButtonColorPalete(
          backgroundColor: secondaryColorOrange,
          textColor: whiteColor,
          borderColor: secondaryColorOrange,
          iconColor: whiteColor,
        );
      case ButtonVariant.filledWhiteWithPrimary:
        return ButtonColorPalete(
          backgroundColor: whiteColor,
          textColor: primaryColor,
          borderColor: whiteColor,
          iconColor: primaryColor,
        );
      case ButtonVariant.filledWhiteWithSecondary:
        return ButtonColorPalete(
          backgroundColor: whiteColor,
          textColor: secondaryColorOrange,
          borderColor: whiteColor,
          iconColor: secondaryColorOrange,
        );
      case ButtonVariant.filledPrimaryWithBodyText:
        return ButtonColorPalete(
          backgroundColor: primaryColor,
          textColor: bodyText,
          borderColor: primaryColor,
          iconColor: bodyText,
        );
      case ButtonVariant.filledPrimaryWithBodyTextDark:
        return ButtonColorPalete(
          backgroundColor: primaryColor,
          textColor: bodyTextDark,
          borderColor: primaryColor,
          iconColor: bodyTextDark,
        );
      case ButtonVariant.filledPrimaryWithWhiteBodyText:
        return ButtonColorPalete(
          backgroundColor: primaryColor,
          textColor: whiteColor,
          borderColor: primaryColor,
          iconColor: whiteColor,
        );
      case ButtonVariant.filledOrangeWithPrimaryColorIconAndText:
        return ButtonColorPalete(
          backgroundColor: secondaryColorOrange,
          textColor: primaryColor,
          borderColor: secondaryColorOrange,
          iconColor: primaryColor,
        );
      case ButtonVariant.emptyUnderLineWithSecondary:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: secondaryColorOrange,
          borderColor: Colors.transparent,
          iconColor: secondaryColorOrange,
        );

      default:
        return ButtonColorPalete(
          backgroundColor: Colors.transparent,
          textColor: whiteColor,
          borderColor: whiteColor,
          iconColor: whiteColor,
        );
    }
  }
}

class ButtonColorPalete {
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final Color iconColor;

  ButtonColorPalete({
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.iconColor,
  });
}
