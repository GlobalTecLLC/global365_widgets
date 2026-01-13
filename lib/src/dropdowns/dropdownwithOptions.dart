import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:global365_widgets/src/buttons/check_box_custom.dart';
import 'package:global365_widgets/src/buttons/custom_icon.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/constants/globals.dart';
import 'package:global365_widgets/src/theme/text_widgets/export_textvarients.dart';
import 'package:global365_widgets/src/utils/export_utils.dart';

class GCustomDropdownButton extends StatelessWidget {
  String title;
  String buttonText;
  bool isPay;
  bool isRecord;
  bool isFromCustomField;
  bool isFromContactAndAddress;
  bool isFromBankCard;
  bool isFromCreditCrad;
  bool buttonWithTextIcon;
  var fileController;
  bool isSrNumberDropdown;
  bool isSettingDropdown;
  bool isDahboardDropdown;
  bool isSettingDropdownForCOntactPopUp;
  bool isSaveDropdown;
  bool isMemberDropdown;
  bool isSaveAndClose;
  bool isSettingForTableListing;
  bool extraPadding;
  bool isonDark;
  double? size;
  int loopStartValue;

  void Function()? onTap;
  final bool isButtonInHeader;
  GCustomDropdownButton({
    super.key,
    this.title = "",
    this.isMemberDropdown = false,
    this.buttonText = "Save",
    this.isPay = false,
    this.isRecord = false,
    this.isFromCustomField = false,
    this.isFromContactAndAddress = false,
    this.isFromBankCard = false,
    this.isFromCreditCrad = false,
    this.loopStartValue = 0,
    this.buttonWithTextIcon = false,
    this.extraPadding = false,
    this.isSaveAndClose = false,
    this.isonDark = false,
    this.size,
    this.isSettingForTableListing = false,

    required this.fileController,
    required this.isSrNumberDropdown,
    required this.isSettingDropdown,
    this.isDahboardDropdown = false,
    this.isSettingDropdownForCOntactPopUp = false,
    required this.isSaveDropdown,
    this.onTap,
    this.isButtonInHeader = false,
  });

  @override
  Widget build(BuildContext context) {
    // gLogger("isSaveDropdown $isSaveDropdown and isSetting $isSettingDropdown");
    // gLogger(
    //     "copyListHeaderEntries in the custom drop down is ${copyListHeaderEntries[0].isAscendingSortingShow} and ${copyListHeaderEntries[0].isDescendingSortingShow}");
    // gLogger("isSaveAndClose ====>$isSaveAndClose");
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: Container(
          child: buttonWithTextIcon
              ? Container(
                  decoration: ShapeDecoration(
                    color: primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: extraPadding ? 12 : 6, vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GLabelSemiBold(buttonText, color: whiteColor),
                        Icon(Icons.keyboard_arrow_down_rounded, color: whiteColor, size: 16),
                      ],
                    ),
                  ),
                )
              : (isSaveDropdown ||
                    isRecord ||
                    isPay ||
                    isFromBankCard ||
                    isFromCreditCrad ||
                    isFromCustomField ||
                    isFromContactAndAddress)
              ? Container(
                  decoration: BoxDecoration(
                    border: isButtonInHeader
                        ? Border(
                            right: BorderSide(color: Colors.white.withOpacity(0.25)),
                            top: BorderSide(color: Colors.white.withOpacity(0.25)),
                            bottom: BorderSide(color: Colors.white.withOpacity(0.25)),
                          )
                        : Border(right: BorderSide(color: Colors.white.withOpacity(0.25))),
                    color: primaryColor,
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(4), topRight: Radius.circular(4)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [Icon(Icons.keyboard_arrow_down_rounded, color: whiteColor, size: 16)],
                    ),
                  ),
                )
              : GCustomIcon(
                  svgPath: 'assets/icons/row_setting.svg',
                  size: size ?? 25,
                  padding: const EdgeInsets.all(5),
                  isOnDark: isonDark,
                ),
        ),
        menuItemStyleData: MenuItemStyleData(
          customHeights: [
            ...List<double>.filled(
              isSaveDropdown
                  ? MenuItemsForDropdownButton.firstItemsforRecords.length
                  : MenuItemsForDropdownButton.firstItemsSetting.length,
              isSaveDropdown ? dropDownValuesforSave.length * 29 : dropDownValuesforSave.length * 29,
            ),
            0,
            ...List<double>.filled(MenuItemsForDropdownButton.secondItems.length, 48),
          ],
          height: 48,
          padding: const EdgeInsets.all(0),
        ),
        items: [
          ...MenuItemsForDropdownButton.firstItemsforRecords.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItemsForDropdownButton.buildItem(
                context,
                item,
                isSrNumberDropdown,
                isSettingDropdown,
                isSaveDropdown,
                fileController,
                isFromSettingforContactPopUp: isSettingDropdownForCOntactPopUp,
                isPay: isPay,
                isRecord: isRecord,
                isFromBankCard: isFromBankCard,
                isFromCreditCard: isFromCreditCrad,
                isFromCustomField: isFromCustomField,
                isFromContactAndAddress: isFromContactAndAddress,
                isSettingForTableListing: isSettingForTableListing,

                loopStartValue: loopStartValue,
                isDahboardDropdown: isDahboardDropdown,
                isSaveAndClose: isSaveAndClose,
                onTap: onTap,
              ),
            ),
          ),
          const DropdownMenuItem<Divider>(enabled: false, child: Divider(thickness: 0)),
          ...MenuItemsForDropdownButton.secondItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItemsForDropdownButton.buildItem(
                context,
                item,
                isSrNumberDropdown,
                isSettingDropdown,
                isSaveDropdown,
                fileController,
                isFromSettingforContactPopUp: isSettingDropdownForCOntactPopUp,
                isPay: isPay,
                isRecord: isRecord,
                isSaveAndClose: isSaveAndClose,
                isSettingForTableListing: isSettingForTableListing,

                loopStartValue: loopStartValue,
                isMemberDropdown: isMemberDropdown,
                isDahboardDropdown: isDahboardDropdown,
              ),
            ),
          ),
        ],
        onChanged: (value) {
          MenuItemsForDropdownButton.onChanged(context, value as MenuItem);
        },
        dropdownStyleData: DropdownStyleData(
          width: (isSaveDropdown || isRecord || isPay || isFromBankCard || isFromCreditCrad) ? 125 : 220,
          padding: EdgeInsets.only(left: 0, right: 0, top: (isSrNumberDropdown ? 0 : 5)),
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(6),
            color: Colors.white,
          ),
          elevation: 1,
          direction: DropdownDirection.left,
          offset: const Offset(0, -4),
        ),
      ),
    );
  }
}

