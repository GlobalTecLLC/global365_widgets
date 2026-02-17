// ignore_for_file: empty_constructor_bodies, body_might_complete_normally_nullable, unused_element

import 'dart:async';
import 'dart:convert';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/theme/dropdown_theme.dart';

import 'package:scroll_to_index/scroll_to_index.dart';

class NetWorkDropdownEditingController<T> extends ChangeNotifier {
  T? _value;
  NetWorkDropdownEditingController({T? value}) : _value = value;

  T? get value => _value;
  set value(T? newValue) {
    if (_value == newValue) return;
    _value = newValue;
    notifyListeners();
  }

  @override
  String toString() => '${describeIdentity(this)}($value)';
}

/// Create a dropdown form field
class NetWorkDropdownFormField<T> extends StatefulWidget {
  final bool autoFocus;
  final FocusNode? focusNode;

  /// It will trigger on user search
  final bool Function(T item, String str)? filterFn;

  /// Check item is selectd
  final bool Function(T? item1, T? item2)? selectedFn;

  /// Return list of items what need to list for dropdown.
  /// The list may be offline, or remote data from server.
  Future<List<T>> Function(String str) findFn;

  /// Build dropdown Items, it get called for all dropdown items
  ///  [item] = [dynamic value] List item to build dropdown Listtile
  /// [lasSelectedItem] = [null | dynamic value] last selected item, it gives user chance to highlight selected item
  /// [position] = [0,1,2...] Index of the list item
  /// [focused] = [true | false] is the item if focused, it gives user chance to highlight focused item
  /// [onTap] = [Function] *important! just assign this function to Listtile.onTap  = onTap, incase you missed this,
  /// the click event if the dropdown item will not work.
  ///
  final ListTile Function(T item, int position, bool focused, bool selected, Function() onTap) dropdownItemFn;

  /// Build widget to display selected item inside Form Field
  final Widget Function(T? item) displayItemFn;

  final InputDecoration? decoration;
  final Color? dropdownColor;
  final NetWorkDropdownEditingController<T>? controller;
  final void Function(T item)? onChanged;
  final void Function(T?)? onSaved;
  final String? Function(T?)? validator;

  /// height of the dropdown overlay, Default: 240
  final double? dropdownHeight;

  /// Style the search box text
  final TextStyle? searchTextStyle;

  /// Message to disloay if the search dows not match with any item, Default : "No matching found!"
  final String emptyText;

  /// Give action text if you want handle the empty search.
  final String emptyActionText;
  final bool isHaveChild;

  /// this functon triggers on click of emptyAction button
  final Future<void> Function()? onEmptyActionPressed;

  /// Callback when an item is selected from the dropdown.
  /// Useful for triggering a details API using the selected
  /// suggestion's `placeId` (for address autocomplete, etc.).
  final Future<void> Function(String placeId, dynamic item)? onPlaceSelected;

  /// Callback when focus is lost from the dropdown field.
  /// Passes the current typed text so parent can handle it.
  final void Function(String typedText)? onFocusLost;

  final String apiLinkEndPoint;
  final String? baseUrl;
  final bool isMoreParams;
  Map<String, Object>? initValue;

  NetWorkDropdownFormField({
    Key? key,
    required this.dropdownItemFn,
    required this.displayItemFn,
    required this.findFn,
    this.filterFn,
    this.autoFocus = false,
    this.controller,
    this.validator,
    this.decoration,
    this.dropdownColor,
    this.onChanged,
    this.onSaved,
    this.initValue,
    this.dropdownHeight,
    this.searchTextStyle,
    this.emptyText = "No matching found!",
    this.emptyActionText = 'Create new',
    this.onEmptyActionPressed,
    this.selectedFn,
    this.onPlaceSelected,
    this.onFocusLost,
    this.apiLinkEndPoint = "",
    this.baseUrl = "",
    this.isMoreParams = false,
    this.isHaveChild = false,
    this.focusNode,
  }) : super(key: key);

  @override
  NetWorkDropdownFormFieldState createState() => NetWorkDropdownFormFieldState<T>();
}

class NetWorkDropdownFormFieldState<T> extends State<NetWorkDropdownFormField> with SingleTickerProviderStateMixin {
  late FocusNode _widgetFocusNode;
  bool _ownsFocusNode = false;
  final FocusNode _searchFocusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  final ValueNotifier<List<T>> _listItemsValueNotifier = ValueNotifier<List<T>>([]);
  final TextEditingController _searchTextController = TextEditingController();
  final NetWorkDropdownEditingController<T>? _controller = NetWorkDropdownEditingController<T>();

