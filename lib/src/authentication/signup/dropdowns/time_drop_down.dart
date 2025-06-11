import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:global365_widgets/src/dropdowns/searchabledropdowncustom/dropdown_plus.dart';
import 'package:global365_widgets/src/theme/dropdown_theme.dart';
import 'package:global365_widgets/src/theme/theme_export.dart';
import 'package:global365_widgets/src/utils/api_client/api_client.dart';
import 'package:global365_widgets/src/constants/globals.dart';

class TimeDropdown extends StatefulWidget {
  final bool isNotHistory;
  final bool isLoading;
  final bool isRequired;

  final bool isUpdate;
  final bool isEnabled;
  final String partyId;
  final String label;
  final void Function(dynamic item)? onChanged;
  final bool isShowLabelingColumn;
  final bool isLoadingForEdit;

  final double? containerHeight;

  final DropdownEditingController<dynamic> controller;
  const TimeDropdown({
    required this.controller,
    this.isNotHistory = false,
    this.isLoading = false,
    this.isRequired = false,
    this.isUpdate = false,
    this.isEnabled = false,
    this.partyId = "0",
    this.label = "Company",
    this.onChanged,
    this.isShowLabelingColumn = true,
    this.containerHeight,
    this.isLoadingForEdit = false,
    Key? key,
  }) : super(key: key);

  @override
  State<TimeDropdown> createState() => _TimeDropdownState();
}

class _TimeDropdownState extends State<TimeDropdown> {
  @override
  void initState() {
    controller = widget.controller;
    isNotHistory = widget.isNotHistory;
    isLoading = widget.isLoading;
    isUpdate = widget.isUpdate;
    fetchData();
    super.initState();
  }

  String objectName = "name";
  String objectIDName = "id";

  bool isNotHistory = false;
  bool isUpdate = false;

  List listOfClients = [
    {"id": "0", "name": "00:00"},
    {"id": "1", "name": "00:30"},
    {"id": "2", "name": "01:00"},
    {"id": "3", "name": "01:30"},
    {"id": "4", "name": "02:00"},
    {"id": "5", "name": "02:30"},
    {"id": "6", "name": "03:00"},
    {"id": "7", "name": "03:30"},
    {"id": "8", "name": "04:00"},
    {"id": "9", "name": "04:30"},
    {"id": "10", "name": "05:00"},
    {"id": "11", "name": "05:30"},
    {"id": "12", "name": "06:00"},
    {"id": "13", "name": "06:30"},
    {"id": "14", "name": "07:00"},
    {"id": "15", "name": "07:30"},
    {"id": "16", "name": "08:00"},
    {"id": "17", "name": "08:30"},
    {"id": "18", "name": "09:00"},
    {"id": "19", "name": "09:30"},
    {"id": "20", "name": "10:00"},
    {"id": "21", "name": "10:30"},
    {"id": "22", "name": "11:00"},
    {"id": "23", "name": "11:30"},
    {"id": "24", "name": "12:00"},
    {"id": "25", "name": "12:30"},
    {"id": "26", "name": "13:00"},
    {"id": "27", "name": "13:30"},
    {"id": "28", "name": "14:00"},
    {"id": "29", "name": "14:30"},
    {"id": "30", "name": "15:00"},
    {"id": "31", "name": "15:30"},
    {"id": "32", "name": "16:00"},
    {"id": "33", "name": "16:30"},
    {"id": "34", "name": "17:00"},
    {"id": "35", "name": "17:30"},
    {"id": "36", "name": "18:00"},
    {"id": "37", "name": "18:30"},
    {"id": "38", "name": "19:00"},
    {"id": "39", "name": "19:30"},
    {"id": "40", "name": "20:00"},
    {"id": "41", "name": "20:30"},
    {"id": "42", "name": "21:00"},
    {"id": "43", "name": "21:30"},
    {"id": "44", "name": "22:00"},
    {"id": "45", "name": "22:30"},
    {"id": "46", "name": "23:00"},
    {"id": "47", "name": "23:30"},
  ];
  Future<void> fetchData() async {
    if (listOfClients.isEmpty) {
      setState(() {
        isLoading = false;
      });

      ApiCalls.getAPICall(context, url: "ServicesAndProduct/GetServiceOptions?CompanyId=").then((response) {
        if (response.statusCode == 200) {
          // final parsed = jsonDecode(response.data);
          dynamic payLoad = jsonDecode(response.data);
          List parsed = payLoad['payload'];
          List tempNew = isNotHistory
              ? []
              : [
                  {"id": "0", "name": "All"},
                ];
          tempNew.addAll(parsed);
          if (!isNotHistory) {
            controller.value = tempNew[0];
          }

          setState(() {
            listItems = tempNew;
            listOfClients = tempNew;
          });

          if (!isUpdate) {
            setState(() {
              isLoading = true;
            });
          } else {
            findandAssignValue();
          }
        } else {
          setState(() {
            isLoading = true;
          });
        }
      });
    } else {
      final parsed = listOfClients;
      List tempNew = isNotHistory
          ? []
          : [
              {"id": "0", "name": "All"},
            ];
      tempNew.addAll(parsed);

      if (!isNotHistory) {
        controller.value = tempNew[0];
      }

      setState(() {
        listItems = tempNew;
      });
      if (!isUpdate) {
        setState(() {
          isLoading = true;
        });
      } else {
        findandAssignValue();
      }
    }
  }

