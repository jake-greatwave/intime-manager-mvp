import 'dart:convert';
import 'package:flutter/material.dart';

class EmpAvatar extends StatelessWidget {
  final String nameChar;
  final String? base64Image;

  const EmpAvatar({
    super.key,
    required this.nameChar,
    this.base64Image,
  });

  @override
  Widget build(BuildContext context) {
    final hasImage =
        base64Image != null && base64Image!.trim().isNotEmpty;

    return SizedBox(
      width: 128,
      height: 128,
      child: Stack(
        children: [
          Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF00A63E), width: 4),
              color: const Color(0xFFF9FAFB),
            ),
            padding: const EdgeInsets.all(4),
            child: ClipOval(
              child: hasImage
                  ? Image.memory(
                      base64Decode(base64Image!.trim()),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => _DefaultAvatar(nameChar),
                    )
                  : _DefaultAvatar(nameChar),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF00A63E),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DefaultAvatar extends StatelessWidget {
  final String nameChar;

  const _DefaultAvatar(this.nameChar);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF00A63E), Color(0xFF008F36)],
        ),
      ),
      child: Center(
        child: Text(
          nameChar,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
