import 'package:flutter/material.dart';
import 'package:global365_widgets/src/buttons/custom_button.dart';
import 'package:global365_widgets/src/constants/colors.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/dropdowns/dropdownwithOptions.dart';

class GSaveButton extends StatelessWidget {
  GSaveButton({
    super.key,
    required this.fileController,
    this.btnText,
    this.isPay,
    this.isRecord,
    this.isCustomField,
    this.isSave,
    this.isFromBankCard,
    this.isFromCreditCard,
    this.isFromConatcAndAddress,
    this.isSaveAndClose,
    required this.onTap,
    this.onTapNew,
    this.isButtonInHeader = false,
    this.key1,
  });

  var fileController;
  String? btnText;
  bool? isPay = false;
  bool? isRecord = false;
  bool? isFromBankCard = false;
  bool? isFromCreditCard = false;
  bool? isCustomField = false;
  bool? isFromConatcAndAddress = false;
  bool? isSaveAndClose = false;
  bool? isSave = true;
  dynamic Function() onTap;
  dynamic Function()? onTapNew;
  final bool isButtonInHeader;
  final Key? key1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          GCustomButton(
            onTap: onTap,
            isButtonInHeader: isButtonInHeader,
            // () async {
            //   if (isPay ?? false) {
            //     await fileController.postData(context, true, false);
            //   } else if (isRecord ?? false) {
            //     await fileController.postData(context, false, false);
            //   } else {
            //     await fileController.postData(context, false);
            //   }
            // },
            extraPadding: true,
            isSaveButton: true,
            btnText: btnText ?? "Save",
            backgroundColor: primaryColor,
            textColor: whiteColor,
          ),
          GCustomDropdownButton(
            isPay: isPay ?? false,
            isRecord: isRecord ?? false,
            isFromBankCard: isFromBankCard ?? false,
            isFromCustomField: isCustomField ?? false,
            isFromContactAndAddress: isFromConatcAndAddress ?? false,
            isFromCreditCrad: isFromCreditCard ?? false,
            extraPadding: true,
            fileController: fileController,
            isSrNumberDropdown: false,
            isSettingDropdown: false,
            isSaveDropdown: isSave ?? true,
            isButtonInHeader: isButtonInHeader,
            isSaveAndClose: isSaveAndClose ?? false,
            onTap: onTapNew,
          ),
        ],
      ),
    );
  }
}
