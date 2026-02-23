import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/buttons/custom_icon.dart';
import 'package:global365_widgets/src/constants/branding.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';

class GCustomMenuButton extends StatelessWidget {
  const GCustomMenuButton({
    super.key,
    required this.listMenus,
    this.onChanged,
    this.selectedValue = "",
    this.isSelectionMenu = false,
    this.isShowIcon = false,
    this.customButton,
    this.height = 30,
    this.btnText,
    this.showBtnIconLeft,
    this.showBtnIconRight,
    this.variant,
    this.isCircleBorder,
    this.btnIcon,
    this.popupWidth,
    this.horizontalWidth = 6,
    this.svgPath,
    this.isDynamic = false,
    this.objValue = "",
    this.hideIfEmpty = false,
    this.objValueID = "",
    this.onMenuStateChange,
  });
  final List listMenus;
  final void Function(dynamic, int?)? onChanged;
  final String selectedValue;
  final bool isSelectionMenu;
  final bool isShowIcon;
  final bool hideIfEmpty;
  final Widget? customButton;
  final double height;
  final double? popupWidth;
  final String? btnText;
  final bool? showBtnIconLeft;
  final bool? showBtnIconRight;
  final bool? isCircleBorder;
  final IconData? btnIcon;
  final String? svgPath;
  final ButtonVariant? variant;
  final bool isDynamic;
  final String objValue;
  final String objValueID;
  final double horizontalWidth;
  final void Function(bool)? onMenuStateChange;

