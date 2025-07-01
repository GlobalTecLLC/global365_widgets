import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/dropdowns/searchabledropdowncustom/src/dropdown.dart';
import 'package:global365_widgets/src/theme/dropdown_theme.dart';

class GenderDropdown extends StatefulWidget {
  final bool isNotHistory;
  final bool isLoading;
  final bool isUpdate;
  final bool isRequired;
  final bool isEnabled;
  final String partyId;
  final String label;
  final void Function(dynamic item)? onChanged;
  final bool isShowLabelingColumn;
  final double? containerHeight;

  final DropdownEditingController<dynamic> controller;
  const GenderDropdown({
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
    Key? key,
  }) : super(key: key);

  @override
  State<GenderDropdown> createState() => _GenderDropdownState();
}

class _GenderDropdownState extends State<GenderDropdown> {
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

  List monthDaysList = [
    {"id": 1, "name": "Male"},
    {"id": 2, "name": "Female"},
  ];
  Future<void> fetchData() async {
    if (monthDaysList.isEmpty) {
      setState(() {
        isLoading = false;
      });

      APIsCallGet.getData("ChartOfAccounts/GetConfigurationCategory?CompanyId=$companyId").then((response) {
        if (response.statusCode == 200) {
          final parsed = jsonDecode(response.data);
          List tempNew = isNotHistory
              ? []
              : [
                  {"id": 1, "value": true, "label": "Scheduled"},
                ];
          tempNew.addAll(parsed);
          if (!isNotHistory) {
            controller.value = tempNew[0];
          }

          setState(() {
            listItems = tempNew;
            monthDaysList = tempNew;
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
      final parsed = monthDaysList;
      List tempNew = isNotHistory
          ? []
          : [
              {"id": 0, "name": "All"},
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
  Widget dropDownCompanies() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (widget.isShowLabelingColumn) GDropDownTheme.headerText(widget.label),
            if (widget.isRequired)
              Text(
                " *",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.red),
              ),
          ],
        ),
        if (widget.isShowLabelingColumn) const SizedBox(height: 4),
        (isLoading)
            ? SizedBox(
                // padding:
                //     const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                height: widget.containerHeight,
                child: DropdownFormField<dynamic>(
                  // dropdownHeight: getHeight(context) * 0.7,
                  onEmptyActionPressed: null,
                  emptyActionText: "",
                  controller: controller,
                  decoration: GDropDownTheme.dropDownDecoration(widget.label),
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
