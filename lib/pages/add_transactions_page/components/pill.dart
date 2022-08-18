import 'package:flutter/material.dart';
import 'package:kaas/colors.dart';

class Pill extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;
  const Pill({
    Key? key,
    this.selected = false,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        decoration: BoxDecoration(
          color: selected ? yellowLight : const Color(0xFFDBDBDB),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: selected ? yellowText : const Color(0xFF000000),
          ),
        ),
      ),
    );
  }
}
