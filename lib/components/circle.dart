import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final double size;

  /// takes precedence over decoration.color
  final Color color;
  final BoxDecoration decoration;
  final Widget child;

  const Circle({
    Key? key,
    required this.size,
    this.child = const SizedBox.shrink(),
    this.decoration = const BoxDecoration(),
    this.color = const Color(0xFFbbbbbb),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: decoration.copyWith(
        borderRadius: BorderRadius.circular(size / 2),
        color: color,
      ),
      child: child,
    );
  }
}
