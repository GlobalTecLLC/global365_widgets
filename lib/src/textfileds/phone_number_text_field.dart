import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/constants/constants.dart';

class GCustomPhoneNumberField extends StatefulWidget {
  final String? label;
  // final String? initialCountryCode;
  final Function(String phoneNumber, String countryCode, bool isValid)? onChanged;
  final int minLength;
  final int maxLength;
  final bool isShowHeading;
  final bool isRequired;
  final bool isPhoneEnabled;
  final bool isCountryEnabled;

  final CustomPhoneNumberController controller;

  const GCustomPhoneNumberField({
    Key? key,
    this.label,
    this.isShowHeading = true,
    this.isRequired = false,
    // this.initialCountryCode,
    required this.controller,
    this.onChanged,
    this.minLength = 10,
    this.maxLength = 11,
    this.isPhoneEnabled = true,
    this.isCountryEnabled = true,
  }) : super(key: key);

  @override
  State<GCustomPhoneNumberField> createState() => _GCustomPhoneNumberFieldState();
}

class _GCustomPhoneNumberFieldState extends State<GCustomPhoneNumberField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNodeSearch = FocusNode();
  final FocusNode _focusNodePhoneNumber = FocusNode();
  OverlayEntry? _overlayEntry;
  OverlayEntry? _overlayBackdropEntry;
  final LayerLink _layerLink = LayerLink();

  String _selectedCountryCode = "+1";

  // Full list of 195 countries with codes, names, and basic phone formats.
  // For production, prefer using a package or importing a JSON file.
  // Formats and min/max lengths are approximate and may need adjustment per country.

  List<Map<String, dynamic>> filteredCountries = [];
  int _highlightedIndex = -1;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);

    // Set initial country code if provided
    if (widget.controller.countryCode.isNotEmpty) {
      final found = CountiresList.countries.firstWhere(
        (c) => c["code"] == widget.controller.countryCode,
        orElse: () => CountiresList.countries.first,
      );
      _selectedCountryCode = found["code"];
    }

    // Set and format initial phone number if provided
    if (widget.controller.phoneNumber.isNotEmpty) {
      final currentCountry = CountiresList.countries.firstWhere(
        (c) => c["code"] == _selectedCountryCode,
        orElse: () => CountiresList.countries.first,
      );

      // Extract digits and format according to country
      String digits = widget.controller.phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
      String formatted = _applyFormat(digits, currentCountry["format"], currentCountry["max"]);
      _controller.text = formatted;
    }

    filteredCountries = List.from(CountiresList.countries);
  }

  _onControllerChanged() {
    if (widget.controller.phoneNumber != _controller.text) {
      // Update phone number text
      _controller.text = widget.controller.phoneNumber;
    }
    if (widget.controller.countryCode != _selectedCountryCode) {
      // Update selected country code
      final found = CountiresList.countries.firstWhere(
        (c) => c["code"] == widget.controller.countryCode,
        orElse: () => CountiresList.countries.first,
      );
      if (mounted) {
        setState(() {
          _selectedCountryCode = found["code"];
        });
      }

      // Format existing number for new country
      _formatNumberForCountry(found);
    }
  }

  /// --- Overlay ---
  void _showOverlay() {
    if (_overlayEntry != null) return; // Prevent multiple overlays
    _overlayEntry = _createOverlayEntry();
    _overlayBackdropEntry = _createBackdropOverlay();
    Overlay.of(context).insertAll([_overlayBackdropEntry!, _overlayEntry!]);
  }

  void _removeOverlay() {
    if (_overlayEntry != null) {
      _focusNodeSearch.unfocus();
      _focusNodePhoneNumber.requestFocus();
      _overlayBackdropEntry!.remove();
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
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

            _removeOverlay();
          },
          behavior: HitTestBehavior.translucent,
          child: Container(color: Colors.transparent),
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      // Return a dummy overlay if renderBox is null
      return OverlayEntry(builder: (context) => const SizedBox.shrink());
    }

    Size size = renderBox.size;
    filteredCountries = List.from(CountiresList.countries);

    _focusNodeSearch.requestFocus();

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height - 12),
          child: Material(
            borderRadius: BorderRadius.circular(8),
            elevation: 4,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: borderColor, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 40,
                    child: TextField(
                      focusNode: _focusNodeSearch,
                      autofocus: true,
                      style: GAppStyle.style14w500(color: bodyTextDark),
                      decoration: const InputDecoration(hintText: "Search country", border: OutlineInputBorder(), isDense: true),
                      onChanged: (value) {
                        setState(() {
                          filteredCountries = CountiresList.countries
                              .where((c) => c["name"].toLowerCase().contains(value.toLowerCase()) || c["code"].contains(value))
                              .toList();
                          _highlightedIndex = filteredCountries.isNotEmpty ? 0 : -1;
                        });
                        _overlayEntry?.markNeedsBuild();
                      },
                      onSubmitted: (_) {
                        if (_highlightedIndex >= 0 && _highlightedIndex < filteredCountries.length) {
                          _selectCountry(filteredCountries[_highlightedIndex]);
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 250),
                    child: StatefulBuilder(
                      builder: (context, setStateList) {
                        return filteredCountries.isEmpty
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const SizedBox(height: 20),
                                  Text("No countries found", style: TextStyle(color: Colors.grey[600])),
                                ],
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: filteredCountries.length,
                                itemBuilder: (context, index) {
                                  final c = filteredCountries[index];
                                  final isHighlighted = (c["code"] == _selectedCountryCode);
                                  return InkWell(
                                    onTap: () {
                                      _selectCountry(c);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: isHighlighted ? lightBackgroundColor : Colors.transparent,
                                        border: const Border(bottom: BorderSide(color: borderColor, width: 1)),
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: Text(
                                        "${c['code']}  ${c['name']}",
                                        style: TextStyle(fontSize: 12, color: isHighlighted ? primaryColor : bodyTextDark),
                                      ),
                                    ),
                                  );
                                },
                              );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// --- Select Country ---
  void _selectCountry(Map<String, dynamic> country) {
    setState(() {
      _selectedCountryCode = country["code"];
    });

    // Format existing number for new country
    _formatNumberForCountry(country);

    _removeOverlay();
  }

  /// --- Phone Number Formatter ---
  String _applyFormat(String input, String format, int maxLength) {
    // Remove all non-digit characters
    String digits = input.replaceAll(RegExp(r'[^\d]'), '');
    String result = "";
    int digitIndex = 0;

    if (digits.length > maxLength) {
      digits = digits.substring(0, maxLength);
    }
    for (int i = 0; i < format.length && digitIndex < digits.length; i++) {
      if (format[i] == "X") {
        result += digits[digitIndex];
        digitIndex++;
      } else {
        result += format[i];
      }
    }
    return result;
  }

  /// --- Format existing number for new country ---
  void _formatNumberForCountry(Map<String, dynamic> country) {
    if (_controller.text.isNotEmpty) {
      // Get only digits from current number
      String digits = _controller.text.replaceAll(RegExp(r'[^\d]'), '');

      // Apply new country format
      String formatted = _applyFormat(digits, country["format"], country["max"]);

      setState(() {
        _controller.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      });
      widget.controller.update(
        countryCode: _selectedCountryCode,
        phoneNumber: formatted,
        isValid: CountiresList.isValidNumber(formatted, _selectedCountryCode),
      );
      // Notify parent of change
      if (widget.onChanged != null) {
        widget.onChanged!(formatted, country["code"], CountiresList.isValidNumber(formatted, country["code"]));
      }
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    _controller.dispose();
    _focusNode.dispose();
    widget.controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentCountry = CountiresList.countries.firstWhere(
      (c) => c["code"] == _selectedCountryCode,
      orElse: () => CountiresList.countries.first,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.isShowHeading)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.label ?? "Phone Number",
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: bodyTextDark),
              ),
              if (widget.isRequired)
                const Text(
                  " *",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.red),
                ),
            ],
          ),
        if (widget.isShowHeading) const SizedBox(height: 4),
        KeyboardListener(
          focusNode: _focusNode,
          onKeyEvent: (KeyEvent event) {
            if (event is KeyDownEvent && _overlayEntry != null) {
              if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                setState(() {
                  if (filteredCountries.isNotEmpty) {
                    _highlightedIndex = (_highlightedIndex + 1) % filteredCountries.length;
                  }
                });
                _overlayEntry?.markNeedsBuild();
              } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                setState(() {
                  if (filteredCountries.isNotEmpty) {
                    _highlightedIndex = (_highlightedIndex - 1 + filteredCountries.length) % filteredCountries.length;
                  }
                });
                _overlayEntry?.markNeedsBuild();
              } else if (event.logicalKey == LogicalKeyboardKey.enter &&
                  _highlightedIndex >= 0 &&
                  _highlightedIndex < filteredCountries.length) {
                _selectCountry(filteredCountries[_highlightedIndex]);
              } else if (event.logicalKey == LogicalKeyboardKey.escape) {
                _removeOverlay();
              }
            }
          },
          child: CompositedTransformTarget(
            link: _layerLink,
            child: SizedBox(
              height: 40, // Fixed height to prevent RenderFlex overflow
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IntrinsicWidth(
                      child: InkWell(
                        onTap: widget.isCountryEnabled
                            ? () {
                                if (_overlayEntry == null) {
                                  _showOverlay();
                                } else {
                                  _removeOverlay();
                                }
                              }
                            : null,
                        child: Container(
                          // height: 42,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          decoration: BoxDecoration(
                            color: lightBackgroundColor,
                            border: Border.all(color: borderColor),
                            borderRadius: const BorderRadius.only(topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
                          ),
                          child: Center(
                            child: Text(_selectedCountryCode, style: const TextStyle(fontSize: 12, color: bodyTextDark)),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: TextField(
                          controller: _controller,
                          focusNode: _focusNodePhoneNumber,
                          enabled: widget.isPhoneEnabled,
                          keyboardType: TextInputType.phone,
                          textDirection: TextDirection.ltr,
                          style: GAppStyle.style14w500(color: bodyTextDark),
                          inputFormatters: [
                            // LengthLimitingTextInputFormatter(currentCountry["max"]), // Max length based on selected country
                            FilteringTextInputFormatter.allow(RegExp(r'[\d\s\(\)\-]')), // Allow digits and formatting chars
                          ],
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: borderColor),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
                            ),
                            hintText: "Enter phone number",
                            hintStyle: TextStyle(
                              color: placeHolderColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Montserrat",
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: borderColor),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 13),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(width: 1, color: borderColor),
                              borderRadius: BorderRadius.only(topRight: Radius.circular(4), bottomRight: Radius.circular(4)),
                            ),
                            isDense: true,
                          ),
                          onChanged: (value) {
                            // Get only digits from input
                            String digits = value.replaceAll(RegExp(r'[^\d]'), '');

                            // Check if within country limits

                            final formatted = _applyFormat(digits, currentCountry["format"], currentCountry["max"]);

                            // Only update if different to avoid cursor jumping
                            if (_controller.text != formatted) {
                              _controller.value = TextEditingValue(
                                text: formatted,
                                selection: TextSelection.collapsed(offset: formatted.length),
                              );
                            }
                            widget.controller.update(
                              countryCode: _selectedCountryCode,
                              phoneNumber: formatted,
                              isValid: CountiresList.isValidNumber(formatted, _selectedCountryCode),
                            );
                            if (widget.onChanged != null) {
                              widget.onChanged!(
                                formatted,
                                _selectedCountryCode,
                                CountiresList.isValidNumber(formatted, _selectedCountryCode),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomPhoneNumberController extends ChangeNotifier {
  String _countryCode;
  String _phoneNumber;
  bool _isValid;

  CustomPhoneNumberController({String countryCode = "+1", String phoneNumber = "", bool isValid = false})
    : _countryCode = countryCode,
      _phoneNumber = phoneNumber,
      _isValid = isValid;

  String get countryCode => _countryCode;
  String get phoneNumber => _phoneNumber;
  bool get isValid => _isValid;

  void update({required String countryCode, required String phoneNumber, bool isValid = false}) {
    if (countryCode.isEmpty) {
      countryCode = "+1";
    }
    _countryCode = countryCode;
    _phoneNumber = phoneNumber;

    _isValid = CountiresList.isValidNumber(phoneNumber, countryCode);
    notifyListeners();
  }

  void clear() {
    _countryCode = "+1";
    _phoneNumber = "";
    _isValid = false;
  }
}

class CountiresList {
  static List<Map<String, dynamic>> get countries => _countries;
  static bool isValidNumber(String number, String countryCode) {
    if (countryCode.isEmpty) return false;
    final country = countries.firstWhere((c) => c["code"] == countryCode);
    // Extract digits from the number
    String digits = number.replaceAll(RegExp(r'[^\d]'), '');

    // Check length constraints
    return digits.length >= country["min"] && digits.length <= country["max"];
  }

  static final List<Map<String, dynamic>> _countries = [
    {"code": "+93", "name": "Afghanistan", "format": "XXX XXX XXXX", "min": 9, "max": 9},
    {"code": "+355", "name": "Albania", "format": "XXX XXX XXXX", "min": 9, "max": 9},
    {"code": "+213", "name": "Algeria", "format": "XXX XXX XXXX", "min": 9, "max": 10},
    {"code": "+376", "name": "Andorra", "format": "XXX XXX", "min": 6, "max": 6},
    {"code": "+244", "name": "Angola", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+1-268", "name": "Antigua and Barbuda", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+54", "name": "Argentina", "format": "XX XXXX XXXX", "min": 10, "max": 10},
    {"code": "+374", "name": "Armenia", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+297", "name": "Aruba", "format": "XXX XXXX", "min": 7, "max": 7},
    {"code": "+61", "name": "Australia", "format": "XXXX XXX XXX", "min": 9, "max": 9},
    {"code": "+43", "name": "Austria", "format": "XXXX XXX XXX", "min": 10, "max": 10},
    {"code": "+994", "name": "Azerbaijan", "format": "XX XXX XX XX", "min": 9, "max": 9},
    {"code": "+1-242", "name": "Bahamas", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+973", "name": "Bahrain", "format": "XXXX XXXX", "min": 8, "max": 8},
    {"code": "+880", "name": "Bangladesh", "format": "XXXX-XXXXXX", "min": 10, "max": 10},
    {"code": "+1-246", "name": "Barbados", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+375", "name": "Belarus", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+32", "name": "Belgium", "format": "XXX XX XX XX", "min": 9, "max": 9},
    {"code": "+501", "name": "Belize", "format": "XXX-XXXX", "min": 7, "max": 7},
    {"code": "+229", "name": "Benin", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+1-441", "name": "Bermuda", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+975", "name": "Bhutan", "format": "XX-XXXXXX", "min": 8, "max": 8},
    {"code": "+591", "name": "Bolivia", "format": "X XXX XXXX", "min": 8, "max": 8},
    {"code": "+387", "name": "Bosnia and Herzegovina", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+267", "name": "Botswana", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+55", "name": "Brazil", "format": "(XX) XXXXX-XXXX", "min": 10, "max": 11},
    {"code": "+246", "name": "British Indian Ocean Territory", "format": "XXX XXXX", "min": 7, "max": 7},
    {"code": "+673", "name": "Brunei", "format": "XXX XXXX", "min": 7, "max": 7},
    {"code": "+359", "name": "Bulgaria", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+226", "name": "Burkina Faso", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+257", "name": "Burundi", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+855", "name": "Cambodia", "format": "XX XXX XXX", "min": 9, "max": 9},
    {"code": "+237", "name": "Cameroon", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+1", "name": "Canada", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+238", "name": "Cape Verde", "format": "XXX XXXX", "min": 7, "max": 7},
    {"code": "+1-345", "name": "Cayman Islands", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+236", "name": "Central African Republic", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+235", "name": "Chad", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+56", "name": "Chile", "format": "X XXXX XXXX", "min": 9, "max": 9},
    {"code": "+86", "name": "China", "format": "XXX XXXX XXXX", "min": 11, "max": 11},
    {"code": "+57", "name": "Colombia", "format": "XXX XXX XXXX", "min": 10, "max": 10},
    {"code": "+269", "name": "Comoros", "format": "XX XXXXX", "min": 7, "max": 7},
    {"code": "+242", "name": "Congo", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+243", "name": "Congo (DRC)", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+682", "name": "Cook Islands", "format": "XX XXX", "min": 5, "max": 5},
    {"code": "+506", "name": "Costa Rica", "format": "XXXX XXXX", "min": 8, "max": 8},
    {"code": "+225", "name": "Côte d'Ivoire", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+385", "name": "Croatia", "format": "XX XXX XXX", "min": 9, "max": 9},
    {"code": "+53", "name": "Cuba", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+357", "name": "Cyprus", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+420", "name": "Czech Republic", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+45", "name": "Denmark", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+253", "name": "Djibouti", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+1-767", "name": "Dominica", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+1-809", "name": "Dominican Republic", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+593", "name": "Ecuador", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+20", "name": "Egypt", "format": "XXX XXX XXXX", "min": 10, "max": 10},
    {"code": "+503", "name": "El Salvador", "format": "XXXX XXXX", "min": 8, "max": 8},
    {"code": "+240", "name": "Equatorial Guinea", "format": "XX XXX XXX", "min": 9, "max": 9},
    {"code": "+291", "name": "Eritrea", "format": "XX XXX XXX", "min": 7, "max": 7},
    {"code": "+372", "name": "Estonia", "format": "XXXX XXXX", "min": 8, "max": 8},
    {"code": "+251", "name": "Ethiopia", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+500", "name": "Falkland Islands", "format": "XXXXX", "min": 5, "max": 5},
    {"code": "+298", "name": "Faroe Islands", "format": "XXX XXX", "min": 6, "max": 6},
    {"code": "+679", "name": "Fiji", "format": "XXX XXXX", "min": 7, "max": 7},
    {"code": "+358", "name": "Finland", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+33", "name": "France", "format": "X XX XX XX XX", "min": 9, "max": 9},
    {"code": "+594", "name": "French Guiana", "format": "XXX XX XX XX", "min": 9, "max": 9},
    {"code": "+689", "name": "French Polynesia", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+241", "name": "Gabon", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+220", "name": "Gambia", "format": "XXX XXXX", "min": 7, "max": 7},
    {"code": "+995", "name": "Georgia", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+49", "name": "Germany", "format": "XXXX XXXXXXX", "min": 10, "max": 11},
    {"code": "+233", "name": "Ghana", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+350", "name": "Gibraltar", "format": "XXX XXXX", "min": 7, "max": 7},
    {"code": "+30", "name": "Greece", "format": "XXX XXX XXXX", "min": 10, "max": 10},
    {"code": "+299", "name": "Greenland", "format": "XX XX XX", "min": 6, "max": 6},
    {"code": "+1-473", "name": "Grenada", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+590", "name": "Guadeloupe", "format": "XXX XX XX XX", "min": 9, "max": 9},
    {"code": "+1-671", "name": "Guam", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+502", "name": "Guatemala", "format": "XXXX XXXX", "min": 8, "max": 8},
    {"code": "+224", "name": "Guinea", "format": "XX XXX XXX", "min": 9, "max": 9},
    {"code": "+245", "name": "Guinea-Bissau", "format": "XX XXX XXX", "min": 9, "max": 9},
    {"code": "+592", "name": "Guyana", "format": "XXX XXXX", "min": 7, "max": 7},
    {"code": "+509", "name": "Haiti", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+504", "name": "Honduras", "format": "XXXX-XXXX", "min": 8, "max": 8},
    {"code": "+852", "name": "Hong Kong", "format": "XXXX XXXX", "min": 8, "max": 8},
    {"code": "+36", "name": "Hungary", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+354", "name": "Iceland", "format": "XXX XXXX", "min": 7, "max": 7},
    {"code": "+91", "name": "India", "format": "XXXXX-XXXXX", "min": 10, "max": 10},
    {"code": "+62", "name": "Indonesia", "format": "XXX-XXXX-XXXX", "min": 10, "max": 12},
    {"code": "+98", "name": "Iran", "format": "XXX XXX XXXX", "min": 10, "max": 10},
    {"code": "+964", "name": "Iraq", "format": "XXX XXX XXXX", "min": 10, "max": 10},
    {"code": "+353", "name": "Ireland", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+972", "name": "Israel", "format": "XX-XXX-XXXX", "min": 9, "max": 9},
    {"code": "+39", "name": "Italy", "format": "XXX XXX XXXX", "min": 10, "max": 10},
    {"code": "+1-876", "name": "Jamaica", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+81", "name": "Japan", "format": "XX-XXXX-XXXX", "min": 10, "max": 10},
    {"code": "+962", "name": "Jordan", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+7", "name": "Kazakhstan", "format": "XXX XXX XXXX", "min": 10, "max": 10},
    {"code": "+254", "name": "Kenya", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+686", "name": "Kiribati", "format": "XXX XXX", "min": 6, "max": 6},
    {"code": "+965", "name": "Kuwait", "format": "XXXX XXXX", "min": 8, "max": 8},
    {"code": "+996", "name": "Kyrgyzstan", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+856", "name": "Laos", "format": "XX XXX XXX", "min": 9, "max": 9},
    {"code": "+371", "name": "Latvia", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+961", "name": "Lebanon", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+266", "name": "Lesotho", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+231", "name": "Liberia", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+218", "name": "Libya", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+423", "name": "Liechtenstein", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+370", "name": "Lithuania", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+352", "name": "Luxembourg", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+853", "name": "Macau", "format": "XXXX XXXX", "min": 8, "max": 8},
    {"code": "+389", "name": "Macedonia", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+261", "name": "Madagascar", "format": "XX XX XXX XX", "min": 9, "max": 9},
    {"code": "+265", "name": "Malawi", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+60", "name": "Malaysia", "format": "XXX-XXXXXXX", "min": 9, "max": 10},
    {"code": "+960", "name": "Maldives", "format": "XXX-XXXX", "min": 7, "max": 7},
    {"code": "+223", "name": "Mali", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+356", "name": "Malta", "format": "XXXX XXXX", "min": 8, "max": 8},
    {"code": "+692", "name": "Marshall Islands", "format": "XXX-XXXX", "min": 7, "max": 7},
    {"code": "+596", "name": "Martinique", "format": "XXX XX XX XX", "min": 9, "max": 9},
    {"code": "+222", "name": "Mauritania", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+230", "name": "Mauritius", "format": "XXX XXXX", "min": 7, "max": 7},
    {"code": "+52", "name": "Mexico", "format": "XX XXXX XXXX", "min": 10, "max": 10},
    {"code": "+691", "name": "Micronesia", "format": "XXX-XXXX", "min": 7, "max": 7},
    {"code": "+373", "name": "Moldova", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+377", "name": "Monaco", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+976", "name": "Mongolia", "format": "XX XX XXXX", "min": 8, "max": 8},
    {"code": "+382", "name": "Montenegro", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+1-664", "name": "Montserrat", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+212", "name": "Morocco", "format": "XX XX XX XX XX", "min": 9, "max": 10},
    {"code": "+258", "name": "Mozambique", "format": "XX XXX XXX", "min": 9, "max": 9},
    {"code": "+95", "name": "Myanmar", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+264", "name": "Namibia", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+674", "name": "Nauru", "format": "XXX XXX", "min": 6, "max": 6},
    {"code": "+977", "name": "Nepal", "format": "XX-XXXXXXX", "min": 9, "max": 10},
    {"code": "+31", "name": "Netherlands", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+687", "name": "New Caledonia", "format": "XX XX XX", "min": 6, "max": 6},
    {"code": "+64", "name": "New Zealand", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+505", "name": "Nicaragua", "format": "XXXX XXXX", "min": 8, "max": 8},
    {"code": "+227", "name": "Niger", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+234", "name": "Nigeria", "format": "XXX XXX XXXX", "min": 10, "max": 10},
    {"code": "+683", "name": "Niue", "format": "XXX XXX", "min": 6, "max": 6},
    {"code": "+672", "name": "Norfolk Island", "format": "XXX XXX", "min": 6, "max": 6},
    {"code": "+850", "name": "North Korea", "format": "XXX XXX XXXX", "min": 10, "max": 10},
    {"code": "+47", "name": "Norway", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+968", "name": "Oman", "format": "XXXX XXXX", "min": 8, "max": 8},
    {"code": "+92", "name": "Pakistan", "format": "XXX XXX XXXX", "min": 9, "max": 10},
    {"code": "+680", "name": "Palau", "format": "XXX-XXXX", "min": 7, "max": 7},
    {"code": "+970", "name": "Palestine", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+507", "name": "Panama", "format": "XXXX-XXXX", "min": 8, "max": 8},
    {"code": "+675", "name": "Papua New Guinea", "format": "XXX XXXX", "min": 7, "max": 7},
    {"code": "+595", "name": "Paraguay", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+51", "name": "Peru", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+63", "name": "Philippines", "format": "XXX XXX XXXX", "min": 10, "max": 10},
    {"code": "+48", "name": "Poland", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+351", "name": "Portugal", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+1-787", "name": "Puerto Rico", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+974", "name": "Qatar", "format": "XXXX XXXX", "min": 8, "max": 8},
    {"code": "+40", "name": "Romania", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+7", "name": "Russia", "format": "XXX XXX XXXX", "min": 10, "max": 10},
    {"code": "+250", "name": "Rwanda", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+1-869", "name": "Saint Kitts and Nevis", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+1-758", "name": "Saint Lucia", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+1-784", "name": "Saint Vincent and the Grenadines", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+685", "name": "Samoa", "format": "XX XXXX", "min": 6, "max": 7},
    {"code": "+378", "name": "San Marino", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+239", "name": "Sao Tome and Principe", "format": "XX XXX XXX", "min": 9, "max": 9},
    {"code": "+966", "name": "Saudi Arabia", "format": "XXX XXX XXXX", "min": 9, "max": 9},
    {"code": "+221", "name": "Senegal", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+381", "name": "Serbia", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+248", "name": "Seychelles", "format": "XXX XXXX", "min": 7, "max": 7},
    {"code": "+232", "name": "Sierra Leone", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+65", "name": "Singapore", "format": "XXXX XXXX", "min": 8, "max": 8},
    {"code": "+421", "name": "Slovakia", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+386", "name": "Slovenia", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+677", "name": "Solomon Islands", "format": "XXX XXXX", "min": 7, "max": 7},
    {"code": "+252", "name": "Somalia", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+27", "name": "South Africa", "format": "XXX XXX XXXX", "min": 9, "max": 9},
    {"code": "+82", "name": "South Korea", "format": "XX-XXXX-XXXX", "min": 10, "max": 10},
    {"code": "+211", "name": "South Sudan", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+34", "name": "Spain", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+94", "name": "Sri Lanka", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+1-868", "name": "Trinidad and Tobago", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+249", "name": "Sudan", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+597", "name": "Suriname", "format": "XXX-XXXX", "min": 7, "max": 7},
    {"code": "+268", "name": "Swaziland", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+46", "name": "Sweden", "format": "XX-XXX XX XX", "min": 9, "max": 10},
    {"code": "+41", "name": "Switzerland", "format": "XX XXX XX XX", "min": 9, "max": 9},
    {"code": "+963", "name": "Syria", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+886", "name": "Taiwan", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+992", "name": "Tajikistan", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+255", "name": "Tanzania", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+66", "name": "Thailand", "format": "XX-XXX-XXXX", "min": 9, "max": 9},
    {"code": "+228", "name": "Togo", "format": "XX XX XX XX", "min": 8, "max": 8},
    {"code": "+676", "name": "Tonga", "format": "XXX XXX", "min": 6, "max": 6},
    {"code": "+1-868", "name": "Trinidad and Tobago", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+216", "name": "Tunisia", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+90", "name": "Turkey", "format": "XXX XXX XXXX", "min": 10, "max": 10},
    {"code": "+993", "name": "Turkmenistan", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+1-649", "name": "Turks and Caicos Islands", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+688", "name": "Tuvalu", "format": "XXX XXX", "min": 6, "max": 6},
    {"code": "+256", "name": "Uganda", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+380", "name": "Ukraine", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+971", "name": "United Arab Emirates", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+44", "name": "United Kingdom", "format": "XXXX XXX XXXX", "min": 10, "max": 10},
    {"code": "+1", "name": "United States", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+598", "name": "Uruguay", "format": "XX XXX XXX", "min": 8, "max": 8},
    {"code": "+998", "name": "Uzbekistan", "format": "XX XXX XXXX", "min": 9, "max": 9},
    {"code": "+678", "name": "Vanuatu", "format": "XXX XXX", "min": 6, "max": 6},
    {"code": "+58", "name": "Venezuela", "format": "XXX-XXX-XXXX", "min": 10, "max": 10},
    {"code": "+84", "name": "Vietnam", "format": "XXX XXX XXXX", "min": 10, "max": 10},
    {"code": "+1-284", "name": "British Virgin Islands", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+1-340", "name": "U.S. Virgin Islands", "format": "(XXX) XXX XXXX", "min": 10, "max": 10},
    {"code": "+681", "name": "Wallis and Futuna", "format": "XX XX XX", "min": 6, "max": 6},
    {"code": "+967", "name": "Yemen", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+260", "name": "Zambia", "format": "XXX XXX XXX", "min": 9, "max": 9},
    {"code": "+263", "name": "Zimbabwe", "format": "XX XXX XXX", "min": 9, "max": 9},
  ];
}
