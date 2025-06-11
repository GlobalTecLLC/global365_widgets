// ignore_for_file: empty_constructor_bodies, body_might_complete_normally_nullable, unused_element

import 'dart:async';

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/theme/dropdown_theme.dart';
import 'package:global365_widgets/src/utils/print_log.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class DropdownEditingController<T> extends ChangeNotifier {
  T? _value;
  DropdownEditingController({T? value}) : _value = value;

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
class DropdownFormField<T> extends StatefulWidget {
  Offset? offset;
  final bool autoFocus;

  /// It will trigger on user search
  final bool Function(T item, String str)? filterFn;

  /// Check item is selected
  final bool Function(T? item1, T? item2)? selectedFn;

  /// Return list of items that need to list for dropdown (offline, or remote data).
  final Future<List<T>> Function(String str) findFn;

  /// Build dropdown Items
  final ListTile Function(T item, int position, bool focused, bool selected, Function() onTap) dropdownItemFn;

  /// Build widget to display selected item in the Form Field
  final Widget Function(T? item) displayItemFn;
  final String? objectIDName;
  final List<int>? listForSkip;

  final String? objectName;
  final bool allowCreate;
  final bool isAllowOnlyCreate;
  final bool isAllowCreateAndEdit;

  final bool isCountryDropdown;
  final InputDecoration? decoration;
  final Color? dropdownColor;
  final DropdownEditingController<T>? controller;
  final void Function(T item)? onChanged;
  final void Function(T?)? onSaved;
  final String? Function(T?)? validator;

  /// height of the dropdown overlay, Default: 240
  final double? dropdownHeight;

  /// Style the search box text
  final TextStyle? searchTextStyle;

  /// Message if the search does not match with any item, Default : "No matching found!"
  final String emptyText;

  /// Provide an action text if you handle the empty search.
  final String emptyActionText;

  bool isDropDownEnabled = false;
  bool showAddLink = false;
  final bool isHeightForTransactionType;

  /// triggers on click of emptyAction button
  final Future<void> Function()? onEmptyActionPressed;
  void Function(bool isCreateEdit, String userValue)? onPressedOFEmptyAction;
  final String textonEmptyActionPressed;
  final Key? key1;

  DropdownFormField({
    Key? key,
    required this.dropdownItemFn,
    required this.displayItemFn,
    required this.findFn,
    this.filterFn,
    this.autoFocus = false,
    this.offset,
    this.controller,
    this.validator,
    this.decoration,
    this.dropdownColor,
    this.onChanged,
    this.onSaved,
    this.dropdownHeight,
    this.searchTextStyle,
    this.emptyText = "No matching found!",
    this.emptyActionText = 'Create new',
    this.onEmptyActionPressed,
    this.onPressedOFEmptyAction,
    this.objectIDName = "id",
    this.objectName = "name",
    this.listForSkip,
    this.isCountryDropdown = false,
    this.allowCreate = false,
    this.isAllowOnlyCreate = false,
    this.isAllowCreateAndEdit = false,
    this.textonEmptyActionPressed = "Add Account",
    this.showAddLink = false,
    this.isDropDownEnabled = true,
    this.selectedFn,
    this.isHeightForTransactionType = false,
    this.key1,
  }) : super(key: key);

  @override
  DropdownFormFieldState createState() => DropdownFormFieldState<T>();
}

class DropdownFormFieldState<T> extends State<DropdownFormField> with SingleTickerProviderStateMixin {
  final FocusNode _widgetFocusNode = FocusNode(debugLabel: "widget");
  final FocusNode _searchFocusNode = FocusNode(debugLabel: "search");
  final LayerLink _layerLink = LayerLink();
  final ValueNotifier<List<T>> _listItemsValueNotifier = ValueNotifier<List<T>>([]);
  final TextEditingController _searchTextController = TextEditingController();
  final DropdownEditingController<T> _controller = DropdownEditingController<T>();

  final Function(T?, T?) _selectedFn = (dynamic item1, dynamic item2) => item1 == item2;

  bool get _isEmpty => _selectedItem == null;
  bool _isFocused = false;