class MenuItem {
  final String text;

  const MenuItem({required this.text});
}

class MenuItemsForDropdownButton {
  static const List<MenuItem> firstItemsSetting = [firstItemsforSetting]; // setting
  static const List<MenuItem> firstItemsforRecords = [isFromSave];

  static const List<MenuItem> secondItems = [];
  static const isFromSave = MenuItem(text: 'Settings');
  static const firstItemsforSetting = MenuItem(text: 'Settings');

  static const logout = MenuItem(text: 'Log Out');

  static Widget buildItem(
    BuildContext context,
    MenuItem item,
    bool isSrNumberDropdown,
    bool isFromSetting,
    bool isFromSave,
    var controller, {
    bool isFromSettingforContactPopUp = false,
    bool isPay = false,
    bool isRecord = false,
    bool isSaveAndClose = false,
    bool isFromBankCard = false,
    bool isFromCustomField = false,
    bool isFromContactAndAddress = false,
    bool isFromCreditCard = false,
    bool isSettingForTableListing = false,
    bool isMemberDropdown = false,
    bool isDahboardDropdown = false,
    List copyListHeaderEntries = const [],
    void Function()? onTap,
    loopStartValue = 0,
  }) {
    // gLogger("isFromSave $isFromSave");
    // gLogger("Print in build item $isSrNumberDropdown  $isFromSetting  and $isFromSave $isSaveAndClose  and item is ${item.text} ");
    // gLogger("isPay $isPay");
    // gLogger("isSettingTable $isSettingForTableListing");

    return Column(
      children: [
        if (isSettingForTableListing || isFromSetting)
          Container(
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: lightBackgroundColor,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [GParagraphExtraSmall("Select columns to be shown")],
            ),
          ),
        if (isDahboardDropdown)
          Container(
            height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: lightBackgroundColor,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [GParagraphExtraSmall("Select section to be shown")],
            ),
          ),
        Expanded(
          child: Obx(() {
            return ListView.builder(
              itemCount: isSaveAndClose
                  ? dropDownValuesforSaveAndClose.length
                  : isRecord
                  ? controller.dropDownValuesforRecord.length
                  : isFromContactAndAddress
                  ? controller.dropDownValuesforSave.length
                  : isFromCustomField
                  ? controller.dropDownValuesforSave.length
                  : isFromBankCard
                  ? controller.dropDownValuesforSave.length
                  : isFromCreditCard
                  ? controller.dropDownValuesforSave.length
                  : isMemberDropdown
                  ? controller.dropDownValuesforMemebers.length
                  : isPay
                  ? controller.dropDownValuesforPay.length
                  : isFromSettingforContactPopUp
                  ? controller.dropDownValuesforSettingforContactPopup.length
                  : isDahboardDropdown
                  ? controller.listOfWidgetsMain.length
                  : isFromSetting
                  ? controller.dropDownValuesforSetting.length
                  : isSettingForTableListing
                  ? controller
                        .dropDownValues
                        .length // tabe listing page values
                  : dropDownValuesforSave.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Obx(
                        () => InkWell(
                          onTap: () async {
                            // gLogger("print list checkbox value ${controller.dropDownValuesforSetting}");
                            // gLogger("controller.dropDownValuesforSetting ${controller.dropDownValuesforSetting}");
                            if (isFromSave) {
                              controller.checkboxValuesforSave[index] = !controller.checkboxValuesforSave[index];
                              if (dropDownValuesforSave[index] == "Save & New") {
                                // await // context.router.pop();
                                if (onTap != null) {
                                  // GNav.popNav(context);
                                  // await Future.delayed(const Duration(milliseconds: 50));
                                  onTap();
                                } else {
                                  await controller.postData(context, true);
                                }
                              }
                              if (dropDownValuesforSave[index] == "Save & Close") {
                                await controller.postData(context, false);
                              }
                            } else if (isPay) {
                              // controller.checkboxValuesforPay[index] = !controller.checkboxValuesforPay[index];
                              if (controller.dropDownValuesforPay[index] == "Pay and New") {
                                await controller.postData(context, true, true);
                              }
                              if (controller.dropDownValuesforPay[index] == "Pay and Close") {
                                await controller.postData(context, true, false);
                              }
                            } else {
                              // controller.checkboxValuesforRecord[index] = !controller.checkboxValuesforRecord[index];
                              if (controller.dropDownValuesforRecord[index] == "Record and New") {
                                await controller.postData(context, false, true);
                              }
                              if (controller.dropDownValuesforRecord[index] == "Record and Close") {
                                await controller.postData(context, false, false);
                              }
                            }
                            if (!(isFromSetting ||
                                isDahboardDropdown ||
                                isSettingForTableListing ||
                                isFromSettingforContactPopUp ||
                                isMemberDropdown))
                              Navigator.pop(context);
                          },
                          child: Container(
                            height: 28,
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignmen,
                              children: [
                                if (isSettingForTableListing)
                                  if (controller.checkboxValues[index]) Text("", style: TextStyle(fontSize: 0)),
                                if (isMemberDropdown)
                                  if (controller.checkboxValuesforMembers[index]) Text("", style: TextStyle(fontSize: 0)),
                                if (isFromSetting)
                                  if (controller.checkboxValuesforSettng[index]) Text("", style: TextStyle(fontSize: 0)),
                                // SvgPicture.asset(
                                //     "assets/icons/selectedcheckboxcolor.svg"),
                                if (isFromSave ||
                                    isPay ||
                                    isRecord ||
                                    isFromBankCard ||
                                    isFromCreditCard ||
                                    isFromCustomField ||
                                    isFromContactAndAddress)
                                  if (controller.checkboxValuesforSave[index]) Text("", style: TextStyle(fontSize: 0)),
                                if (isSettingForTableListing)
                                  Obx(
                                    () => GCustomCheckBox(value: controller.checkboxValues[index], size: 18, isMarginRight: true),
                                  ),
                                // SizedBox(
                                //   height: 20,
                                //   child: Transform.scale(
                                //     scale: 0.8,
                                //     child: Checkbox(
                                //       splashRadius: 0,
                                //       checkColor: Colors.white,
                                //       activeColor: secondaryColorOrange,
                                //       value: controller.checkboxValues[index],
                                //       onChanged: (bool? value) {},
                                //     ),
                                //   ),
                                // ),
                                if (isMemberDropdown)
                                  GCustomCheckBox(
                                    value: controller.checkboxValuesforMembers[index],
                                    size: 18,
                                    isMarginRight: true,
                                  ),
                                if (isFromSetting)
                                  GCustomCheckBox(
                                    value: controller.checkboxValuesforSettng[index],
                                    size: 18,
                                    isMarginRight: true,
                                  ),
                                if (isDahboardDropdown)
                                  GCustomCheckBox(
                                    value: controller.listOfWidgetsMain.value[index]["isShow"],
                                    size: 18,
                                    isMarginRight: true,
                                  ),
                                if (isFromSettingforContactPopUp)
                                  GCustomCheckBox(
                                    value: controller.checkboxValuesforSettngforContactPopUp[index],
                                    size: 18,
                                    isMarginRight: true,
                                  ),

                                GParagraphExtraSmall(
                                  isSaveAndClose
                                      ? '${controller.dropDownValuesforSaveAndClose[index]}'
                                      : '${dropDownValuesforSave[index]}',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(color: tablesBorderColor, thickness: 1, height: 1),
                  ],
                );
              },
            );
          }),
        ),
      ],
    );
  }

  static onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItemsForDropdownButton.isFromSave:
        // Get.toNamed("/Settings");
        break;
      case MenuItemsForDropdownButton.logout:
        // Handle logout logic
        break;
    }
  }
}
