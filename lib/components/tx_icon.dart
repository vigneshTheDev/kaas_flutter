import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kaas/components/circle.dart';

class TxIcon extends StatelessWidget {
  final bool bordered;
  final bool shadowVisible;
  final double size;
  final Color iconColor;
  final Color bgColor;
  final IconData icon;

  const TxIcon({
    Key? key,
    required this.iconColor,
    required this.bgColor,
    required this.size,
    required this.icon,
    this.bordered = false,
    this.shadowVisible = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Circle(
      size: size,
      color: bgColor,
      decoration: BoxDecoration(
        boxShadow: shadowVisible
            ? [
                BoxShadow(
                    offset: Offset.fromDirection(pi / 2, 2), blurRadius: 2)
              ]
            : [],
      ),
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}