  double widgetBottomOffset = 0.0;
  final GlobalKey widgetKey = GlobalKey();

  void findWidgetPosition(BuildContext context) {
    final RenderBox? _renderBox = widgetKey.currentContext?.findRenderObject() as RenderBox?;
    if (_renderBox == null) return;
    final Offset _offset = _renderBox.localToGlobal(Offset.zero);
    final screenHeight = MediaQuery.of(context).size.height;

    widgetBottomOffset = screenHeight - (_offset.dy + _renderBox.size.height);
    // gLogger("widgetBottomOffset=======$widgetBottomOffset");
  }

  OverlayEntry? _overlayEntry;
  OverlayEntry? _overlayBackdropEntry;
  List<T>? _options;
  int _listItemFocusedPosition = 0;
  T? _selectedItem;
  Widget? _displayItem;
  Timer? _debounce;
  String? _lastSearchString;
  RxBool overlayTapped = false.obs;

  DropdownEditingController<dynamic>? get _effectiveController => widget.controller ?? _controller;

  late AutoScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = AutoScrollController(
      viewportBoundaryGetter: () => Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: Axis.vertical,
    );

    if (widget.autoFocus) _widgetFocusNode.requestFocus();
    _selectedItem = _effectiveController!.value;

    // 1) Just remove the “hardware key” check, always close on focus loss:
    _searchFocusNode.addListener(() {
      if (!_searchFocusNode.hasFocus && _overlayEntry != null && widget.isDropDownEnabled != false) {
        if (HardwareKeyboard.instance.physicalKeysPressed.isNotEmpty) {
          _removeOverlay();
        }

        // _removeOverlay();
      }
    });

    // 2) If the widgetFocus is lost, remove the overlay
    _widgetFocusNode.addListener(() {
      if (_widgetFocusNode.hasFocus && widget.isDropDownEnabled != false) {
        _addOverlay();
      }
      // else {
      //   _removeOverlay();
      // }
    });

