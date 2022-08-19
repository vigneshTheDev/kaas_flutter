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
    const grey = Color(0xFFDBDBDB);
    return InkWell(
      splashColor: yellowLight,
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        decoration: BoxDecoration(
            color: selected ? yellowLight.withAlpha(150) : grey,
            borderRadius: BorderRadius.circular(14),
            border:
                Border.all(color: selected ? yellowText.withAlpha(150) : grey)),
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
