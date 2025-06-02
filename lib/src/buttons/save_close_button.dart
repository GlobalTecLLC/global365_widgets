import 'package:flutter/material.dart';
import 'package:global365_widgets/src/buttons/export_buttons.dart';
import 'package:global365_widgets/src/constants/constants.dart';

class GSaveCloseButton extends StatelessWidget {
  const GSaveCloseButton({
    super.key,
    required this.onTap,
    required this.btnText,
    this.isIconShow = false,
    this.isEditIcon = false,
    this.customIcon = false,
    this.myIcon = "",
    this.bgColor,
    this.textColor = primaryColor,
    this.variant,
    this.icon,
    this.horizentlPadding,
    this.verticalPadding,
  });
  final Function()? onTap;
  final String btnText;
  final bool isIconShow;
  final bool isEditIcon;
  final bool customIcon;
  final String myIcon;
  final Color? bgColor;
  final Color? textColor;
  final double? horizentlPadding;
  final double? verticalPadding;
  final ButtonVariant? variant;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return GCustomButton(
      onTap: onTap,
      btnText: btnText,
      backgroundColor: bgColor,
      textColor: textColor,
      variant: variant,
      icon: icon,
      svgPath: isEditIcon
          ? "assets/icons/usa/Iconsediticon.svg"
          : (isIconShow)
          ? "assets/icons/usa/fromtoicon2.svg"
          : null,
    );
  }
}