  @override
  Widget build(BuildContext context) {
    ButtonColorPalete colorPalete = ButtonThemeCustom.getTheme(variant);
    return (hideIfEmpty && listMenus.isEmpty)
        ? SizedBox(height: height, width: height)
        : SizedBox(
            height: height,
            child: DropdownButtonHideUnderline(
              child: DropdownButton2(
                onMenuStateChange: onMenuStateChange,
                key: Key('CustomMenuButton${DateTime.now()}$btnText'),
                customButton:
                    customButton ??
                    Container(
                      height: height,
                      padding: EdgeInsets.symmetric(horizontal: horizontalWidth),
                      decoration: ShapeDecoration(
                        color: colorPalete.backgroundColor,
                        shape: (isCircleBorder ?? false)
                            ? CircleBorder(side: BorderSide(width: 1, color: colorPalete.borderColor))
                            : RoundedRectangleBorder(
                                side: BorderSide(width: 1, color: colorPalete.borderColor),
                                borderRadius: BorderRadius.circular(Branding.tFborderR),
                              ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (showBtnIconLeft ?? false)
                            Row(
                              children: [
                                (btnIcon != null)
                                    ? Icon(btnIcon, color: colorPalete.iconColor, size: 12)
                                    : SvgPicture.asset(
                                        svgPath ?? "assets/icons/usa/filter.svg",
                                        width: 12,
                                        height: 12,
                                        colorFilter: ColorFilter.mode(colorPalete.iconColor, BlendMode.srcIn),
                                      ),
                                if (btnText != null) GSizeW(4),
                              ],
                            ),
                          if (btnText != null) GLabelSemiBold(btnText!, color: colorPalete.textColor),
                          if (showBtnIconRight ?? false)
                            Row(
                              children: [
                                if (btnText != null) GSizeW(4),
                                (btnIcon != null)
                                    ? Icon(btnIcon, color: colorPalete.iconColor, size: 12)
                                    : SvgPicture.asset(
                                        svgPath ?? "assets/icons/usa/filter.svg",
                                        width: 12,
                                        height: 12,
                                        colorFilter: ColorFilter.mode(colorPalete.iconColor, BlendMode.srcIn),
                                      ),
                              ],
                            ),
                        ],
                      ),
                    ),
                menuItemStyleData: MenuItemStyleData(
                  customHeights: List<double>.filled(listMenus.length, listMenus.length == 1 ? 30 : 25),
                  padding: const EdgeInsets.all(0),
                ),
                // selectedItemBuilder: (context) {
                //   return listMenus
                //       .map((e) => Container(
                //             child: Text(e),
                //           ))
                //       .toList();
                // },
                value: listMenus.isNotEmpty ? listMenus[0] : null,
                items: listMenus
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: isDynamic
                            ? (e[objValueID] ?? -1) == 0
                                  ? Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                                      margin: EdgeInsets.symmetric(horizontal: 6),
                                      decoration: const BoxDecoration(
                                        color: primaryColor,
                                        border: Border(bottom: BorderSide(color: borderColor, width: 0.7)),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(BootstrapIcons.plus, color: whiteColor),
                                          GSizeW(4),
                                          GBodyText(isDynamic ? e[objValue] : e, color: whiteColor),
                                          // if (isFromTransactionTable)
                                          //   if (controller.checkboxValuesForRightTable[index]) SvgPicture.asset("assets/icons/selectedcheckboxcolor.svg"),
                                          // if (isFromCustomerList)
                                          //   if (controller.checkboxValuesforCustomerList[index]) SvgPicture.asset("assets/icons/selectedcheckboxcolor.svg"),
                                        ],
                                      ),
                                    )
                                  : Container(
                                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                      decoration: const BoxDecoration(
                                        border: Border(bottom: BorderSide(color: borderColor, width: 0.7)),
                                      ),
                                      child: Row(
                                        children: [
                                          if (isSelectionMenu)
                                            Row(
                                              children: [
                                                (isDynamic
                                                        ? (selectedValue == e[objValueID].toString())
                                                        : (selectedValue == e.toString()))
                                                    ? const GCustomIcon(icon: BootstrapIcons.check_circle, iconOnly: true)
                                                    : GSizeW(14),
                                                GSizeW(6),
                                              ],
                                            ),
                                          if (isShowIcon)
                                            Row(
                                              children: [
                                                GCustomIcon(icon: getIcon(e), iconOnly: true, iconColor: primaryColor),
                                                GSizeW(6),
                                              ],
                                            ),
                                          GBodyText(isDynamic ? e[objValue] : e),
                                          // if (isFromTransactionTable)
                                          //   if (controller.checkboxValuesForRightTable[index]) SvgPicture.asset("assets/icons/selectedcheckboxcolor.svg"),
                                          // if (isFromCustomerList)
                                          //   if (controller.checkboxValuesforCustomerList[index]) SvgPicture.asset("assets/icons/selectedcheckboxcolor.svg"),
                                        ],
                                      ),
                                    )
                            : Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                                decoration: const BoxDecoration(
                                  border: Border(bottom: BorderSide(color: borderColor, width: 0.7)),
                                ),
                                child: Row(
                                  children: [
                                    if (isSelectionMenu)
                                      Row(
                                        children: [
                                          (isDynamic
                                                  ? (selectedValue == e[objValueID].toString())
                                                  : (selectedValue == e.toString()))
                                              ? const GCustomIcon(icon: BootstrapIcons.check_circle, iconOnly: true)
                                              : GSizeW(14),
                                          GSizeW(6),
                                        ],
                                      ),
                                    if (isShowIcon)
                                      Row(
                                        children: [
                                          GCustomIcon(icon: getIcon(e), iconOnly: true, iconColor: primaryColor),
                                          GSizeW(6),
                                        ],
                                      ),
                                    GBodyText(isDynamic ? e[objValue] : e),
                                    // if (isFromTransactionTable)
                                    //   if (controller.checkboxValuesForRightTable[index]) SvgPicture.asset("assets/icons/selectedcheckboxcolor.svg"),
                                    // if (isFromCustomerList)
                                    //   if (controller.checkboxValuesforCustomerList[index]) SvgPicture.asset("assets/icons/selectedcheckboxcolor.svg"),
                                  ],
                                ),
                              ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  onChanged!(value, listMenus.indexOf(value));

                  // MenuItems.onChanged(context, value as MenuItem);
                },
                dropdownStyleData: DropdownStyleData(
                  width: popupWidth ?? 150,
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  decoration: BoxDecoration(
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white,
                  ),
                  direction: DropdownDirection.left,
                  elevation: 1,
                  offset: const Offset(0, -2),
                ),
              ),
            ),
          );
  }

  IconData getIcon(e) {
    if (e.toString().toLowerCase().contains("view")) {
      return BootstrapIcons.eye;
    }
    if (e.toString().toLowerCase().contains("edit")) {
      return BootstrapIcons.pencil;
    }
    if (e.toString().toLowerCase().contains("delete")) {
      return BootstrapIcons.trash;
    }
    if (e.toString().toLowerCase().contains("add")) {
      return BootstrapIcons.plus;
    }
    if (e.toString().toLowerCase().contains("email")) {
      return BootstrapIcons.envelope;
    }
    if (e.toString().toLowerCase().contains("print")) {
      return BootstrapIcons.printer;
    }
    if (e.toString().toLowerCase().contains("export")) {
      return BootstrapIcons.download;
    }
    if (e.toString().toLowerCase().contains("download")) {
      return BootstrapIcons.download;
    }
    if (e.toString().toLowerCase().contains("clone")) {
      return BootstrapIcons.copy;
    }
    if (e.toString().toLowerCase().contains("copy")) {
      return BootstrapIcons.copy;
    }
    if (e.toString().toLowerCase().contains("enable")) {
      return BootstrapIcons.toggle_on;
    }
    if (e.toString().toLowerCase().contains("disable")) {
      return BootstrapIcons.toggle_off;
    }
    switch (e) {
      case "All":
        return BootstrapIcons.list_check;
      case "Active":
        return BootstrapIcons.check_circle;
      case "Inactive":
        return BootstrapIcons.x_circle;
      case "Show All":
        return BootstrapIcons.list_check;
      case "Edit":
        return BootstrapIcons.pencil;
      case "Delete":
        return BootstrapIcons.trash;
      case "Email Now":
        return BootstrapIcons.envelope;
      case "Print":
        return BootstrapIcons.printer;
      case "Print Now":
        return BootstrapIcons.printer;
      case "Export":
        return BootstrapIcons.download;
      case "Add":
        return BootstrapIcons.plus;
      case "View":
        return BootstrapIcons.eye;
      case "Void":
        return BootstrapIcons.exclamation_triangle;
      case "Make Void":
        return BootstrapIcons.exclamation_triangle;
      case "Duplicate":
        return BootstrapIcons.files;
      case "Copy":
        return BootstrapIcons.files;
      case "Stop":
        return BootstrapIcons.stop;
      case "Play":
        return BootstrapIcons.play;
      case "Skip":
        return BootstrapIcons.skip_forward;
      case "Next":
        return BootstrapIcons.arrow_right;
      case "Download":
        return BootstrapIcons.download;
      case "Clone":
        return BootstrapIcons.copy;
      case "Disable Account":
        return BootstrapIcons.ban;
      case "Make Recurring":
        return BootstrapIcons.arrow_repeat;
      case "Delete User":
        return BootstrapIcons.trash;
      case "Edit User":
        return BootstrapIcons.pencil;
      case "In-active CoA":
        return BootstrapIcons.slash_circle;
      case "In-active Service":
        return BootstrapIcons.slash_circle;
      case "Delete Service":
        return BootstrapIcons.trash3;
      case "In-active Category":
        return BootstrapIcons.slash_circle;
      case "Delete Category":
        return BootstrapIcons.trash3;
      case "In-active Payment Method":
        return BootstrapIcons.slash_circle;
      case "Delete Payment Method":
        return BootstrapIcons.trash3;
      case "In-active Term":
        return BootstrapIcons.slash_circle;
      case "Delete Term":
        return BootstrapIcons.trash3;
      case "In-active UOM":
        return BootstrapIcons.slash_circle;
      case "Delete UOM":
        return BootstrapIcons.trash3;
      case "Edit Account":
        return BootstrapIcons.pencil;
      case "Make Default":
        return BootstrapIcons.check_circle;
      case "Manage":
        return BootstrapIcons.gear;
      case "Refresh":
        return BootstrapIcons.arrow_clockwise;
      case "Refund":
        return BootstrapIcons.arrow_clockwise;
      case "UnLink":
        return BootstrapIcons.link_45deg;
      case "Use":
        return BootstrapIcons.envelope_check;
      case "Skip Next":
        return BootstrapIcons.skip_forward;
      default:
        return BootstrapIcons.question_circle;
    }
  }
}
