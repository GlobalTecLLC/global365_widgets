import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:global365_widgets/src/dropdowns/searchabledropdowncustom/dropdown_plus.dart';

class SetUpController extends GetxController {
  static SetUpController get to => Get.find();
  RxBool isUpdatingCOntroller = false.obs;
  void updationControllerFunctin() async {

    isUpdatingCOntroller.value = true;
    await Future.delayed(const Duration(milliseconds: 50));

    isUpdatingCOntroller.value = false;
  }

  final formKey = GlobalKey<FormState>();

  TextEditingController businessName = TextEditingController();
  TextEditingController businessLocation = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  String phoneNumberWithoutFormate="";
  String locationDropdownId = "233";
  String statusId = "4842";
  DropdownEditingController<dynamic> locationDropdown = DropdownEditingController();

  final FocusNode businessNameFocusNode = FocusNode();
  final FocusNode submitButtonFocusNode = FocusNode();

  @override
  void onClose() {
    businessNameFocusNode.dispose();
    submitButtonFocusNode.dispose();
    super.onClose();
  }

  bool isExistingCompany=false;
  String existingCompany = "0";
}
