import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:global365_widgets/global365_widgets.dart';
import 'package:global365_widgets/src/constants/constants.dart';
import 'package:global365_widgets/src/theme/theme_export.dart';

class USPhoneNumberField extends StatefulWidget {
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final bool isRequired;
  final bool isshowHelp;
  final String? helpText;
  final bool enabled;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? errorText;
  final bool showError;
  final bool showheading;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? errorBorderColor;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  const USPhoneNumberField({
    Key? key,
    this.onChanged,
    this.onSubmitted,
    this.initialValue,
    this.hintText = 'Enter phone number',
    this.labelText = 'Phone Number',
    this.isRequired = false,
    this.isshowHelp = false,
    this.helpText,
    this.enabled = true,
    this.showheading = true,
    this.textInputAction,
    this.focusNode,
    this.controller,
    this.errorText,
    this.showError = true,
    this.borderColor,
    this.focusBorderColor,
    this.errorBorderColor,
    this.borderRadius = 5.0,
    this.contentPadding,
  }) : super(key: key);

  @override
  State<USPhoneNumberField> createState() => _USPhoneNumberFieldState();
}

class _USPhoneNumberFieldState extends State<USPhoneNumberField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  bool _isFocused = false;
  String? _internalError;

  // US phone number formatting
  static const String _usCountryCode = '+1';
  static const String _usFlag = '🇺🇸';
  static const String _phoneFormat = '(###) ###-####';
  static const int _maxLength = 10; // Digits only

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    if (widget.initialValue != null) {
      _controller.text = _formatPhoneNumber(widget.initialValue!);
    }

    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  String _formatPhoneNumber(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.isEmpty) return '';

    String formatted = '';
    for (int i = 0; i < digitsOnly.length && i < _maxLength; i++) {
      if (i == 0) {
        formatted += '(${digitsOnly[i]}';
      } else if (i == 3) {
        formatted += ') ${digitsOnly[i]}';
      } else if (i == 6) {
        formatted += '-${digitsOnly[i]}';
      } else {
        formatted += digitsOnly[i];
      }
    }

    return formatted;
  }

  Color _getBorderColor() {
    return widget.borderColor ?? Colors.grey[300]!;
  }

  String? _getErrorText() {
    return widget.errorText ?? _internalError;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showheading)
          Row(
            children: [
              GTextHeading5(widget.labelText.toString()),
              if (widget.isRequired) GTextHeading5(" *", color: Colors.red),
              if (widget.isshowHelp)
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("help"),
                        content: Text(widget.helpText ?? "No Content Provided by GLOBAL365 - Books"),
                        actions: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                              child: Text("Ok"),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Icon(Icons.help, size: 15),
                ),
            ],
          ),

        if (widget.showheading) GSizeH(5),
        Container(
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: _getBorderColor(), width: 1.0),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Row(
            children: [
              // US Flag and Country Code
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(widget.borderRadius),
                    bottomLeft: Radius.circular(widget.borderRadius),
                  ),
                  border: Border(right: BorderSide(color: borderColor)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [Text(_usFlag, style: const TextStyle(fontSize: 24))],
                ),
              ),
              // Phone Number Input
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  keyboardType: TextInputType.phone,
                  textInputAction: widget.textInputAction,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(_maxLength),
                    _PhoneNumberFormatter(),
                  ],
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
                    border: InputBorder.none,
                    contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  style: GAppStyle.style14w400(color: bodyTextDark),
                  onFieldSubmitted: widget.onSubmitted,
                ),
              ),
            ],
          ),
        ),

        // Error Message
      ],
    );
  }
}

// Custom formatter for US phone numbers
class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (digitsOnly.isEmpty) {
      return const TextEditingValue();
    }

    String formatted = '';
    for (int i = 0; i < digitsOnly.length && i < 10; i++) {
      if (i == 0) {
        formatted += '(${digitsOnly[i]}';
      } else if (i == 3) {
        formatted += ') ${digitsOnly[i]}';
      } else if (i == 6) {
        formatted += '-${digitsOnly[i]}';
      } else {
        formatted += digitsOnly[i];
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

// Helper widget for validation display
class USPhoneValidator extends StatelessWidget {
  final String phoneNumber;

  const USPhoneValidator({Key? key, required this.phoneNumber}) : super(key: key);

  bool get isValid {
    final digits = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    return digits.length == 10;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: isValid ? Colors.green[50] : Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: isValid ? Colors.green[200]! : Colors.orange[200]!),
      ),
      child: Row(
        children: [
          Icon(isValid ? Icons.check_circle : Icons.info, color: isValid ? Colors.green : Colors.orange, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              isValid ? 'Valid US phone number' : 'Enter a complete 10-digit US phone number',
              style: TextStyle(
                color: isValid ? Colors.green[700] : Colors.orange[700],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
