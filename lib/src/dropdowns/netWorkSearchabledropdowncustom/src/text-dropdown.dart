import 'package:flutter/material.dart';
import 'package:global365_widgets/global365_widgets.dart';

import '../dropdown_plus.dart';

/// Simple dorpdown whith plain text as a dropdown items.
class TextDropdownFormField extends StatelessWidget {
  final List<String> options;
  final InputDecoration? decoration;
  final NetWorkDropdownEditingController<String>? controller;
  final void Function(String item)? onChanged;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final bool Function(String item, String str)? filterFn;
  final Future<List<String>> Function(String str)? findFn;
  final double? dropdownHeight;

  TextDropdownFormField({
    Key? key,
    required this.options,
    this.decoration,
    this.onSaved,
    this.controller,
    this.onChanged,
    this.validator,
    this.findFn,
    this.filterFn,
    this.dropdownHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NetWorkDropdownFormField<String>(
      decoration: decoration,
      onSaved: onSaved,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      dropdownHeight: dropdownHeight,
      displayItemFn: (dynamic str) => Text(str ?? '', style: GAppStyle.style16w600()),
      findFn: findFn ?? (dynamic str) async => options,
      filterFn: filterFn ?? (dynamic item, str) => item.toLowerCase().indexOf(str.toLowerCase()) >= 0,
      dropdownItemFn: (dynamic item, position, focused, selected, onTap) => ListTile(
        title: Text(
          item,
          style: TextStyle(color: selected ? Colors.blue : Colors.black87),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        tileColor: focused ? Color.fromARGB(20, 0, 0, 0) : Colors.transparent,
        onTap: onTap,
      ),
    );
  }
}
