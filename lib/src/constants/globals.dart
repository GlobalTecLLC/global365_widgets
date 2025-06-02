import 'package:flutter/material.dart';
import 'package:get/get.dart';

extension TextEditingControllerExt on TextEditingController {
  void selectAll() {
    if (text.isEmpty) return;
    selection = TextSelection(baseOffset: 0, extentOffset: text.length);
  }
}

RxList dropDownValuesforSave = ["Save and New"].obs;

RxList dropDownValuesforSaveAndClose = ["Save and Close"].obs;