    // If no custom decoration is provided, use a default
    decoration =
        widget.decoration ??
        const InputDecoration(
          border: UnderlineInputBorder(),
          suffixIcon: Icon(Icons.arrow_drop_down),
          hintMaxLines: 1,
          errorMaxLines: 1,
          helperMaxLines: 1,
        );
  }

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
    _searchTextController.dispose();
  }

  InputDecoration decoration = const InputDecoration(
    border: UnderlineInputBorder(),
    suffixIcon: Icon(Icons.arrow_drop_down),
    hintMaxLines: 1,
    errorMaxLines: 1,
    helperMaxLines: 1,
  );
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      findWidgetPosition(context);
    });
    _displayItem = widget.displayItemFn(_selectedItem);

    return CompositedTransformTarget(
      key: widgetKey,
      link: _layerLink,
      child: GestureDetector(
        onTap: widget.isDropDownEnabled
            ? () {
                // If you still want to focus programmatically, do so only if closed:
                // if (_overlayEntry == null) {
                //   _widgetFocusNode.requestFocus();
                // }

                _toggleOverlay();
              }
            : null,
        child: Focus(
          autofocus: widget.autoFocus,
          focusNode: _widgetFocusNode,
          onFocusChange: (focused) {
            setState(() {
              _isFocused = focused;
            });
          },
          onKey: (focusNode, event) => _onKeyPressed(event),
          child: FormField(
            validator: (str) {
              if (widget.validator != null) {
                widget.validator!(_effectiveController!.value);
              }
              return null;
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
                child: (_overlayEntry != null)
                    ? EditableText(
                        key: widget.key1,
                        style: GAppStyle.style12w400(),
                        controller: _searchTextController,
                        cursorColor: primaryColor,
                        cursorHeight: 18,
                        focusNode: _searchFocusNode,
                        backgroundCursorColor: Colors.transparent,
                        onChanged: (str) {
                          if (str.isEmpty) {
                            setState(() {
                              decoration =
                                  widget.decoration ??
                                  const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    suffixIcon: Icon(Icons.arrow_drop_down),
                                  );
                            });
                          } else {
                            setState(() {
                              // Hide the hint if user is typing
                              decoration = decoration.copyWith(hintText: "");
                            });
                          }
                          if (_overlayEntry == null && widget.isDropDownEnabled != false) {
                            _addOverlay();
                          }
                          _onTextChanged(str);
                        },
                        onSubmitted: (str) {
                          _searchTextController.value = const TextEditingValue(text: "");
                          _setValue();
                          _removeOverlay();
                          _widgetFocusNode.unfocus();
                        },
                        onEditingComplete: () {},
                      )
                    : _displayItem ?? Container(),
              );
            },
          ),
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    final renderObject = context.findRenderObject() as RenderBox;
    final Size size = renderObject.size;

    var overlay = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: widget.isCountryDropdown ? 180 : size.width,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: widget.offset != null
                ? widget.offset!
                : ((widgetBottomOffset <= 240)
                      ? Offset(0.0, (_options!.isNotEmpty && _options!.length < 10) ? (_options!.length * -27.5) : -245)
                      : const Offset(0.0, 30)),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromRGBO(255, 255, 255, 1),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(width: 1.5, color: borderColor),
              ),
              child: SizedBox(
                height: widget.isHeightForTransactionType
                    ? 238
                    : widget.dropdownHeight ??
                          ((_options!.length < 10 && _options!.isNotEmpty)
                              ? ((_options!.length <= 5) ? 135 : (_options!.length * 27))
                              : 240),
                child: ValueListenableBuilder(
                  valueListenable: _listItemsValueNotifier,
                  builder: (context, List<T> items, child) {
                    if (_options != null && _options!.isNotEmpty) {
                      return ListView.builder(
                        controller: controller,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: _options!.length,
                        itemBuilder: (context, position) {
                          T item = _options![position];
                          bool isCreate = false;
                          bool isEmpty = false;
                          int createId = 0;
                          String createText = "";

                          // Some “create item” logic
                          if (widget.allowCreate) {
                            if (item is Map) {
                              if (item[widget.objectIDName] == -1010 ||
                                  item[widget.objectIDName] == -1011 ||
                                  item[widget.objectIDName] == -1012 ||
                                  item[widget.objectIDName] == -1013 ||
                                  item[widget.objectIDName] == -1020) {
                                isCreate = true;
                                if (item[widget.objectIDName] == -1013) {
                                  isEmpty = true;
                                }
                                createId = item[widget.objectIDName];
                                createText = item[widget.objectName];
                              }
                            }
                          }

                          ListTile listTile = widget.dropdownItemFn(
                            item,
                            position,
                            position == _listItemFocusedPosition,
                            (widget.selectedFn ?? _selectedFn)(_selectedItem, item),
                            // 3) Re-order: call _setValue() first, then _removeOverlay()
                            () {
                              overlayTapped.value = true;
                              _listItemFocusedPosition = position;
                              _searchTextController.value = const TextEditingValue(text: "");

                              // If it’s a normal item, we set the value right now
                              // so the selection is not lost
                              _setValue();
                              _removeOverlay();
                            },
                          );

                          return AutoScrollTag(
                            key: ValueKey(position),
                            controller: controller,
                            index: position,

                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: listTile.onTap,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: (_listItemFocusedPosition == position)
                                        ? lightBackgroundColor
                                        : (isCreate)
                                        ? lightBackgroundColor
                                        : Colors.transparent,
                                    border: Border(
                                      bottom: BorderSide(
                                        color: listTile.onTap != null ? borderColor : Colors.transparent,
                                        width: 0.5,
                                      ),
                                    ),
                                  ),
                                  child: isCreate
                                      ? Row(
                                          children: [
                                            if (!isEmpty)
                                              const Icon(BootstrapIcons.plus_circle, color: primaryColor, size: 14),
                                            if (!isEmpty) GSizeW(4),
                                            Expanded(
                                              child: Text(
                                                createText,
                                                style: GDropDownTheme.dropDownItemStyle().copyWith(
                                                  color: (isEmpty) ? bodyTextDark : primaryColor,
                                                  fontWeight: (isEmpty) ? FontWeight.w400 : FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : listTile.title,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Material(
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GBodyText(widget.emptyText),
                              // Possibly show a “Create new item” button, etc.
                            ],
                          ),
                        ),
                      );
                    }
                  },
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
            // Unfocus everything and remove overlay
            _widgetFocusNode.unfocus();
            _searchFocusNode.unfocus();
            _removeOverlay();
          },
          behavior: HitTestBehavior.translucent,
          child: Container(color: Colors.transparent),
        ),
      ),
    );
  }

  void _addOverlay() {
    if (_overlayEntry == null) {
      // 4) Optionally remove or comment out the requestFocus() line
      // if it’s causing immediate focus-lost upon mouse click
      // _searchFocusNode.requestFocus();

      _search("");
      _overlayBackdropEntry = _createBackdropOverlay();
      _overlayEntry = _createOverlayEntry();
      if (_overlayEntry != null) {
        Overlay.of(context).insertAll([_overlayBackdropEntry!, _overlayEntry!]);
        setState(() {
          // If you do want the user to start typing right away,
          // keep this requestFocus.
          _searchFocusNode.requestFocus();
        });
      }
    }
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _overlayBackdropEntry!.remove();
      _overlayEntry!.remove();
      _overlayEntry = null;
      setState(() {});
    }
  }

  void _toggleOverlay() {
    if (_overlayEntry == null && widget.isDropDownEnabled != false) {
      _addOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _onTextChanged(String? str) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 50), () {
      if (_lastSearchString != str) {
        _lastSearchString = str;
        _search(str ?? "");
      }
    });
  }

  KeyEventResult _onKeyPressed(RawKeyEvent event) {
    if (event.isKeyPressed(LogicalKeyboardKey.enter)) {
      _searchTextController.value = const TextEditingValue(text: "");
      _removeOverlay();
      return KeyEventResult.ignored;
    } else if (event.isKeyPressed(LogicalKeyboardKey.escape)) {
      _searchTextController.value = const TextEditingValue(text: "");
      _removeOverlay();
      _widgetFocusNode.unfocus();
      _searchFocusNode.unfocus();
      return KeyEventResult.ignored;
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
      int v = _listItemFocusedPosition;
      v++;
      if (v >= _options!.length) v = 0;
      var item = _options![v];
      if (item is Map) {
        if ((widget.listForSkip ?? []).contains(item[widget.objectIDName])) {
          v++;
        }
      }
      _listItemFocusedPosition = v;
      _listItemsValueNotifier.value = List<T>.from(_options ?? []);
      controller.scrollToIndex(_listItemFocusedPosition, preferPosition: AutoScrollPosition.end);
      return KeyEventResult.handled;
    } else if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
      int v = _listItemFocusedPosition;
      v--;
      if (v < 0) v = _options!.length - 1;
      var item = _options![v];
      if (item is Map) {
        if ((widget.listForSkip ?? []).contains(item[widget.objectIDName])) {
          v--;
        }
      }
      _listItemFocusedPosition = v;
      _listItemsValueNotifier.value = List<T>.from(_options ?? []);
      controller.scrollToIndex(_listItemFocusedPosition, preferPosition: AutoScrollPosition.end);
      return KeyEventResult.handled;
    } else if (event.isShiftPressed && event.isKeyPressed(LogicalKeyboardKey.tab)) {
      gLogger("User press shift + tab============================");
      // _removeOverlay();

      FocusScope.of(context).previousFocus();
      // return KeyEventResult.handled;
      return KeyEventResult.ignored;
    } else if (event.isKeyPressed(LogicalKeyboardKey.tab)) {
      gLogger("User press tab============================");

      _removeOverlay();
      return KeyEventResult.ignored;
    }

    return KeyEventResult.ignored;
  }

  void _search(String str) async {
    if (str.isNotEmpty) {
      setState(() {});
    }
    List<T> items = await widget.findFn(str) as List<T>;

    if (str.isNotEmpty && widget.filterFn != null) {
      items = items.where((item) => widget.filterFn!(item, str)).toList();
    }

    // “Create item” logic, if desired
    if (widget.allowCreate) {
      gLogger("data is here 1 $items widget.objectIDName = ${widget.objectIDName}");
      // bool hasCreateAndEditItem = items.any((item) => (item as Map)[widget.objectIDName] == -1011);
      // bool hasCreateNewItem = items.any((item) => (item as Map)[widget.objectIDName] == -1012);
      if (widget.showAddLink == true && (items.any((item) => (item as Map)[widget.objectIDName] == -1020) == false)) {
        items.add(
          {
                widget.objectIDName: -1020,
                widget.objectName: widget.showAddLink ? "Add Account" : '${widget.textonEmptyActionPressed} $str',
              }
              as T,
        );
      }

      gLogger("data is here 2");
      if (_searchTextController.text.isEmpty && items.isEmpty) {
        gLogger("data is here 3");
        if (!items.any((item) => (item as Map)[widget.objectIDName] == -1012)) {
          gLogger("data is here 4");
          if (widget.isAllowCreateAndEdit || widget.isAllowOnlyCreate) {
            gLogger("data is here 5");
            items.add({widget.objectIDName: -1011, widget.objectName: '${widget.textonEmptyActionPressed} $str'} as T);
          }
          if (items.isEmpty) {
            gLogger("data is here 6");
            items.add({widget.objectIDName: -1013, widget.objectName: 'No Item Found...'} as T);
          }
        }
      } else {
        gLogger("data is here 7");
        items.removeWhere((item) => (item as Map)[widget.objectIDName] == -1013);
        if (!items.any((item) => (item as Map)[widget.objectIDName] == -1011)) {
          gLogger("data is here 8");
          if (widget.isAllowOnlyCreate && _searchTextController.text.isNotEmpty) {
            items.add({widget.objectIDName: -1010, widget.objectName: '   Create "$str"'} as T);
          } else if (widget.isAllowOnlyCreate && _searchTextController.text.isEmpty) {
            items.add({widget.objectIDName: -1010, widget.objectName: '   Create "$str"'} as T);
          }
          if (widget.isAllowCreateAndEdit && _searchTextController.text.isNotEmpty) {
            items.add(
              {widget.objectIDName: -1011, widget.objectName: '${widget.textonEmptyActionPressed} "$str"'} as T,
            );
          } else if (widget.isAllowCreateAndEdit && _searchTextController.text.isEmpty) {
            items.add({widget.objectIDName: -1011, widget.objectName: '${widget.textonEmptyActionPressed} $str'} as T);
          }
        }
      }
    }

    _options = items;
    _listItemsValueNotifier.value = items;
  }

  String? extractString(String input) {
    final RegExp regExp = RegExp(r'"(.*?)"');
    final match = regExp.firstMatch(input);
    if (match != null) {
      return match.group(1); // returns the data inside the quotes
    }
    return null;
  }

  void _setValue() {
    var item = _options![_listItemFocusedPosition];
    if (item is Map) {
      gLogger("item is in drop down $item");
      gLogger("item is in drop down ${item[widget.objectIDName]} and ${widget.objectIDName}");
      // if ((widget.listForSkip ?? []).contains(item[widget.objectIDName])) {
      //   return;
      // }
      if (item[widget.objectIDName] == -1010 ||
          item[widget.objectIDName] == -1011 ||
          item[widget.objectIDName] == -1012 ||
          item[widget.objectIDName] == -1013 ||
          item[widget.objectIDName] == -1020) {
        if (widget.onPressedOFEmptyAction != null) {
          if ((item[widget.objectIDName] == -1013)) {
            // do nothing if "No item found"
          } else {
            widget.onPressedOFEmptyAction!(
              (item[widget.objectIDName] == -1010) ? false : true,
              item[widget.objectName] == null ? "" : extractString(item[widget.objectName]) ?? "",
            );
          }
        }
        return;
      }
    }

    _selectedItem = item;
    _effectiveController!.value = _selectedItem;

    if (widget.onChanged != null) {
      widget.onChanged!(_selectedItem);
    }
    setState(() {});
  }

  void _clearValue() {
    _effectiveController!.value = null;
    if (widget.onChanged != null) {
      widget.onChanged!(_selectedItem);
    }
    _searchTextController.value = const TextEditingValue(text: "");
  }
}