  final Function(T?, T?) _selectedFn = (dynamic item1, dynamic item2) => item1 == item2;

  bool get _isEmpty => _selectedItem == null;
  bool _isFocused = false;

  OverlayEntry? _overlayEntry;
  OverlayEntry? _overlayBackdropEntry;
  List<T>? _options;
  int _listItemFocusedPosition = 0;
  T? _selectedItem;
  Widget? _displayItem;
  Timer? _debounce;
  String? _lastSearchString;

  NetWorkDropdownEditingController<dynamic>? get _effectiveController => widget.controller ?? _controller;

  NetWorkDropdownFormFieldState() : super() {}
  late AutoScrollController controller;

  @override
  void initState() {
    super.initState();
    if (widget.focusNode != null) {
      _widgetFocusNode = widget.focusNode!;
      _ownsFocusNode = false;
    } else {
      _widgetFocusNode = FocusNode();
      _ownsFocusNode = true;
    }
    controller = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical,
    );
    if (widget.autoFocus) _widgetFocusNode.requestFocus();

    if (widget.initValue != null && widget.initValue!.isNotEmpty) {
      _selectedItem = widget.initValue as T?;
      _effectiveController!.value = _selectedItem;

      // Prefill the visible text with the initial selected item so
      // the closed dropdown shows the existing value (used when
      // editing an address).
      try {
        final dynamic selected = _selectedItem;
        String text = "";
        if (selected is Map && selected.containsKey("description")) {
          text = (selected["description"] ?? "").toString();
        } else if (selected != null) {
          text = selected.toString();
        }
        if (text.isNotEmpty) {
          _searchTextController.value = TextEditingValue(text: text);
        }
      } catch (_) {
        // ignore formatting issues
      }
    } else {
      _effectiveController!.value = _selectedItem;
    }

    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus && _overlayEntry != null) {
        // _removeOverlay();
      }
    });
    decoration = widget.decoration ?? InputDecoration(border: UnderlineInputBorder(), suffixIcon: Icon(Icons.arrow_drop_down));
  }

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
    _searchTextController.dispose();
    if (_ownsFocusNode) {
      _widgetFocusNode.dispose();
    }
  }

  InputDecoration decoration = InputDecoration(border: UnderlineInputBorder(), suffixIcon: Icon(Icons.arrow_drop_down));
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    // print("_overlayEntry : $_overlayEntry");

    _displayItem = widget.displayItemFn(_selectedItem);

    return CompositedTransformTarget(
      link: this._layerLink,
      child: GestureDetector(
        onTap: () {
          _widgetFocusNode.requestFocus();
          _toggleOverlay();
        },
        child: Focus(
          autofocus: widget.autoFocus,
          focusNode: _widgetFocusNode,
          onFocusChange: (focused) {
            setState(() {
              _isFocused = focused;
            });

            // When focus is lost, call the callback with current typed text
            if (!focused && widget.onFocusLost != null && mounted) {
              widget.onFocusLost!(_searchTextController.text);
            }
          },
          onKey: (focusNode, event) {
            return _onKeyPressed(event);
          },
          child: FormField(
            validator: (str) {
              if (widget.validator != null) {
                widget.validator!(_effectiveController!.value);
              }
            },
            onSaved: (str) {
              if (widget.onSaved != null) {
                widget.onSaved!(_effectiveController!.value);
              }
            },
            builder: (state) {
              return InputDecorator(
                decoration: decoration,
                isEmpty: _isEmpty,
                isFocused: _isFocused,
                child: EditableText(
                  style: widget.searchTextStyle ?? GDropDownTheme.displayTextStyle(),
                  controller: _searchTextController,
                  cursorColor: Colors.black87,
                  focusNode: _searchFocusNode,
                  backgroundCursorColor: Colors.transparent,
                  onChanged: (str) {
                    if (str.isEmpty) {
                      setState(() {
                        decoration =
                            widget.decoration ??
                            const InputDecoration(border: UnderlineInputBorder(), suffixIcon: Icon(Icons.arrow_drop_down));
                      });
                    } else {
                      setState(() {
                        decoration = decoration.copyWith(hintText: "");
                      });
                    }

                    if (_overlayEntry == null) {
                      _addOverlay();
                    }
                    _onTextChanged(
                      widget.apiLinkEndPoint,
                      widget.isMoreParams,
                      str,
                      isHaveChild: widget.isHaveChild,
                      baseUrl: widget.baseUrl,
                    );
                  },
                  onSubmitted: (str) {
                    _setValue();
                    _removeOverlay();
                    _widgetFocusNode.unfocus();
                  },
                  onEditingComplete: () {},
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    final renderObject = context.findRenderObject() as RenderBox;
    // print(renderObject);
    final size = renderObject.size;
    // final ui.Size size = renderObject.size;

    var overlay = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: size.width,
          child: CompositedTransformFollower(
            link: this._layerLink,
            showWhenUnlinked: false,
            offset: Offset(0.0, size.height + 3.0),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: SizedBox(
                // height:
                // 240,
                child: Container(
                  color: widget.dropdownColor ?? Colors.white70,
                  child: ValueListenableBuilder(
                    valueListenable: _listItemsValueNotifier,
                    builder: (context, List<T> items, child) {
                      print("_isFetchingDataNotifier.value: in builder ${_isFetchingDataNotifier.value}");
                      return ValueListenableBuilder(
                        valueListenable: _isFetchingDataNotifier,
                        builder: (context, bool items, child) {
                          return SizedBox(
                            height: _isFetchingDataNotifier.value == true
                                ? 100
                                : (apiResponsetoHandleHeight == 200)
                                ? widget.dropdownHeight ?? 240
                                : 0,
                            child: Container(
                              child: _isFetchingDataNotifier.value
                                  ? Container(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [globalSpinkitForLoaders()],
                                      ),
                                    )
                                  : _options != null && _options!.length > 0
                                  ? ListView.builder(
                                      controller: controller,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemCount: _options!.length,
                                      itemBuilder: (context, position) {
                                        final T item = _options![position];

                                        // Build the base ListTile from the caller.
                                        final listTile = widget.dropdownItemFn(
                                          item,
                                          position,
                                          position == _listItemFocusedPosition,
                                          (widget.selectedFn ?? _selectedFn)(_selectedItem, item),
                                          () {
                                            print("call onTap");
                                            _listItemFocusedPosition = position;
                                            _removeOverlay();
                                            _setValue();
                                          },
                                        );

                                        final dynamic data = _options![position] ?? {};

                                        // If this item has children, keep the simple rendering.
                                        if ((data["child"] ?? []).isNotEmpty) {
                                          return Container(child: const Text("Have Child"));
                                        }

                                        // Mirror the visual design from the non-network dropdown:
                                        // compact row, left padding, hover/focus background, and
                                        // optional "isUsed" check icon if present on the item.
                                        final bool isUsed = (data is Map) ? (data['isUsed'] ?? false) : false;

                                        return AutoScrollTag(
                                          key: ValueKey(position),
                                          controller: controller,
                                          index: position,
                                          child: Material(
                                            color: Colors.white,
                                            child: InkWell(
                                              onTap: listTile.onTap,
                                              child: Container(
                                                padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: (_listItemFocusedPosition == position)
                                                      ? lightBackgroundColor
                                                      : Colors.transparent,
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: listTile.onTap != null ? borderColor : Colors.transparent,
                                                      width: 0.5,
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          Expanded(child: listTile.title ?? const SizedBox.shrink()),
                                                          if (isUsed == true) ...[
                                                            const GSizeW(6),
                                                            const Icon(
                                                              BootstrapIcons.check_circle_fill,
                                                              color: greenCOlor,
                                                              size: 14,
                                                            ),
                                                          ],
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      padding: EdgeInsets.all(16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Text(widget.emptyText, style: TextStyle(color: Colors.black45)),
                                          if (widget.onEmptyActionPressed != null)
                                            TextButton(
                                              onPressed: () async {
                                                await widget.onEmptyActionPressed!();
                                                _search(_searchTextController.value.text);
                                              },
                                              child: Text(widget.emptyActionText),
                                            ),
                                        ],
                                      ),
                                    ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    return overlay;
  }

  OverlayEntry _createBackdropOverlay() {
    return OverlayEntry(
      builder: (context) => Positioned(
        left: 0,
        top: 0,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GestureDetector(
          onTap: () {
            _removeOverlay();
          },
        ),
      ),
    );
  }

  _addOverlay() {
    if (_overlayEntry == null) {
      // Use the current text in the controller as the source of truth.
      // Only prefill from _selectedItem if the controller is empty,
      // so placing the cursor in the middle and typing does not get
      // overridden when the overlay opens.
      String searchText = _searchTextController.text;

      if (searchText.isEmpty && _selectedItem != null) {
        try {
          final dynamic item = _selectedItem;
          String text = "";

          if (item is Map && item.containsKey("description")) {
            text = (item["description"] ?? "").toString();
          } else {
            text = item.toString();
          }

          searchText = text;
          _searchTextController.value = TextEditingValue(
            text: text,
            selection: TextSelection.collapsed(offset: text.length),
          );
          decoration = decoration.copyWith(hintText: "");
        } catch (_) {
          // In case of any casting issues, just leave the field empty.
        }
      }

      // For network-backed dropdowns, reuse the current text to
      // trigger the API search so the list is not empty when
      // reopening. For pure local lists, fall back to the existing
      // behaviour that uses findFn.
      if ((widget.apiLinkEndPoint.isNotEmpty || widget.isMoreParams) && searchText.trim().length >= 3) {
        _onTextChanged(
          widget.apiLinkEndPoint,
          widget.isMoreParams,
          searchText,
          isHaveChild: widget.isHaveChild,
          baseUrl: widget.baseUrl,
        );
      } else {
        _search(searchText);
      }
      _overlayBackdropEntry = _createBackdropOverlay();
      _overlayEntry = _createOverlayEntry();
      if (_overlayEntry != null) {
        // Overlay.of(context)!.insert(_overlayEntry!);
        Overlay.of(context).insertAll([_overlayBackdropEntry!, _overlayEntry!]);
        setState(() {
          _searchFocusNode.requestFocus();
        });
      }
    }
  }

  /// Dettach overlay from the dropdown widget
  _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayBackdropEntry!.remove();
      _overlayEntry!.remove();
      _overlayEntry = null;
      setState(() {});
    }
  }

  _toggleOverlay() {
    if (_overlayEntry == null)
      _addOverlay();
    else
      _removeOverlay();
  }

  dynamic apiResponsetoHandleHeight;
  ValueNotifier<bool> _isFetchingDataNotifier = ValueNotifier<bool>(false);

  _onTextChanged(String apilInk, bool isMoreparams, String? str, {bool isHaveChild = false, String? baseUrl}) async {
    print("str-------------------------------------$str and api liknk is $apilInk");

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () async {
      // If search text is null or too short, do not hit the API
      // and ensure the loading flag is reset so the previous
      // results remain visible.
      if (str == null || str.isEmpty || str.length < 3) {
        _isFetchingDataNotifier.value = false;
        return;
      }

      _isFetchingDataNotifier.value = true;

      if (str.length >= 3) {
        if (!isMoreparams) {
          final requestUrl = "$apilInk$str";

          // ResponseModel response = await APIsCallGet.getData(requestUrl);
          ResponseModel response = await APIsCallPost.submitRequestWithOutBody("$apilInk$str", baseUrl: "$baseUrl");

          // printLog("isfetchingDataFromAPi ${_isFetchingDataNotifier.value}");

          _isFetchingDataNotifier.value = false;

          if (response.statusCode == 200) {
            final parsed = jsonDecode(response.data);
            apiResponsetoHandleHeight = parsed["result"];

            final payloadList = (parsed["payload"] ?? []) as List;

            List<T> items = payloadList.map((s) {
              final suggestion = (s ?? {}) as Map;
              final description = (suggestion["address"] ?? "").toString();
              final placeId = suggestion["placeId"];

              return {"description": description, "placeId": placeId, "raw": suggestion} as T;
            }).toList();

            setState(() {
              _options = items;
              _listItemsValueNotifier.value = items;
            });
          } else {
            print("error from API ${jsonDecode(response.data)['message'] ?? 'Something went wrong.'}");
          }
        } else {
          final encoded = Uri.encodeComponent(str);
          final separator = apilInk.contains('?') ? '&' : '';
          final requestUrl = "$apilInk${separator}Search=$encoded";
          ResponseModel response = await APIsCallGet.getData(requestUrl);
          // printLog("isfetchingDataFromAPi ${_isFetchingDataNotifier.value}");

          _isFetchingDataNotifier.value = false;

          if (response.statusCode == 200) {
            final parsed = jsonDecode(response.data);

            print(parsed);
            apiResponsetoHandleHeight = parsed["result"];
            widget.findFn = (String str) async => parsed['payload'];
            List<T> items = await widget.findFn(str) as List<T>;
            List<T> itemsNew = [];

            if (widget.isHaveChild) {
              for (int i = 0; i < items.length; i++) {
                dynamic item = items[i] ?? {};
                List childs = item["child"] ?? [];
                itemsNew.add(
                  {
                        "value": item["value"],
                        "label": item["label"],
                        "code": item["code"],
                        "parentId": item["parentId"],
                        "parentName": item["parentName"],
                        "isChild": false,
                        "label_2": item["label"],
                      }
                      as T,
                );
                for (int j = 0; j < childs.length; j++) {
                  dynamic child = childs[j];
                  itemsNew.add(
                    {
                          "value": child["value"],
                          "label": child["label"],
                          "code": child["code"],
                          "parentId": child["parentId"],
                          "parentName": child["parentName"],
                          "isChild": true,
                          "label_2": "${child["parentName"]}:${child["label"]}",
                        }
                        as T,
                  );
                }
              }
            } else {
              itemsNew = items;
            }
            setState(() {
              _options = itemsNew;
              _listItemsValueNotifier.value = itemsNew;
            });
            // widget.findFn("label").then((result) {
            //   if (result.isNotEmpty)
            //     print("result $result value ${result[0]["value"]}");
            //   // Handle the result as needed
            // });
          } else {
            print("error from API ${jsonDecode(response.data)['message'] ?? 'Something went wrong.'}");
          }
        }
      }
    });
    // print("_onChanged: $_lastSearchString = $str");
    // if (_lastSearchString != str) {
    //   _lastSearchString = str;
    //   _search(str ?? "");
    // }
  }

  _onKeyPressed(RawKeyEvent event) {
    // print('_onKeyPressed : ${event.character}');
    if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
      print(_listItemFocusedPosition);
      print("this is callsed");

      if (_searchFocusNode.hasFocus) {
        _setValue();

        _toggleOverlay();
      } else {
        _toggleOverlay();
      }
      return KeyEventResult.handled;
    } else if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
      _removeOverlay();
      return KeyEventResult.handled;
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
      int v = _listItemFocusedPosition;
      v++;
      if (v >= _options!.length) v = 0;
      _listItemFocusedPosition = v;
      _listItemsValueNotifier.value = List<T>.from(_options ?? []);
      controller.scrollToIndex(_listItemFocusedPosition, preferPosition: AutoScrollPosition.begin);
      return KeyEventResult.handled;
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
      int v = _listItemFocusedPosition;
      v--;
      if (v < 0) v = _options!.length - 1;
      _listItemFocusedPosition = v;
      _listItemsValueNotifier.value = List<T>.from(_options ?? []);
      controller.scrollToIndex(_listItemFocusedPosition, preferPosition: AutoScrollPosition.begin);
      return KeyEventResult.handled;
    } else if (event.isShiftPressed && event.isKeyPressed(LogicalKeyboardKey.tab)) {
      // Handle Shift+Tab: close overlay and move to previous field
      if (_overlayEntry != null) {
        _removeOverlay();
      }
      return KeyEventResult.ignored;
    } else if (event.isKeyPressed(LogicalKeyboardKey.tab)) {
      // Handle Tab: close overlay and move to next field
      if (_overlayEntry != null) {
        _removeOverlay();
      }
      return KeyEventResult.ignored;
    }
    return KeyEventResult.ignored;
  }

  _search(String str) async {
    if (str.length > 0) {
      setState(() {});
    }
    List<T> items = await widget.findFn(str) as List<T>;

    if (str.isNotEmpty && widget.filterFn != null) {
      items = items.where((item) => widget.filterFn!(item, str)).toList();
    }

    _options = items;

    _listItemsValueNotifier.value = items;

    // print('_search ${_options!.length}');
  }

  _setValue() async {
    var item = _options![_listItemFocusedPosition];
    _selectedItem = item;

    _effectiveController!.value = _selectedItem;

    if (widget.onChanged != null) {
      widget.onChanged!(_selectedItem);
    }

    // If consumer provided a placeId callback and the selected
    // item has a placeId field (as in the address suggestions
    // built in _onTextChanged), invoke it so they can call
    // their GET API for place details. This is awaited so the
    // callback has a chance to mutate the selected item (for
    // example, to replace description with a resolved address)
    // before we copy text into the field.
    if (widget.onPlaceSelected != null) {
      try {
        final dynamic selected = _selectedItem;
        if (selected is Map && selected["placeId"] != null) {
          final String placeId = selected["placeId"].toString();
          await widget.onPlaceSelected!(placeId, selected);
        }
      } catch (_) {
        // Safely ignore any casting issues.
      }
    }

    // Keep the (possibly updated) selected item's description in
    // the editable text field so the user can further edit it.
    try {
      final dynamic selected = _selectedItem;
      String text = "";
      if (selected is Map && selected.containsKey("description")) {
        text = (selected["description"] ?? "").toString();
      } else {
        text = selected.toString();
      }
      _searchTextController.value = TextEditingValue(text: text);
    } catch (_) {
      // ignore formatting issues
    }

    setState(() {});
  }

  _clearValue() {
    var item;
    _effectiveController!.value = item;

    if (widget.onChanged != null) {
      widget.onChanged!(_selectedItem);
    }
    _searchTextController.value = TextEditingValue(text: "");
  }
}
