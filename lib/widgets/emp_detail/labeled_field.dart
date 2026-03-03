import 'package:flutter/material.dart';

enum FieldStyle { readOnly, editable, dropdown }

class LabeledField extends StatelessWidget {
  final String label;
  final String value;
  final FieldStyle style;
  final TextEditingController? controller;
  final VoidCallback? onDropdownTap;

  const LabeledField({
    super.key,
    required this.label,
    required this.value,
    this.style = FieldStyle.readOnly,
    this.controller,
    this.onDropdownTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A7282),
            letterSpacing: -0.3125,
          ),
        ),
        const SizedBox(height: 8),
        _buildField(),
      ],
    );
  }

  Widget _buildField() {
    switch (style) {
      case FieldStyle.dropdown:
        return _DropdownField(value: value, onTap: onDropdownTap);
      case FieldStyle.editable:
        return _EditableField(controller: controller, hint: value);
      case FieldStyle.readOnly:
        return _ReadOnlyField(value: value);
    }
  }
}

class _ReadOnlyField extends StatelessWidget {
  final String value;

  const _ReadOnlyField({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63,
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      alignment: Alignment.centerLeft,
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 18,
          color: Color(0xFF1E2939),
          letterSpacing: -0.2,
        ),
      ),
    );
  }
}

class _EditableField extends StatelessWidget {
  final TextEditingController? controller;
  final String hint;

  const _EditableField({this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFF00A63E), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 18,
          color: Color(0xFF1E2939),
          letterSpacing: -0.2,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 18,
            color: const Color(0xFF1E2939).withValues(alpha: 0.4),
            letterSpacing: -0.2,
          ),
          isDense: true,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String value;
  final VoidCallback? onTap;

  const _DropdownField({required this.value, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 63,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFF00A63E), width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            const Icon(
              Icons.keyboard_arrow_down,
              color: Color(0xFF00A63E),
              size: 22,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF1E2939),
                  letterSpacing: -0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
