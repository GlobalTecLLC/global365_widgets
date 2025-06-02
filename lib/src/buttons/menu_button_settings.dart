import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:global365_widgets/src/buttons/button_theme.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/theme/text_widgets/text_variants/label_semi_bold.dart';

class GCustomMenuButtonSettings extends StatelessWidget {
  const GCustomMenuButtonSettings({
    super.key,
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
    this.popupHeight,
    this.svgPath,
    required this.customWidget,
    required this.customButtonWidget,
    this.addCustomeScrollTheme = false,
  });

  final void Function(dynamic, int?)? onChanged;
  final String selectedValue;
  final bool isSelectionMenu;
  final bool isShowIcon;
  final Widget? customButton;
  final double height;
  final double? popupWidth;
  final double? popupHeight;
  final String? btnText;
  final bool? showBtnIconLeft;
  final bool? showBtnIconRight;
  final bool? isCircleBorder;
  final IconData? btnIcon;
  final String? svgPath;
  final ButtonVariant? variant;
  final Widget customWidget;
  final Widget customButtonWidget;
  final bool addCustomeScrollTheme;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        key: Key('CustomMenuButton${DateTime.now()}$btnText'),
        customButton: customButtonWidget,
        menuItemStyleData: MenuItemStyleData(
          customHeights: List<double>.filled(1, popupHeight ?? 400),
          padding: const EdgeInsets.all(0),
        ),
        // value: listMenus.isNotEmpty ? listMenus[0] : null,
        items: [
          "Settings",
        ].map((e) => DropdownMenuItem(onTap: null, enabled: false, value: e, child: customWidget)).toList(),
        onChanged: (value) {},
        dropdownStyleData: DropdownStyleData(
          width: popupWidth ?? 400,
          padding: const EdgeInsets.only(left: 0, right: 0),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
          ),
          direction: DropdownDirection.left,
          elevation: 1,
          offset: const Offset(0, -2),
          scrollbarTheme: addCustomeScrollTheme
              ? ScrollbarThemeData(
                  thickness: WidgetStateProperty.all(0),
                  radius: const Radius.circular(6),
                  thumbColor: WidgetStateProperty.all(Colors.grey),
                  trackColor: WidgetStateProperty.all(Colors.grey),
                )
              : null,
        ),
      ),
    );
  }

  IconData getIcon(e) {
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
      case "Delete":
        return BootstrapIcons.trash3;
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
        return BootstrapIcons.x_circle;
      case "Duplicate":
        return BootstrapIcons.files;
      case "Copy":
        return BootstrapIcons.files;

      default:
        return BootstrapIcons.envelope_check;
    }
  }
}

class MenuItems {
  static Widget buildItem() {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, index) {
        return Column(
          children: [
            InkWell(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                child: const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [GLabelSemiBold("")]),
              ),
            ),
          ],
        );
      },
    );
  }
}
