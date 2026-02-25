import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthCodeInput extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final String? initialValue;

  const AuthCodeInput({
    super.key,
    this.onChanged,
    this.initialValue,
  });

  @override
  State<AuthCodeInput> createState() => _AuthCodeInputState();
}

class _AuthCodeInputState extends State<AuthCodeInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      _controller.text = widget.initialValue!;
    }
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    widget.onChanged?.call(_controller.text);
  }

  String _formatAuthCode(String value) {
    final digitsOnly = value.replaceAll(RegExp(r'[^\d]'), '');
    if (digitsOnly.length > 4) {
      return digitsOnly.substring(0, 4);
    }
    return digitsOnly;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(4),
        TextInputFormatter.withFunction((oldValue, newValue) {
          final formatted = _formatAuthCode(newValue.text);
          return TextEditingValue(
            text: formatted,
            selection: TextSelection.collapsed(offset: formatted.length),
          );
        }),
      ],
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: '0 0 0 0',
        hintStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: Color(0xFF999999),
          letterSpacing: 8,
        ),
        prefixIcon: const Icon(
          Icons.vpn_key,
          color: Color(0xFF999999),
          size: 20,
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF00C637),
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Color(0xFF333333),
        letterSpacing: 8,
      ),
    );
  }
}