  findandAssignValue() {
    for (int i = 0; i < listItems.length; i++) {
      if (listItems[i][objectIDName].toString() == widget.partyId) {
        controller.value = listItems[i];
      }
    }
    setState(() {
      isLoading = true;
    });
  }

  bool isLoading = false;
  List listItems = [];
  DropdownEditingController controller = DropdownEditingController();

  double? get fontSizeForLabel => null;
  Widget dropDownCompanies() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isShowLabelingColumn)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GDropDownTheme.headerText(widget.label),
              if (widget.isRequired) Text(" *", style: GTextFiledTheme.textStyleHeaderRequired(fontSizeForLabel)),
            ],
          ),
        if (widget.isShowLabelingColumn == false) GSizeH(16),
        (isLoading)
            ? dropDownSizedBox(
                height: widget.containerHeight,
                child: DropdownFormField<dynamic>(
                  // dropdownHeight: getHeight(context) * 0.7,
                  onEmptyActionPressed: null,
                  emptyActionText: "",
                  controller: controller,
                  decoration: GDropDownTheme.dropDownDecoration(""),
                  onSaved: (dynamic str) {
                    print("run on saved");
                  },
                  onChanged: widget.onChanged,
                  validator: (dynamic str) {
                    print("run on validator");
                    return null;
                  },
                  displayItemFn: (dynamic item) => Text(
                    (item ?? {})[objectName] ?? '',
                    style: GDropDownTheme.displayTextStyle(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  findFn: (dynamic str) async => listItems,
                  selectedFn: (dynamic item1, dynamic item2) {
                    if (item1 != null && item2 != null) {
                      print(item2);
                      return item1[objectName] == item2[objectName];
                    }
                    return false;
                  },
                  filterFn: (dynamic item, str) => item[objectName].toLowerCase().indexOf(str.toLowerCase()) >= 0,
                  dropdownItemFn: (dynamic item, int position, bool focused, bool selected, Function() onTap) =>
                      ListTile(
                        title: Text(item[objectName].toString(), style: GDropDownTheme.dropDownItemStyle()),
                        tileColor: focused ? const Color.fromARGB(20, 0, 0, 0) : Colors.transparent,
                        onTap: onTap,
                      ),
                ),
              )
            : globalSpinkitForLoaderswithBorder(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: dropDownCompanies());
  }
}
