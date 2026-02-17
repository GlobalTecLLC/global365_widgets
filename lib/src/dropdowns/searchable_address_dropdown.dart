import 'package:flutter/material.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/dropdowns/netWorkSearchabledropdowncustom/dropdown_plus.dart';
import 'package:global365_widgets/src/theme/dropdown_theme.dart';

// ignore: must_be_immutable
class SearchableAddressDropDownForSignup extends StatefulWidget {
  final bool isNotHistory;
  final bool isLoading;
  final bool isUpdate;
  final bool isEnabled;
  final String partyId;
  final String label;
  final bool? isRequired;
  final void Function(dynamic item)? onChanged;
  final bool isShowLabelingColumn;
  final String apiLinkEndPoint;
  final dynamic screenController;

  final double? containerHeight;
  final double? containerWidth;
  Map<String, Object> addressDataMap;
  final FocusNode? focusNode;
  final Future<void> Function(String placeId, dynamic item)? apiChangeCallBack;
  final void Function(String typedText)? onFocusLost;

  final NetWorkDropdownEditingController<dynamic> controller;
  SearchableAddressDropDownForSignup({
    required this.controller,
    required this.addressDataMap,
    this.isNotHistory = false,
    this.isLoading = false,
    this.isUpdate = false,
    this.isEnabled = false,
    required this.screenController,
    this.partyId = "0",
    this.label = "Company",
    this.focusNode,
    this.onChanged,
    this.isShowLabelingColumn = true,
    this.containerHeight,
    this.containerWidth,
    this.isRequired = false,
    required this.apiLinkEndPoint,

    this.apiChangeCallBack,
    this.onFocusLost,
    super.key,
  });

  @override
  State<SearchableAddressDropDownForSignup> createState() => _SearchableAddressDropDownForSignupState();
}

class _SearchableAddressDropDownForSignupState extends State<SearchableAddressDropDownForSignup> {
  @override
  void initState() {
    controller = widget.controller;
    isNotHistory = widget.isNotHistory;
    isLoading = widget.isLoading;
    isUpdate = widget.isUpdate;

    super.initState();
  }

  String objectName = "street";
  String objectIDName = "state";
  bool isNotHistory = false;
  bool isUpdate = false;

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
  NetWorkDropdownEditingController controller = NetWorkDropdownEditingController();
  Widget dropDownCompanies() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Row(
        //   children: [
        if (widget.isShowLabelingColumn)
          Row(
            children: [
              GDropDownTheme.headerTextBold(widget.label),
              if (widget.isRequired ?? false) Text(" *", style: GTextFiledTheme.textStyleHeaderRequired(14)),
            ],
          ), //     Text(
        const SizedBox(height: 4),
        dropDownSizedBox(
          height: widget.containerHeight,
          width: widget.containerWidth,
          child: NetWorkDropdownFormField<dynamic>(
            focusNode: widget.focusNode,
            apiLinkEndPoint: widget.apiLinkEndPoint,
            baseUrl: apiLink,
            onPlaceSelected: (placeId, item) async {
              if (widget.apiChangeCallBack != null) {
                await widget.apiChangeCallBack!(placeId, item);
                // After the callback updates controllers/text, rebuild so
                // displayItemFn picks up the latest streetLine1 value.
                setState(() {});
              }
            },
            onFocusLost: widget.onFocusLost,

            searchTextStyle: GAppStyle.style14w500(color: bodyTextDark),
            initValue: widget.addressDataMap,
            isHaveChild: false,
            isMoreParams: false,
            onEmptyActionPressed: null,
            emptyActionText: "",
            controller: widget.controller,

            decoration: GDropDownTheme.dropDownDecoration(widget.label),
            onSaved: (dynamic str) {},
            onChanged: widget.onChanged,
            validator: (dynamic str) {
              return null;
            },
            displayItemFn: (dynamic item) {
              final controller = widget.screenController;

              final String fromApi = (controller.addressLine1ControllerForAddressDropdown.text).toString();
              final String fallback = (item?["description"] ?? "").toString();
              final String text = fromApi.isNotEmpty ? fromApi : fallback;

              return Text(text, style: GDropDownTheme.displayTextStyle(), maxLines: 1, overflow: TextOverflow.ellipsis);
            },
            findFn: (dynamic str) async => listItems,
            selectedFn: (dynamic item1, dynamic item2) {
              if (item1 != null && item2 != null) {
                return item1[objectName] == item2[objectName];
              }
              return false;
            },

            filterFn: (dynamic item, str) => (item["description"] ?? "").toLowerCase().contains(str.toLowerCase()),
            dropdownItemFn: (dynamic item, int position, bool focused, bool selected, Function() onTap) => ListTile(
              title: Text(
                item["description"] ?? "",
                style: GDropDownTheme.dropDownItemStyle(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              tileColor: focused ? const Color.fromARGB(20, 0, 0, 0) : Colors.transparent,
              onTap: onTap,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(child: dropDownCompanies());
  }
}
